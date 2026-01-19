clear;close all;clc;
% 2D case

k = @(x) 9; %conduction/diffusion function
% g = @(x)(0); %boundary conditions
kappa = [0 0];

for i=1:4
h_length=0.1/(2^(i-1));
N_bound=4*(1/h_length);
%[p, e, t] = initmesh(@circlefunction, 'Hmax', 0.1);

g=@circlefunction;
[p,e,t] = initmesh(g,'hmax',h_length); % create mesh
pdemesh(p,e,t);

u=((p(1,:)-0).^2+(p(2,:)-0).^2)*16;

f = @(x,y) -4;
A = StiffnessAssembler2D(p,t,1/16,N_bound); % assemble stiffness matrix
b = LoadAssembler2D_9(p,t,f,N_bound); % assemble load vector
uh = A\b; % solve linear system


%figure(1)
%pdemesh(p,e,t);

%eh(i)=norm((u-uh),2);
x_plot=linspace(0,1,length(u));
%N(i)=length(b);
%m(i)=log2(length(b))-1;

% figure
% eh=u'-uh;
% %plot(x_plot,eh,LineWidth=2);
% hold on
% xlabel('x');
% ylabel('eh');
% legend('h=0.05','h=0.1','h=0.15','h=0.2')
% title('error eh with mesh size h')

figure
% hold on
% x_plot=linspace(0,1,length(uh));
 plot(x_plot,uh',x_plot,u,LineWidth=2);
 xlabel('x');
 ylabel('Uh and U');
legend('Uh','u')
 title('Uh and U')
% hold on
eh(i)=norm((u-uh'),2);


i=i+1;
end

