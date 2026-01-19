function hh = quadplot(ConnectivityList,X,Y)
%quadplot plots the quadrilateral grid, it assumes element nodes are correctly
%ordered.
%   
% Ardeshir Hanifi
% Feb. 2020

C=ConnectivityList;
edges=([C(:,1) C(:,2); ... % this assumes nodes of elements are ordered anticlockwise
        C(:,2) C(:,3); ...
        C(:,3) C(:,4); ...
        C(:,4) C(:,1)]);
x = X(edges)';
y = Y(edges)';
nedges = size(x,2);
x = [x; NaN(1,nedges)];
y = [y; NaN(1,nedges)];
x = x(:);
y = y(:);
h = plot(x,y);
if nargout == 1, hh = h; end
end

