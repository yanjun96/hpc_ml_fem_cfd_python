clear;close all;clc;
% 2D case


k = @(x) (1); %conduction/diffusion function
% g = @(x)(0); %boundary conditions
kappa = [0 0];
%Dirichlet = @(x) ( 1 ); % dirichlet boundary value

xmin = 0; xmax = 1; % Domain
ymin = 0; ymax = 1;




for i=1:4
%h_length=0.15;
%N_bound=4*(1/h_length);
%g=Rectg(xmin,ymin,xmax,ymax);
h_length=0.15./(2^(i-1));
N_bound=4*(1/h_length);
g=Rectg(xmin,ymin,xmax,ymax);
[p,e,t] = initmesh(g,'hmax',h_length); % create mesh
n_nodes(i)=length(t);

u=500*exp(-500*(sqrt((p(1,:)-0.5).^2+(p(2,:)-0.5).^2)).*(sqrt((p(1,:)-0.5).^2+(p(2,:)-0.5).^2)));
%r=(sqrt((x-0.5).^2+(y-0.5).^2));

f = @(x,y) 4*500*500*(1-500.*((x-0.5).^2+(y-0.5).^2)).*exp(-500.*((x-0.5).^2+(y-0.5).^2));
A = StiffnessAssembler2D(p,t,1,N_bound); % assemble stiffness matrix
b = LoadAssembler2D(p,t,f,N_bound); % assemble load vector
uh = A\b; % solve linear system

x=p(1,:);
y=p(2,:);
f1=4*500*500*(1-500.*((x-0.5).^2+(y-0.5).^2)).*exp(-500.*((x-0.5).^2+(y-0.5).^2));

figure(1)
pdemesh(p,e,t);

%eh(i)=norm((u-uh),2);
x_plot=linspace(0,1,length(u));
%N(i)=length(b);
%m(i)=log2(length(b))-1;

%figure
%plot(x_plot,eh,LineWidth=2);
hold on
xlabel('x');
ylabel('y');
%legend('h=0.05','h=0.1','h=0.15','h=0.2')
title('1st mesh ')

% hold on
% x_plot=linspace(0,1,length(uh));
% plot(x_plot,uh,LineWidth=2);
% xlabel('x');
% ylabel('Uh');
% legend('h=0.1','h=0.2','h=0.3','h=0.4')
% title('Question 6a, u(x)')
% hold on
%r=sqrt((x-0.5).^2+(y-0.5).^2);
%x_refine = find(r < 0.05);

%triangles_to_refine = any(ismember(t(1:3,:), x_refine),1);
%indices = find(triangles_to_refine ==1)';


figure(3), 
pdemesh(p,e,t);
xlabel('x');
ylabel('y');
%legend('h=0.05','h=0.1','h=0.15','h=0.2')
title('2nd mesh ')
eh(i)=norm((u-uh'),2);
i=i+1;

end



%figure
%plot(eta);

%xlabel('nodes');
%ylabel(' Rh');
%title('Elements Residual')



