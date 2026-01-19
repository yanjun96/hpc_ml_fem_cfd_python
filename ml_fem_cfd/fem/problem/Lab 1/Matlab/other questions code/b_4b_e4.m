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
figure()
subplot(2,2,1)
scatter(xsixpoint(1,:),uhsixpoint(1,:)-u_ex(1,:),LineWidth=2)
subplot(2,2,2)
scatter(xsixpoint(2,:),uhsixpoint(2,:)-u_ex(2,:),LineWidth=2)
subplot(2,2,3)
scatter(xsixpoint(3,:),uhsixpoint(3,:)-u_ex(3,:),LineWidth=2)
subplot(2,2,4)
scatter(xsixpoint(4,:),uhsixpoint(4,:)-u_ex(4,:),LineWidth=2)
xlabel('x');
ylabel('Error');
legend('N=4')

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
