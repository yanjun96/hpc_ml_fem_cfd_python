clc;
clearvars;
% simple precision

f2d=single(4-1/16); %% f(x)=2
x=single(2);

for i=1:20
delta_x(i)=single(10^(-20+i-1));  %% define different step sizes
fn(i)=single((cal_f(x+delta_x(i))-cal_f(x-delta_x(i)))/(2*delta_x(i))); %% calculate f'(n)
error(i)=single(abs((f2d-fn(i))/f2d));  %% calculate relative error
i=i+1
end

figure();
log_error=loglog(error,delta_x);
grid on
xlabel('Relative discretization error')
ylabel('Step sizes')
title('Single precision:plot of sigema d vs. delta x')
hold on

clearvars

% double precision
f2d=double(4-1/16);
x=double(2);

for i=1:20
delta_x(i)=double(10^(-20+i-1));
fn(i)=double((cal_f(x+delta_x(i))-cal_f(x-delta_x(i)))/(2*delta_x(i)));
error(i)=double(abs((f2d-fn(i))/f2d));
i=i+1
end

figure();
log_error=loglog(error,delta_x);
grid on
xlabel('Relative discretization error')
ylabel('Step sizes')
title('Double precision: plot of sigema d vs. delta x')


function fx = cal_f(x)
fx=1/(2+x)+x^2;
end

