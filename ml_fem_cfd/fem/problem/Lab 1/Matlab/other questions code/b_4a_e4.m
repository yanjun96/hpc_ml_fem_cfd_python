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

fu_ex =@(x) x-sinh(x)/sinh(1); % exact solution for equation 3



xmid=zeros(1,N);
uhmid=zeros(1,N);
for j=1:length(x)-1
    xmid(j)=(x(j+1)+x(j))/2;
    uhmid(j)=(uh(j+1)+uh(j))/2;
end
u_ex=fu_ex(xmid);

scatter(xmid,uhmid-u_ex,LineWidth=2)
hold on

xlabel('x');
ylabel('Error');
legend('N=4','N=16')
title('Equation 4, N=4 and 16 for the element centers error')

% 
% plot(x',error,LineWidth=2)
% hold on
% xlabel('x');
% ylabel('poinwise error');

end



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
