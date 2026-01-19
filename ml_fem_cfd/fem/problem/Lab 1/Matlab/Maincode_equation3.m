clear;close all;clc;
% for equation (3)
xmin = 2; 
xmax = 4;
for i=[4,16]
N=i;

x=mesh(xmin,xmax,N);
g=[3 5];
kappa = [0 0];

A=StiffnessAssembler1D(x,@k,kappa);
M=MassAssembler1D(x,@p);
b=LoadAssembler1D(x,@f,g);

uh= A\b;
S= A+M;

u_ex=x.^2-5*x+9; % exact solution for equation 3
u_ex=u_ex';

error = uh-u_ex;


plot(x',uh',LineWidth=2)

hold on
plot(x,u_ex');
xlabel('x');
ylabel('u');
end
legend('N=4','N=16')
title('Equation 3, N=4 and 16 for the uh')

% k
function y=k(x)
y=x; 
end

% p
function y=p(x)
y=0*x;
end

% f
function y=f(x)
y=5-4*x;  % should be rhs funciton
end
