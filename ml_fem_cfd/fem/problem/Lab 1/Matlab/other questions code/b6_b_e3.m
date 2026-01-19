clear;close all;clc;
% for equation (3)
xmin = 2; 
xmax = 4;
Norm_eh=zeros(5);
for i=[4,8,16,32,64]
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
%xmid=zeros(1,N);
%uhmid=zeros(1,N);
xsixpoint =[];
uhsixpoint =[];
for j=1:length(x)-1
%     xmid(j)=(x(j+1)+x(j))/2;
%     uhmid(j)=(uh(j+1)+uh(j))/2;
      xsixpoint = [xsixpoint; linspace(x(j), x(j+1), 6)];
      uhsixpoint = [uhsixpoint; linspace(uh(j), uh(j+1), 6)];
end
u_ex=fu_ex(xsixpoint);
%figure()
eh=uhsixpoint-u_ex;


m=log2(N)-1;
Norm_eh(m)=norm(eh);
h(m)=x(2)-x(1);
Con(m)=cond(A);

end

loglog(h,Con,LineWidth=2)

% hold on
 xlabel('log h mesh size');
 ylabel('log Condition number of M matrix');
 title('log h vs log condition number');


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
