function [P,nodes_b,nodes_in,nodes_E,volume_E,ConnectivityList] = generateGrid(geocase,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% Ardeshir Hanifi
% Feb. 2020

if N<3
    disp('Value of N is too smal!')
    return
end

Nx=N;
Ny=N;
eps1=1e-8;

if strcmpi(geocase(1:5),'squre')
    x=linspace(-2,2,Nx); y=linspace(-2,2,Ny);
    [X,Y]=meshgrid(x,y);
    P=[X(:),Y(:)];
    NN=Nx*Ny;
    nodes_b=[1:Ny:(Nx-1)*Ny, NN-Ny+1:NN, (Nx-1)*Ny:-Nx:2*Ny, Ny:-1:2 ];  %boundary nodes
    ConnectivityList=zeros((Nx-1)*(Ny-1),4);
    if strcmpi(geocase(7:end),'quad')
        kk=0;
        for k=1:Ny-1
            for m=1:Nx-1
                mm=(k-1)*Ny+m;
                kk=kk+1;
                ConnectivityList(kk,:)=([mm mm+Ny mm+Ny+1 mm+1]);
            end
        end
    else
        DT = delaunayTriangulation(P);
        ConnectivityList=DT.ConnectivityList;
    end
elseif strcmpi(geocase(1:8),'triangle')
    km=0;
    P=zeros(N*(N+1)/2,2);
    ConnectivityList=[];
    for k=1:N
        for m=1:k
            y=(k-1);
            x=(-k/2+m-1)*2;
            km=km+1;
            P(km,:)=[x,y];
        end
        if k>1
            ConnectivityList=[ConnectivityList; mshift((km-2*k+2:km))];
        end
    end
    P=P/P(end,2);
    P(:,1)=P(:,1)-P(1,1);
    nodes_b=unique([find(P(:,1)<-P(:,2)+eps1); find(P(:,1)>P(:,2)-eps1); find(P(:,2)>1-eps1)])'; %boundary nodes
    if strcmpi(geocase(10:end),'random')
        DT = delaunayTriangulation(P);
        ConnectivityList=DT.ConnectivityList;
    end
else
    P = gallery('uniformdata',[N 2],0);
    nodes_b=unique(boundary(P(:,1),P(:,2),0))'; %boundary nodes
    DT = delaunayTriangulation(P);
    ConnectivityList=DT.ConnectivityList;
end

nodes_in=setdiff((1:length(P)),nodes_b); % inner nodes

figure(102); clf
if strcmpi(geocase,'squre_quad')
    quadplot(ConnectivityList,P(:,1),P(:,2)); hold on
else
    triplot(ConnectivityList,P(:,1),P(:,2)); hold on
end
plot(P(nodes_b,1),P(nodes_b,2),'r*');

% compute volumes of each triangle and remove those with zero volume
[nodes_E,volume_E] = computeVolume(P,ConnectivityList);

disp(['      Total no. points NP= ',num2str(length(P))])
disp(['      Total no. cells  NC= ',num2str(length(nodes_E))])

end

