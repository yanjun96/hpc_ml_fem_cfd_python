function [dfx,dfy] = grad(f,list_P,list_N,node_V)
% dxdy computes first derivatives of the function f
%
% Ardeshir Hanifi
% Feb. 2020

NP=length(f);
dfx=f*0; dfy=f*0;

for k=1:NP
    dfx(k)=sum((f(k)+f(list_P{k})).*list_N{k}(:,1))*0.5/node_V(k);
    dfy(k)=sum((f(k)+f(list_P{k})).*list_N{k}(:,2))*0.5/node_V(k);
end

end

