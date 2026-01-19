from mpi4py import MPI
import numpy as np
from dolfinx import mesh, fem, io, plot
from dolfinx.fem import FunctionSpace, Function, Constant, dirichletbc
from dolfinx.mesh import create_box, CellType
from ufl import (VectorElement, FiniteElement, TrialFunction, TestFunction, 
                 dx, inner, grad, sym, Identity, tr, derivative, lhs, rhs)
import ufl
from basix.ufl import element
import matplotlib.pyplot as plt

# Initialize MPI
comm = MPI.COMM_WORLD

class FatigueAnalysis:
    def __init__(self, dimensions, nx):
        """
        Initialize fatigue analysis problem
        
        Parameters:
        dimensions: tuple - domain dimensions (Lx, Ly, Lz)
        nx: int - number of elements in x-direction
        """
        self.dim = len(dimensions)
        self.dimensions = dimensions
        
        # Create mesh
        if self.dim == 2:
            self.domain = create_box(comm, 
                                   [np.array([0.0, 0.0]), np.array(dimensions)],
                                   [nx, nx], 
                                   cell_type=CellType.triangle)
        else:
            self.domain = create_box(comm, 
                                   [np.array([0.0, 0.0, 0.0]), np.array(dimensions)],
                                   [nx, nx, nx], 
                                   cell_type=CellType.tetrahedron)
        
        # Material properties (steel)
        self.E = 210.0e9  # Young's modulus [Pa]
        self.nu = 0.3     # Poisson's ratio
        self.lmbda = self.E * self.nu / ((1 + self.nu) * (1 - 2 * self.nu))
        self.mu = self.E / (2 * (1 + self.nu))
        
        # Fatigue properties
        self.fatigue_strength_coeff = 1.0e9
        self.fatigue_strength_exp = -0.1
        
        # Function spaces
        self.V = FunctionSpace(self.domain, ("P", 1, (self.dim,)))  # Displacement
        self.V_scalar = FunctionSpace(self.domain, ("P", 1))        # Scalar fields
        
        # Solution functions
        self.u = Function(self.V, name="Displacement")
        self.sigma = Function(self.V_scalar, name="VonMisesStress")
        self.damage = Function(self.V_scalar, name="FatigueDamage")
        self.life = Function(self.V_scalar, name="FatigueLife")
        
        # Initialize variables
        self.cycles = 0
        self.max_cycles = 10000
        
    def constitutive_model(self, u):
        """Define linear elastic constitutive model"""
        I = Identity(self.dim)
        epsilon = sym(grad(u))  # Strain tensor
        sigma = self.lmbda * tr(epsilon) * I + 2 * self.mu * epsilon
        return sigma
    
    def von_mises_stress(self, sigma):
        """Calculate von Mises equivalent stress"""
        if self.dim == 2:
            s_xx = sigma[0, 0]
            s_yy = sigma[1, 1]
            s_xy = sigma[0, 1]
            return np.sqrt(s_xx**2 + s_yy**2 - s_xx*s_yy + 3*s_xy**2)
        else:
            s_dev = sigma - (1/3)*tr(sigma)*Identity(self.dim)
            return np.sqrt(3/2 * inner(s_dev, s_dev))
    
    def setup_boundary_conditions(self):
        """Setup boundary conditions"""
        # Fix left boundary (x=0)
        def left_boundary(x):
            return np.isclose(x[0], 0.0)
        
        # Apply cyclic loading on right boundary
        def right_boundary(x):
            return np.isclose(x[0], self.dimensions[0])
        
        # Dirichlet BC: fixed left boundary
        left_facets = mesh.locate_entities_boundary(self.domain, self.dim-1, left_boundary)
        left_dofs = fem.locate_dofs_topological(self.V, self.dim-1, left_facets)
        bc_left = dirichletbc(np.zeros(self.dim), left_dofs, self.V)
        
        # Neumann BC: cyclic loading on right boundary
        self.load_magnitude = 1.0e6  # Pa
        self.load_history = []
        
        return [bc_left]
    
    def solve_static_step(self, load_factor):
        """Solve static problem for given load factor"""
        # Define variational problem
        v = TestFunction(self.V)
        u = TrialFunction(self.V)
        
        # External traction (cyclic loading)
        T = Constant(self.domain, (load_factor * self.load_magnitude, 0.0))
        
        # Mark right boundary for Neumann BC
        def right_boundary(x):
            return np.isclose(x[0], self.dimensions[0])
        
        right_facets = mesh.locate_entities_boundary(self.domain, self.dim-1, right_boundary)
        marked_facets = right_facets
        marked_values = np.full(len(right_facets), 2, dtype=np.int32)
        facet_tag = mesh.meshtags(self.domain, self.dim-1, marked_facets, marked_values)
        ds = ufl.Measure("ds", domain=self.domain, subdomain_data=facet_tag)
        
        # Weak form
        sigma = self.constitutive_model(self.u)
        F = inner(sigma, grad(v)) * dx - inner(T, v) * ds(2)
        
        # Solve nonlinear problem
        du = TrialFunction(self.V)
        J = derivative(F, self.u, du)
        
        problem = fem.petsc.NonlinearProblem(F, self.u, self.bcs, J=J)
        solver = fem.petsc.NewtonSolver(comm, problem)
        solver.solve(self.u)
        
        # Calculate von Mises stress
        sigma_tensor = self.constitutive_model(self.u)
        von_mises = self.von_mises_stress(sigma_tensor)
        
        # Project von Mises stress to function space
        sigma_expr = fem.Expression(von_mises, self.V_scalar.element.interpolation_points())
        self.sigma.interpolate(sigma_expr)
        
        return np.max(self.sigma.x.array)
    
    def fatigue_law(self, stress_amplitude):
        """Miner's rule and S-N curve implementation"""
        # Basquin's equation: S = a * N^b
        # Where S is stress amplitude, N is cycles to failure
        if stress_amplitude > 0:
            N_f = (stress_amplitude / self.fatigue_strength_coeff) ** (1 / self.fatigue_strength_exp)
            return max(N_f, 1)  # Avoid division by zero
        return float('inf')
    
    def update_fatigue_damage(self, stress_max, stress_min):
        """Update fatigue damage using Miner's rule"""
        stress_amplitude = (stress_max - stress_min) / 2
        
        # Calculate damage for this cycle
        N_f = self.fatigue_law(stress_amplitude)
        damage_increment = 1.0 / N_f if N_f != float('inf') else 0.0
        
        # Update damage field
        damage_array = self.damage.x.array
        life_array = self.life.x.array
        
        for i in range(len(damage_array)):
            if N_f != float('inf'):
                damage_array[i] += damage_increment
                # Update remaining life (in cycles)
                if damage_array[i] < 1.0:
                    life_array[i] = (1.0 - damage_array[i]) * N_f
                else:
                    life_array[i] = 0.0
        
        self.damage.x.array[:] = damage_array
        self.life.x.array[:] = life_array
    
    def run_analysis(self, num_blocks=10, cycles_per_block=100):
        """Run fatigue analysis"""
        print("Starting fatigue analysis...")
        
        # Setup boundary conditions
        self.bcs = self.setup_boundary_conditions()
        
        stress_history = []
        max_stress_history = []
        min_stress_history = []
        
        for block in range(num_blocks):
            print(f"Processing block {block+1}/{num_blocks}")
            
            # Apply cyclic loading (sinusoidal)
            for cycle in range(cycles_per_block):
                # Load factor varies between -1 and 1
                load_factor = np.sin(2 * np.pi * cycle / cycles_per_block)
                
                # Solve for this load step
                max_stress = self.solve_static_step(load_factor)
                stress_history.append(max_stress)
                
                # Track max/min stresses for damage calculation
                if cycle == 0:
                    stress_max = max_stress
                    stress_min = max_stress
                else:
                    stress_max = max(stress_max, max_stress)
                    stress_min = min(stress_min, max_stress)
            
            # Update fatigue damage after each block
            self.update_fatigue_damage(stress_max, stress_min)
            self.cycles += cycles_per_block
            
            max_stress_history.append(stress_max)
            min_stress_history.append(stress_min)
            
            print(f"Cycles completed: {self.cycles}, Max damage: {np.max(self.damage.x.array):.6f}")
            
            # Check for failure
            if np.max(self.damage.x.array) >= 1.0:
                print("Fatigue failure detected!")
                break
        
        return stress_history, max_stress_history, min_stress_history
    
    def post_process(self, stress_history, max_stress_history, min_stress_history):
        """Post-process and visualize results"""
        
        # Plot stress history
        plt.figure(figsize=(12, 8))
        
        plt.subplot(2, 2, 1)
        plt.plot(stress_history[:100])  # First 100 cycles
        plt.title('Stress History (First 100 Cycles)')
        plt.xlabel('Cycle')
        plt.ylabel('Max Von Mises Stress (Pa)')
        plt.grid(True)
        
        plt.subplot(2, 2, 2)
        plt.plot(max_stress_history, label='Max Stress')
        plt.plot(min_stress_history, label='Min Stress')
        plt.title('Stress Range per Block')
        plt.xlabel('Block')
        plt.ylabel('Stress (Pa)')
        plt.legend()
        plt.grid(True)
        
        plt.subplot(2, 2, 3)
        # Plot damage distribution
        damage_values = self.damage.x.array
        plt.hist(damage_values, bins=50, alpha=0.7)
        plt.title('Fatigue Damage Distribution')
        plt.xlabel('Damage')
        plt.ylabel('Frequency')
        plt.grid(True)
        
        plt.subplot(2, 2, 4)
        # Plot remaining life distribution
        life_values = self.life.x.array
        life_values = life_values[life_values > 0]  # Filter out failed elements
        if len(life_values) > 0:
            plt.hist(life_values, bins=50, alpha=0.7)
            plt.title('Remaining Life Distribution')
            plt.xlabel('Cycles to Failure')
            plt.ylabel('Frequency')
            plt.grid(True)
        
        plt.tight_layout()
        plt.savefig('fatigue_analysis_results.png', dpi=300, bbox_inches='tight')
        plt.show()
        
        # Save results to XDMF
        with io.XDMFFile(comm, "fatigue_results.xdmf", "w") as xdmf:
            xdmf.write_mesh(self.domain)
            xdmf.write_function(self.u, 0.0)
            xdmf.write_function(self.sigma, 0.0)
            xdmf.write_function(self.damage, 0.0)
            xdmf.write_function(self.life, 0.0)
        
        print(f"Analysis completed. Total cycles: {self.cycles}")
        print(f"Maximum damage: {np.max(self.damage.x.array):.6f}")
        print(f"Minimum remaining life: {np.min(self.life.x.array):.0f} cycles")

# Example usage
if __name__ == "__main__":
    # Create 2D analysis
    dimensions = (1.0, 0.1)  # 1m x 0.1m plate
    nx = 20  # Mesh resolution
    
    analysis = FatigueAnalysis(dimensions, nx)
    
    # Run analysis for 10 blocks of 100 cycles each
    stress_hist, max_hist, min_hist = analysis.run_analysis(num_blocks=10, cycles_per_block=100)
    
    # Post-process results
    analysis.post_process(stress_hist, max_hist, min_hist)