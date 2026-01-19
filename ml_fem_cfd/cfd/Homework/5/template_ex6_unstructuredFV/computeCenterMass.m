function [x_cm, y_cm] = computeCenterMass(P,nodes_E)
% computeCenterMass computes center of mass of each element
% 
% Ardeshir Hanifi
% Feb. 2020

x=P(:,1);
y=P(:,2);

n=length(nodes_E(1,:));
x_cm=sum(x(nodes_E),2)/n;
y_cm=sum(y(nodes_E),2)/n;
end

