clear;close all;clc;
% for equation (3)
xmin = 0; 
xmax = 1;
Norm_eh=zeros(5);
for i=[4,8,16,32,64]
    
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
eh=uhsixpoint-u_ex;

m=log2(N)-1;
Norm_eh(m)=norm(eh);
h(m)=x(2)-x(1);
Con(m)=cond(A);

if m>1
order(m)=log(Norm_eh(m-1,1)/Norm_eh(m,1))/(log(N)/log(N/2));

else
end
end

loglog(h,Con,LineWidth=2)

% hold on
 xlabel('log h mesh size');
 ylabel('log Condition number of M matrix');
 title('log h vs log condition number');



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
