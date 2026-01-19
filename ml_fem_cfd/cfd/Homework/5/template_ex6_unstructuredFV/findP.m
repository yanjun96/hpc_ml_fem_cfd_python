function [list_P] = findP(P,nodes_E,list_E)
% findP Finds all nodes connected to one
%
% Ardeshir Hanifi
% Feb. 2020

NP=length(P);
x=P(:,1);
y=P(:,2);

list_P=cell(NP,1);
for k=1:NP
    a=nodes_E(list_E{k},:);
    b=unique(a(~(a==k)));
    
    % sort the nodes
    ang=atan2(y(b(:))-y(k),x(b(:))-x(k));
    [~,ind]=sort(ang);
    list_P{k}=b(ind);
end
end

