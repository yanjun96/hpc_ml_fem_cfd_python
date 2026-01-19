clc;
close all;
clearvars;

p=2*pi;
N=50;
dx=p/N;

D=[];

%% Assembling Matrix D
for j=1:N-1
    D(j,j)=-1;
    D(j,j+1)=1;
end
D(N,N)=-1;
D(N,1)=1;
D=D/dx;

k=3;
%% analytical f'(x)
for j=1:N-1
    f_ad(j)=Ane(k,dx*j);
end
f_ad(N)=f_ad(1);
f_adreal=real(f_ad);

%% numerical f'(x)
for j=1:N-1
f_n(j)=exp(i*k*j*dx);
end
f_n(N)=f_n(1);
f_nreal=real(f_n);
f_nd=D*f_n';

%for j=1:N
%mu(j)=f_nd(j)./f_n(j);
%end
mu=f_nd'./f_n;


%kl(j)=i*(1/dx)*(sin(3*dx*j)+i*2*(sin(1.5*dx*j))^2);

kl=i*((1/dx)*(i-i*exp(i*3*dx)));


function f_exa=Ane(p,x)
f_exa=i*p*exp(i*p*x);
end


