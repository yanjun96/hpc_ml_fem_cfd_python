clear
close all

Nx = 50;                                 % Number of points in x
Ny = 50;                                 % Number of points in y
Lx = 1;  Ly = 1;                         % Size of the domain  
omega = 1.9;                             % SOR parameter
hx = Lx/Nx; hy = Ly/Ny;                  % Grid spacing
x = linspace(0,Lx,Nx+1);                 % x-coordinates length N+1 at grid nodes
y = linspace(0,Ly,Ny+1);                 % y-coordinates length N+1 at grid nodes

% Assemble x and y - coordinate at cell centers into 1-D vector length N*N
X = (x(1:end-1) + x(2:end))/2;
Y = (y(1:end-1) + y(2:end))/2;

% Define the forcing function (NOTE: correct ordering!)
f = ...;
f=reshape(f,[],1);

%-----------------------------------------
% Assemble laplacian matrix
L = Lapl(Nx, Ny, hx, hy);

% Set one Dirichlet value to fix pressure in one point
L(1,:) = ...; L(1,1) = ...; f(1)=...;

% Solve the problem with a direct method (Matlab's backslash)
p_direct = L\f;

% plot p_direct
figure(2)
surf(X, Y, reshape(p_direct, Nx, Ny)')
zlabel('p_{dir}')
xlabel('x')
ylabel('y')

%-----------------------------------------

% Set up the initial guess
p0 = ...;

% Set up the tolerance and maximum number of iterations
tol   = ...;
maxit = ...;

% Compute the iterative solution
[p, r] = GS_SOR(omega, Nx, Ny, hx, hy, L, f, p0, tol, maxit);


%-----------------------------------------
% plots
