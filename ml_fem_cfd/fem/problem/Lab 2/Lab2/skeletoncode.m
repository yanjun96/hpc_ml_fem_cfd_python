%% Skeleton finite element program
%% Set up the program so that it is easy to adapt for multiple dimensions.  

% ensure all previous information is cleared from memory
clear;close all;clc;


frhs = @(x) (0);% RHS function in Poisson's equation
uexact = @(x) (2*sin(2*pi*x[1,:]*sin(4*pi*x[2,:]));% Exact solution to Poisson's equation
kdiff = @(x) (1); %conduction/diffusion function
preact  = @(x) (0); %reaction coefficient function
g = @(x)(0); %boundary conditions
isDirichlet = @(x) ( 1 ); % dirichlet boundary value
xmin = 0; xmax = 1; % Domain
ymin = 0; ymax = 1;

error = ?
condNumb = ?
hv=?

tic
for i =             % Run for different mesh sizes
    
    h = ???;   % mesh size (for refinement, assume doubling the number of elements
    hv(i) = h;
    
    [nodes, edges, elements] = Mesh(?);  % build mesh
    
    figure
    pdemesh(nodes,edges,elements)   % show mesh
    

    [A, b] = Assembly(nodes, elements, edges, kdiff, ...
        preact, frhs, g, isDirichlet);  
    
    uh= A\b;    % solve the resulting linear system
    ehpt = PointwiseError(nodes,elements,uh,uexact); % NOT IN ABSOLUTE VALUE!
    eh = L2Error(nodes,elements,uh,uexact);      % compute the L2-error
    error(i)=eh;
    %condNumb(i)=??               % compute the condition number of A
    
    figure(1)
    if N == 4
        subplot(2,2,1)
        pdesurf(nodes,elements,uexact)    % plot solution
        subplot(2,2,2)
        pdesurf(nodes,elements,uh)    % plot FEM solution
    elseif
        subplot(2,2,3)
        pdesurf(nodes,elements,uexact)    % plot solution
        subplot(2,2,4)
        pdesurf(nodes,elements,uh)    % plot FEM solution
    end
    %MAKE SURE YOU LABEL YOUR PLOTS!!
    
    figure(2) % element errors at nodes
    pdesurf(nodes,elements,ehV)    % plot error
    
    %%%
    % Construct the approximation at 6 points/element before the next part
    % for the plotting on 4 elements
    %%%

    figure(3) % element pointwise errors for N=4.
    pdesurf(nodes,elements,ehptV)
   
    figure(4) % Only works in 1D; for this, we take the absolute value of the pointwise errors
    semilogy(nodes,ehptV)

    pause
    
end
%toc
figure(5)
%loglog(????)     % illustrate the convergence 

figure(5)
%loglog(????)     % plot the condition number vs mesh size
      
function [p, e, t] = Mesh(?)


end
