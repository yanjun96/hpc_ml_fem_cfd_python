clear;close all;clc;
% 2D case


k = @(x) (1); %conduction/diffusion function
% g = @(x)(0); %boundary conditions
kappa = [0 0];

%Dirichlet = @(x) ( 1 ); % dirichlet boundary value

xmin = 0; xmax = 1; % Domain
ymin = 0; ymax = 1;
for i=1:1
h_length=0.10*i;
N_bound=4*(1/h_length);
g=Rectg(xmin,ymin,xmax,ymax);
[p,e,t] = initmesh(g,'hmax',h_length); % create mesh

u=cos(pi.*p(1,:)).*sin(2*pi.*p(2,:));

%r=(sqrt((x-0.5).^2+(y-0.5).^2));
%f = @(x,y) 4*500*500*(1-500.*((x-0.5).^2+(y-0.5).^2)).*exp(-500.*((x-0.5).^2+(y-0.5).^2));
f = @(x,y) 5*pi*pi*cos(pi*x).*sin(2*pi*y);

A = StiffnessAssembler2D(p,t,1,N_bound); % assemble stiffness matrix
b = LoadAssembler2D(p,t,f,N_bound); % assemble load vector
uh = A\b; % solve linear system

x=p(1,:);
y=p(2,:);
f1=5*pi*pi*cos(pi*x).*sin(2*pi*y);

figure(1)
%pdemesh(p,e,t);

%eh(i)=norm((u-uh),2);
x_plot=linspace(0,1,length(u));
%N(i)=length(b);
%m(i)=log2(length(b))-1;

%figure

eh(i)=norm((u-uh),2);
N(i)=length(b);
%plot(x_plot,eh,LineWidth=2);
hold on
xlabel('x');
ylabel('eh');
%legend('h=0.05','h=0.1','h=0.15','h=0.2')
title('error eh with mesh size h')

%figure
%plot(x_plot,u,x_plot,uh,linewidth=2);
hold on;
xlabel('x');
ylabel('U and U_h');
%legend('U','U_h')
title('Exact U and Finite element approximation U_h')



% hold on
 x_plot=linspace(0,1,length(uh));
 plot(x_plot,uh,x_plot,u,LineWidth=2);
xlabel('x');
 ylabel('Uh');
% legend('h=0.1','h=0.2','h=0.3','h=0.4')
% title('Question 6a, u(x)')
% hold on

i=i+1;
end

%for i=1:3
%order(i)=log(eh(i)./eh(i+1))./log(N(i+1)./N(i))
%end

% h=1./N;
% plot(h,eh,LineWidth=2);
%  xlabel('h');
%  ylabel('eh');
%  title('Order of convergence');
% saveas(gcf, '8B.png');
