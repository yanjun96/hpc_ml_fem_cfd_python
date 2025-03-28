clc
clear all

data=readmatrix('第4闸.xlsx');

% temperature of brake disc
T_d1 = data(2:end,1);
T_d2 = data(2:end,2);
T_d3 = data(2:end,3);  
T_d4 = data(2:end,4);
T_d5 = data(2:end,5);
T_d6 = data(2:end,6); 
% temperature of brake pad
T_p1 = data(2:end,7);
T_p2 = data(2:end,8);
T_p3 = data(2:end,9); 

% times
n=length(T_d1);  % total sampling numbers  
t_total=49.1;  % total T
dt=t_total\n;
t=linspace(0,t_total,n);

figure
plot(t,T_d1,LineWidth=1.5); hold on; % '+',
plot(t,T_d2,LineWidth=1.5); hold on; % 'v',
plot(t,T_d3,LineWidth=1.5);hold on;  % '-o',
plot(t,T_d4,LineWidth=1.5); hold on; % '+',
plot(t,T_d5,LineWidth=1.5); hold on; % 'v',
plot(t,T_d6,LineWidth=1.5); % '-o',
grid on; hold off;
xlabel('time/s');
ylabel('Temperature/ ℃');
title('Transient temperature of brake disc');
legend('T1','T2','T3','T4','T5','T6');
saveas(gcf,'brake disc temperature.png');

figure
plot(t,T_p1,LineWidth=1.5); hold on; % '+',
plot(t,T_p2,LineWidth=1.5); hold on; % 'v',
plot(t,T_p3,LineWidth=1.5); hold on; % '-o',
grid on; hold off;
xlabel('time/s');
ylabel('Temperature/ ℃');
title('Transient temperature of brake disc');
legend('T1','T2','T3','T4','T5','T6');
saveas(gcf,'brake pad temperature.png');

