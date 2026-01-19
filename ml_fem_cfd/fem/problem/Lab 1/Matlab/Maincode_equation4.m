clear;close all;clc;
% for equation (3)
xmin = 0; 
xmax = 1;
for i=[4,16]
N=i;

x=mesh(xmin,xmax,N);
g=[0 0];
kappa = [0 0];

A=StiffnessAssembler1D(x,@k,kappa);
M=MassAssembler1D(x,@p);
b=LoadAssembler1D(x,@f,g);

S= A+M;
uh= S\b;

u_ex=x-sinh(x)/sinh(1); % exact solution for equation 3
u_ex=u_ex';
error = uh-u_ex;

%plot(x',uh',LineWidth=2)
%hold on
%plot(x,u_ex');
xlabel('x');
%ylabel('u');

plot(x',error,LineWidth=2)
hold on
xlabel('x');
ylabel('poinwise error');

end
legend('N=4','N=16')
title('Equation 4,N=4 and 16 for the pointwise error')


% k
function y=k(x)
y=1; 
end

% p
function y=p(x)
y=1;
end

% f
function y=f(x)
y=x;  % should be rhs funciton
end
