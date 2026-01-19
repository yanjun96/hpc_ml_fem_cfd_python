close all
clear all
clc
clearvars
%%
nn=0;
ndim=zeros(10,1);

% Choose geometry either 'squre_quad' or 'squre_tri' 'triangle' or 'triangle_random'
geocase='triangle';

%for i=1:5

for N=[20]
    
    disp(['Runing the case for N= ',num2str(N)])
    
    %% set up the grid and copmute related data set
    [P,nodes_b,nodes_in,nodes_E,volume_E,ConnectivityList]=generateGrid(geocase,N);
    
    NP=length(P);
    
    %% center of mass
    [x_cm, y_cm] = computeCenterMass(P,nodes_E);
    
    %% Find elements which each node belongs to
    list_E = findT(NP,nodes_E);
    
    %% Find all nodes connected to one
    list_P = findP(P,nodes_E,list_E);
    
    %% compute normals of dual grid
    [list_N] = computeNormal(P,x_cm,y_cm,list_E,list_P);
    
    %% compute volume of the dual grid cells
    [node_V] = computeVolumeDual(P,list_N,list_P);
    
    %% set up function and its analytical derivatives
    [f,dfxa,dfya,lapfa] = setf(P);
    
    %% compute first derivative at all nodes
    [dfx,dfy] = grad(f,list_P,list_N,node_V);
    
    %% compute Laplacian at all nodes
    [lapf] = laplace(f,P,list_N,list_P,node_V);
    
    %% compute second derivative at all nodes by applying first derivative two times
    
    % Add here the alternative definition of the Laplacian
    [dfxx,dfxx1]=grad(dfx,list_P,list_N,node_V);

    [dfyy1,dfyy]=grad(dfy,list_P,list_N,node_V);
    
    lapfn=dfxx+dfyy;
    
    %% compute errors
    
    nn=nn+1;
    ndim(nn)=sqrt(NP);
    
    % Note that the error on the derivatives need to be computed only in
    % the inner nodes

    errx(nn)=norm(dfxa(nodes_in)-dfx(nodes_in))/norm(dfxa(nodes_in));   % Error on the x-derivative

    erry(nn)=norm(dfya(nodes_in)-dfy(nodes_in))/norm(dfya(nodes_in));   % Error on the y-derivative

    errl(nn)=norm(lapfa(nodes_in)-lapf(nodes_in))/norm(lapfa(nodes_in));   % Error on the Laplacian (using the function laplace.m)

    errln(nn)=norm(lapfa(nodes_in)-lapfn(nodes_in))/norm(lapfa(nodes_in));  % Error on the Laplacian (alternative method)

end
%% plot error convergence
ndim=ndim(1:nn);
%figure(10)
%loglog(ndim,errx,'o-',...
  % ndim,erry,'+-',...
  % ndim,errl,'s-',...
   % ndim,errln,'*-',...
   % [5 80],[5 80].^(-1),'k-.',...
   % [5 80],[5 80].^(-2),'k--');
legend('dfx','dfy','Laplace','d(dfx)+d(dfy)','first order','second order')
hold on
xlabel('N');
ylabel('error')

%i=i+1;
%end

%% Plot the dual grid

 %plotDualGrid(P,ConnectivityList,x_cm,y_cm,nodes_E)

%% Example of plot the results
x=P(nodes_in,1);
y=P(nodes_in,2);
tri = delaunay(x,y);

figure(2)
trisurf(tri,x,y,dfx(nodes_in));
shading interp
view(2)
title('triangle-random: Numerical df/dx')
colorbar;


figure(3)
trisurf(tri,x,y,dfy(nodes_in));
shading interp
view(2)
title('triangle-random: Numerical df/dy')
colorbar


