function [lapf] = laplace(f,P,list_N,list_P,node_V)
% laplace coputes the laplcian of the function f
%
% Ardeshir Hanifi
% Feb. 2020

NP=length(P);
x=P(:,1);
y=P(:,2);

lapf=f*0;
for k=1:NP
    S=sqrt(sum(list_N{k}.*list_N{k},2));
    v=[x(list_P{k})-x(k), y(list_P{k})-y(k)];
    R=sqrt(sum(v.*v,2));
    lapf(k)=sum((f(list_P{k})-f(k)).*S./(R*node_V(k)));
end
end

