clear
close all
clearvars
clc

%for i=1:9
%N=i*10+10
%Nx=N;
%Ny=N;

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
%X1=cos(3*pi*X)';
%Y1=(exp(Y.^2)+2*Y.^2.*exp(Y.^2)-exp(1));
%f=X1*Y1;


f = cos(3*pi*X)'*((exp(Y.^2)+2*Y.^2.*exp(Y.^2)-exp(1)));


f=reshape(f,[],1);
ans1=sum(f);


%-----------------------------------------
% Assemble laplacian matrix
L = Lapl(Nx, Ny, hx, hy);

% Set one Dirichlet value to fix pressure in one point
L(1,:) = 0;
L(1,1) = 1; 
f(1)=0;

% Solve the problem with a direct method (Matlab's backslash)
p_direct = L\f;

% plot p_direct
%figure(2);
%surf(X, Y, reshape(p_direct, Nx, Ny)')
%zlabel('p_{dir}')
%xlabel('x')
%ylabel('y')

%-----------------------------------------

% Set up the initial guess
p0(Nx*Nx)=0;
p0=p0';
%p0=0;

% Set up the tolerance and maximum number of iterations
tol   = 0.000001;
maxit = 10000;

% Compute the iterative solution
[p, r] = GS_SOR(omega, Nx, Ny, hx, hy, L, f, p0, tol, maxit);

%Gause Seidel
omega=1;
[p1, r1] = GS_SOR(omega, Nx, Ny, hx, hy, L, f, p0, tol, maxit);
%-----------------------------------------

[p2, flag, endrelres, iter, re] = gmres(L, f, [], 1e-20,maxit);

% plots
figure(3)

semilogy(r);
hold on
semilogy(r1);
hold on
re=re';
semilogy(re);
legend('N=SOR','N=GS','N=GMR');
%i=i+1;
%end

%title('omega=0.1')

%legend('N=20','N=30','N=40','N=50','N=60','N=70','N=80','N=90','N=100');

