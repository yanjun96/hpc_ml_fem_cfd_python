clc;
clearvars;
% 

T=10;
k=1:3;
N(k)=[20 100 500];
lam=-3/5+i;

for k=1:3
dt(k)=T/N(k);
end

for k=1:3
    f_ex(k,1)=1;
    f_im(k,1)=1;
    f_cn(k,1)=1;
    f_tr(k,1)=1;
end

for k=1:3
    for j=1:(N(k)-1)
    f_ex(k,j+1)=(1+dt(k).*lam).*f_ex(k,j);
    f_im(k,j+1)=f_im(k,j)./((1-dt(k).*lam));
    f_cn(k,j+1)=(1+2.*dt(k).*lam./(2-dt(k).*lam)).*f_cn(k,j);
    f_tr(k,j+1)=real(exp(lam.*(0+dt(k).*j)));
    end
    
end


for k=1:3
    t(k,1)=0;
    for j=1:(N(k)-1)
    t(k,j+1)=t(k,j)+dt(k);
    end
end


plot(t(1,1:N(1))',real(f_ex(1,1:N(1)))',  t(1,1:N(1))',real(f_im(1,1:N(1)))',  t(1,1:N(1))',real(f_cn(1,1:N(1)))', linewidth=1);
hold on
plot (t(1,1:N(1))',f_tr(1,1:N(1))',linewidth=1)
legend('Explicit N=20','Implicit N=20','Crank Nicolson N=20','Analytic N=20')
title('N=20, three methods and analytical result')

%plot(t(2,1:N(2))',real(f_ex(2,1:N(2)))',  t(2,1:N(2))',real(f_im(2,1:N(2)))',  t(2,1:N(2))',real(f_cn(2,1:N(2)))', linewidth=1);
%hold on
%plot (t(2,1:N(2))',f_tr(2,1:N(2))',linewidth=1)
%legend('Explicit N=100','Implicit N=100','Crank Nicolson N=100','Analytic N=100')
%title('N=100, three methods and analytical result')

%plot(t(3,1:N(3))',f_ex(3,1:N(3))',  t(3,1:N(3))',f_im(3,1:N(3))',  t(3,1:N(3))',f_cn(3,1:N(3))', linewidth=1);
%hold on
%plot (t(3,1:N(3))',f_tr(3,1:N(3))',linewidth=1)
%legend('Explicit N=500','Implicit N=500','Crank Nicolson N=500','Analytic N=500')
%title('N=500, three methods and analytical result')


xlabel('t/ s')
ylabel('U')
