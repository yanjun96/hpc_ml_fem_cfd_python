function [p, r] = GS_SOR(omega, Nx, Ny, hx, hy, L, f, p0, tol, maxit)
% [p, r] = GS_SOR(omega, Nx, Ny, hx, hy, L, f, p0, tol, maxit)
%
% Gauss-Seidel / Successive Over Relaxation method
% for the solution of a scalar Poisson equation
%
% This function belongs to SG2212.m

m    = 1;
r(m) = 1;


p   = p0;

while (r(m) > tol) &&  (m < maxit)

    % B.C. P_[1,1]
    p(1) = ...
    
    for i = 2:(Nx-1)
        % B.C. P_[i,1]
        p(i) = ...
    end
    
    % B.C. P_[Nx,1]
    p(Nx) = ...
    
    for j = 2:(Ny-1)
        % B.C. P_[1,j]
        k = 1+Nx*(j-1);
        p(k) =...
        % solve for the inner points
        for i = 2:(Nx-1)
            k = i+Nx*(j-1);
            p(k) = ...
        end
        % B.C. P_[Nx,j]
        k = Nx+Nx*(j-1);
        p(k) = ...
    end
    
    % B.C. P_[1,Ny]
    k = 1+Nx*(Ny-1);
    p(k) = ...
    
    for i = 2:(Nx-1)
        % B.C. P_[i,Ny]
        k = i+Nx*(Ny-1);
        p(k) = ...
    end
    
    % B.C. P_[Nx,Ny]
    k = Nx*Ny;
    p(k) = ...
    
    
    % Compute the residual
    r(m) = ...
    
	 % increase iteration counter
    m = m+1;
    
end

r = r(2:end);
