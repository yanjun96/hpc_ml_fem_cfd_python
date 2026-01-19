clc;
clearvars;
% 

a = -3;
b = 3;
z = (b-a).*rand(1000000,1) + a;
z1 = (b-a).*rand(1000000,1) + a;

n=length(z);
for i=1:n
z2(i)=complex(z(i),z1(i));
end

n=length(z2);
for i=1:n
G(i)=1+z2(i)+z2(i).^2./2+z2(i).^3./6+z2(i).^4./24;

if abs(G(i))<=1
    G(i)=G(i);
    z2(i)= z2(i);
else
    G(i)=0;
    z2(i)=0;
end

end

plot(z2,LineWidth=2);
title('z value when Gz is smaller than 1')
xlabel('Real z')
ylabel('Imagine z')
legend('Gz')
hold on

line([-2.83,2.83],[2.83,2.83],linewidth=2);
hold on
line([-2.83,2.83],[-2.83,-2.83],linewidth=2);
line([-2.83,-2.83],[-2.83,2.83],linewidth=2);
line([2.83,2.83],[-2.83,2.83],linewidth=2);

legend('z','Imag=2.83 and -2.83','Real=2.83 and -2.83')


