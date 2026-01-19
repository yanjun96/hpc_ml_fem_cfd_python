clc;
clearvars;
% 

z=-10:0.5;
f1=1+z;
f2=1./(1-z);
f3=1+2.*z./(2-z);

f4=1+z+z.^2./2+z.^3./6+z.^4./24;

plot(z,f1,z,f2,z,f3,z,f4,linewidth=2)

legend('Explicit Euler','Implicit Euler','Crank Nicolson')
title('Amplifaication factor')
xlabel('z')
ylabel('G(z)')
