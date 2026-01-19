% Navier-Stokes solver,

close all
clearvars
clear all

lid_driven_cavity=1;

if (lid_driven_cavity==1)
  % Parameters for test case I: Lid-driven cavity
  % The Richardson number is zero, i.e. passive scalar.
  
  Pr = 0.71;     % Prandtl number
  Re = 25;       % Reynolds number
  Ri = 0.;       % Richardson number
  
  dt = 0.001;     % time step
  Tf = 50;       % final time
  Lx = 1;        % width of box
  Ly = 1;        % height of box
  Nx = 30;       % number of cells in x
  Ny = 30;       % number of cells in y
  ig = 200;      % number of iterations between output
  
  % Boundary and initial conditions:
  Utop = 1; 
  Ubottom = 0;
  % IF TEMPERATURE: Tbottom = 1.; Ttop = 0.;
  % IF TEMPERATURE: namp = 0.;
else
  % Parameters for test case II: Rayleigh-Bénard convection
  % The DNS will be stable for Ra=1705, and unstable for Ra=1715 
  % (Theoretical limit for pure sinusoidal waves 
  % with L=2.01h: Ra=1708)
  % Note the alternative scaling for convection problems.
    
  Pr = 0.71;      % Prandtl number
  Ra = 1705;      % Rayleigh number

  Re = 1./Pr;    % Reynolds number
  Ri = Ra*Pr;    % Richardson number
  
  dt = 0.001;      % time step
  Tf = 20;         % final time
  Lx = 10.;      % width of box
  Ly = 1;        % height of box
  Nx = 200;      % number of cells in x
  Ny = 20;      % number of cells in y
  ig = 200;      % number of iterations between output
  
  % Boundary and initial conditions:
  Utop = 0; 
  Ubottom = 0;
  % IF TEMPERATURE:
  Tbottom = 1.; Ttop = 0.;
  namp = 0.1;
end

%-----------------------------------------

% Number of iterations
Nit = 50000;  % integrate up to the point that the solution becomes steady.

% Spatial grid: Location of corners 
x = linspace( 0,Lx,Nx+1); 
y = linspace( 0,Ly,Ny+1); 

% Grid spacing
dx = x(2)-x(1);
dy = y(2)-y(1);

% Boundary conditions: 
uN = x*0+Utop;    vN = avg(x,2)*0;
uS = x*0;         vS = avg(x,2)*0;
uW = avg(y,2)*0+Ubottom;  vW = y*0; 
uE = avg(y,2)*0;  vE = y*0; 

%tN = x*0+Ttop;   tS = x*0+Tbottom;

% Initial conditions
U = zeros(Nx-1,Ny); %29*30
V = zeros(Nx,Ny-1);  %30*29

% linear profile for T with random noise
% IF TEMPERATURE: 
%T = Tbottom+y/Ly*(Ttop-Tbottom) + namp*rand(Nx,Ny+1);

% Time series
tser = [0:dt:Tf ];
Tser = [0:dt:Tf ];

%-----------------------------------------

% Compute system matrices for pressure 
% First set homogeneous Neumann condition all around
% Laplace operator on cell centres: Fxx + Fyy
Lp = kron(speye(Ny), DD(Nx,dx)) + kron(DD(Ny,dy),speye(Nx));
ANS=DD(Nx,dx);

% Set one Dirichlet value to fix pressure in that point
Lp(1,:) = 0 ; Lp(1,1) = 1 ;

% Here you can pre-compute the LU decomposition
 %[LLp,ULp] = lu(Lp);
%-----------------------------------------

% Progress bar (do not replace the ... )
fprintf(    '[  1   |    2     |    3     |         |         ]\n')

%-----------------------------------------

% Main loop over iterations
a=0;
for k = 1:Nit
     
   % include all boundary points for u and v (linear extrapolation
   % for ghost cells) into extended array (Ue,Ve)
   Ue = [uW;U;uE];
   Ue=[2*uS'-Ue(:,1) Ue 2*uN'-Ue(:,end)];
  % Ve=[2*vS'-V(:,1) V 2*vN'-V(:,end)];
  % Ve = [vW;Ve;vE];
   Ve = [vS' V vN'];
   Ve=[2*vE-Ve(1,:); Ve; 2*vW-Ve(end,:)];
  

   UE1=Ue';
   VE1=Ve';
      
   % averaged (Ua,Va) of u and v on corners
   Ua = avg(Ue,2);  % NX+1,NX+1
   Va = avg(Ve,1);  % NX+1,NY+1
   
   % construct individual parts of nonlinear terms
   dUVdx = 1/dx*diff(Ua.*Va,1,1);   % 30,31
   dUVdy = 1/dy*diff(Ua.*Va,1,2);   % 31,30

   Ua = avg(Ue,1);  % 30,32
   Va = avg(Ve,2);  % 32,30
   dU2dx = 1/dx*diff(Ua.*Ua,1,1);   % 30,31
   dV2dy = 1/dy*diff(Va.*Va,1,2);   % 31,30
   
   % treat viscosity explicitly
   viscu = diff(Ue(:,2:end-1),2,1)/dx^2+diff(Ue(2:end-1,:),2,2)/dy^2;
   viscv = diff(Ve(:,2:end-1),2,1)/dx^2+diff(Ve(2:end-1,:),2,2)/dy^2;
   
   % buoyancy term
   % IF TEMPERATURE: 
   %   fy = Ra*Pr*T;
         
   % compose final nonlinear term + explicit viscous terms
   U = U + dt/Re*viscu - dt*(dU2dx(:,2:end-1)+dUVdy(2:end-1,:));    % 29*30
   V = V + dt/Re*viscv - dt*(dUVdx(:,2:end-1)+dV2dy(2:end-1,:));    % + % IF TEMPERATURE: dt*fy;    %30*29
   
   % pressure correction, Dirichlet P=0 at (1,1)      
   rhs = (diff([uW;U;uE],1,1)/dx + diff([vS' V vN'],1,2)/dy)/dt;
   rhs = reshape(rhs,Nx*Ny,1);
   rhs(1) = 0;
   P = Lp\rhs;
   P = reshape(P,Nx,Ny);
   %[Gpx,Gpy]=gradient(P);

   % apply pressure correction
   % U = U - dt.*Gpy(2:end,:);
   % V = V - dt.*Gpx(:,2:end);
   
   U = U - dt.*diff(P,1,1)./dx;
   V = V - dt.*diff(P,1,2)./dy;

   % Temperature equation
   %Te = [(tS(2:end))' T  (tN(2:end))'];
   % a1=Te';
   % Tu = ...
   % Tv = ...
   %H = ...
   % T = T + dt*H;
   
   %-----------------------------------------
   
   % progress bar
   if floor(51*k/Nit)>floor(51*(k-1)/Nit), fprintf('.'), end
   
   % plot solution if needed
   if k==1|floor(k/ig)==k/ig

     % compute divergence on cell centres
     if (1==1)
       div = diff([uW;U;uE])/dx + diff([vS' V vN'],1,2)/dy;
       %figure(1);clf; hold on;
       %contourf(avg(x,2),avg(y,2),div');colorbar
       %axis equal; axis([0 Lx 0 Ly]);
       %title(sprintf('divergence at t=%g',k*dt))
       drawnow
     end 
     
     % compute velocity on cell corners
     Ua = avg(Ue,2);
     Va = avg(Ve,1);
     Len = sqrt(Ua.^2+Va.^2+eps);
     figure(5);clf;hold on;
     %contourf(avg(x,2),avg(y,2),P');colorbar
     contourf(x,y,sqrt(Ua.^2+Va.^2)',20,'k-');colorbar
     quiver(x,y,(Ua./Len)',(Va./Len)',.4,'k-')
     axis equal; axis([0 Lx 0 Ly]);
     title(sprintf('u at t=%g',k*dt))
     drawnow
     
     % IF TEMPERATURE: % compute temperature on cell corners
     % IF TEMPERATURE: 
     %Ta = ...
     %figure(3); clf; hold on;
     % contourf(x,y,Ta',20,'k-');colorbar
     %quiver(x,y,(Ua./Len)',(Va./Len)',.4,'k-')
     %axis equal; axis([0 Lx 0 Ly]);
     %title(sprintf('T at t=%g',k*dt))
    % drawnow
     
      %Time history
     %if (1==1)
       %figure(4); hold on;
      % tser = [tser k*dt];
      % Tser = [Tser Ue(ceil((Nx+1)/2),ceil((Ny+1)/2))];
      % plot(tser,abs(Tser),LineWidth=2)
      % title(sprintf('Probe signal at x=%g, y=%g',...
      % x(ceil((Nx+1)/2)),y(ceil((Ny+1)/2))))
       %set(gca,'yscale','log')
      % xlabel('time t');ylabel('u(t)')
     %end
   end
   a=a+1;
end
fprintf('\n')


function B = avg(A,idim)

if nargin<2, idim = 1; end

if (idim==1)
  B = (A(2:end,:)+A(1:end-1,:))/2; 
elseif (idim==2)
  B = (A(:,2:end)+A(:,1:end-1))/2; 
else
  error('avg(A,idim): idim must be 1 or 2')
end
end

function A = DD(n,h)


for j=2:n
    D(j,j)=-2;
    D(j,j+1)=1;
    D(j,j-1)=1;
end
D(1,1)=-1;
D(1,2)=1;
D(n,n)=-1;
D(:,n+1) = [];
A =(1/h)^2.*D;
end