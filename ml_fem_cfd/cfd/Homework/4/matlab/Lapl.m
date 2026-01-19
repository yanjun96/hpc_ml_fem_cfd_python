function L = Lapl(Nx, Ny, hx, hy)
% L = Lapl(Nx, Ny, hx, hy)
%
% Two-dimensional laplacian matrix 
% of size Nx*Ny times Nx*Ny
%
% This function belongs to SG2212.m

L = kron(speye(Ny), DD(Nx,hx)) + kron(DD(Ny,hy), speye(Nx));
