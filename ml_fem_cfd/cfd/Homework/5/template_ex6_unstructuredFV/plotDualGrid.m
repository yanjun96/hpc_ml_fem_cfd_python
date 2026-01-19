function [] = plotDualGrid(P,ConnectivityList,x_cm,y_cm,nodes_E)
% plotDualGrid plots the dual grid
%
% Ardeshir Hanifi
% Feb. 2020

figure(300);clf
plot(P(:,1),P(:,2),'o')
hold on
NE=length(nodes_E(1,:));
if NE==3
    triplot(ConnectivityList,P(:,1),P(:,2))
else
    quadplot(ConnectivityList,P(:,1),P(:,2))
end
x=zeros(length(nodes_E)*NE,2);
y=zeros(length(nodes_E)*NE,2);
kk=1;
for k=1:length(nodes_E)
    a=nodes_E(k,:);
    for m=1:NE-1
        x(kk,:)=([x_cm(k) (P(a(m),1)+P(a(m+1),1))/2]);
        y(kk,:)=([y_cm(k) (P(a(m),2)+P(a(m+1),2))/2]);
        kk=kk+1;
    end
    m=NE;
    x(kk,:)=([x_cm(k) (P(a(m),1)+P(a(1),1))/2]);
    y(kk,:)=([y_cm(k) (P(a(m),2)+P(a(1),2))/2]);
    kk=kk+1;
end
x = x';
y = y';
nedges = size(x,2);
x = [x; NaN(1,nedges)];
y = [y; NaN(1,nedges)];
x = x(:);
y = y(:);
plot(x,y,'g-');

axis equal

end

