function [list_E] = findT(NP,nodes_E)
% findT Finds triangles which each node belongs to
%
% Ardeshir Hanifi
% Feb. 2020

list_E=cell(NP,1);
for k=1:NP
    [row,~]=find(nodes_E==k);
    list_E{k}=row;
end
end

