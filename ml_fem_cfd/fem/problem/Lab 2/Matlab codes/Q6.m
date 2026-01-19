clear;close all;clc;
% 2D case


k = @(x) (1); %conduction/diffusion function
% g = @(x)(0); %boundary conditions
%Dirichlet = @(x) ( 1 ); % dirichlet boundary value

xmin = 0; xmax = 1; % Domain
ymin = 0; ymax = 1;
for i=1:4
h_length=0.15./(2^(i-1));
N_bound=4*(1/h_length);
g=Rectg(xmin,ymin,xmax,ymax);
[p,e,t] = initmesh(g,'hmax',h_length); % create mesh
n_elements(i)=length(t);
u=(2*sin(2*pi.*p(1,:)).*sin(4*pi.*p(2,:)))';

f = @(x,y) 40*pi*pi*sin(2*pi*x).*sin(4*pi*y);
A = StiffnessAssembler2D(p,t,1,N_bound); % assemble stiffness matrix
b = LoadAssembler2D(p,t,f,N_bound); % assemble load vector
uh = A\b; % solve linear system

%pdesurf(p,t,uh); % plot projection

eh(i)=norm((u-uh),2);
x_plot=linspace(0,1,length(u));
N(i)=length(b);
m(i)=log2(length(b))-1;

pdesurf(p,t,uh);

% %plot(u);
% xlabel('x');
% ylabel('error');
% legend('h=0.1','h=0.2','h=0.3','h=0.4')
% title('Question 6b, error')


% hold on
% x_plot=linspace(0,1,length(uh));
pdesurf(p,t,uh);
xlabel('x');
ylabel('y');
legend_c=i*0.1;
%legend('h=',legend_c);
% title('Question 6a, u(x)')
colorbar;
saveas(gcf, 'sine_wave.png');
i=i+1;

file_name = ['h=', i*0.1, '.png'];
% Save the figure as a PNG file with the dynamic file name
saveas(gcf, file_name);
end

% for i=1:3
% order(i)=log(eh(i)./eh(i+1))./log(N(i+1)./N(i))
% end
% 
% h=1./N;
% %plot(h,eh,LineWidth=2);
%  xlabel('h');
%  ylabel('eh');
%  title('Order of convergence');
 