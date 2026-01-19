function [node_V] = computeVolumeDual(P,list_N,list_P)
% computeVolumeDual computes volume of the dual cell surrounding each node
% 
% Ardeshir Hanifi
% Feb. 2020

NP=length(P);
x=P(:,1);
y=P(:,2);

node_V=zeros(NP,1);
for k=1:NP
    a=list_P{k};
    node_V(k)=sum(dot(list_N{k},[x(a)-x(k), y(a)-y(k)],2))*0.25;
end

end

