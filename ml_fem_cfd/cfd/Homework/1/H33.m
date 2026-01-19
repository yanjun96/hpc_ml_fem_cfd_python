clc;
clearvars;
% simple precision


% double precision
f2d=double(4-1/16);
x=double(2);
f2d3=6/16/16;
me=10^(-16);

for i=1:20
delta_x(i)=double(10^(-20+i-1));
fn(i)=double((cal_f(x+delta_x(i))-cal_f(x-delta_x(i)))/(2*delta_x(i)));
error_p1(i)=double(abs((f2d-fn(i))/f2d));

error_p2(i)=(me*cal_f(x))/(f2d*sqrt(2)*delta_x(i));

error_d(i)=abs((delta_x(i)^2*f2d3)/(6*f2d));
error_g(i)=sqrt(error_p2(i)^2+error_d(i)^2);

i=i+1
end

figure();
log_error=loglog(error_p2,delta_x,LineWidth=2,Marker="+");
hold on
log_error=loglog(error_d,delta_x,LineWidth=2,Marker="o");
grid on
log_error=loglog(error_g,delta_x,LineWidth=2);
xlabel('Errors')
ylabel('Step sizes')
legend('Propagation error','Relative discretation error','Total error')


function fx = cal_f(x)
fx=1/(2+x)+x^2;
end

