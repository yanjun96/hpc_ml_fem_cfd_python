clear;close all;clc;
% for equation (3)
xmin = 2; 
xmax = 4;
for i=[4, 16]
N=i;

x=mesh(xmin,xmax,N);
g=[3 5];
kappa = [0 0];

A=StiffnessAssembler1D(x,@k,kappa);
M=MassAssembler1D(x,@p);
b=LoadAssembler1D(x,@f,g);

uh= A\b;
S= A+M;

fu_ex =@(x) x.^2-5*x+9; % exact solution for equation 3
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
title('Equation 3, N=4 and 16 for the element centers error')
 

end
% u_ex=u_ex';
% 
% for j=1:length(u_ex)
% u_ex_mid=(u_ex(i)+u_ex(i+1))/2;
% end
% 
% error = uh-u_ex;
% 
% 
% plot(x',uh',LineWidth=2)
% hold on
% plot(x,u_ex');
% xlabel('x');
% ylabel('u');
% end
% legend('N=4','N=16')
% title('Equation 3, N=4 and 16 for the uh')

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
