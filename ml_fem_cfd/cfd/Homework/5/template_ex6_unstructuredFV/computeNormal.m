function [list_N] = computeNormal(P,mcx,mcy,list_E,list_P)
% computeNormal computes surface normals for the dual grid.
%
% Output: List_N{k} contains the normal vectors for each edge
%          of dual grid surounding node k.
%
% Ardeshir Hanifi
% Feb. 2020

NP=length(P);
Px=P(:,1);
Py=P(:,2);
list_N=cell(NP,1);

for k=1:NP
    a=list_P{k}; % list of nodes conected to curent one
    
    xm=(Px(a)+Px(k))/2; % midpoint of edges
    ym=(Py(a)+Py(k))/2;
    
    s=zeros(length(a),2);
    for m=1:length(a)-1
        am=a(m); am1=a(m+1);
        n=intersect(intersect(list_E{am},list_E{am1}),list_E{k}); % find elements that include the current edge
        if ~isempty(n)
            dsm=[mcy(n)-ym(m), xm(m)-mcx(n)]; % compute the normals of dual grid
            dsm1=[ym(m+1)-mcy(n), mcx(n)-xm(m+1)];
            
            v=[Px(k)-mcx(n), Py(k)-mcy(n)];     % compute vectors connecting node to center of mass
            s(m,:)=s(m,:)-dsm*sign(dot(dsm,v)); % add contribution from edges of dual grid with correct sign
            s(m+1,:)=-dsm1*sign(dot(dsm1,v));
        end
    end
    n=intersect(intersect(list_E{a(1)},list_E{am1}),list_E{k});
    if (~isempty(n) && m>=2)
        dsm=[mcy(n)-ym(m+1), xm(m+1)-mcx(n)];
        dsm1=[ym(1)-mcy(n), mcx(n)-xm(1)];
        v=[Px(k)-mcx(n), Py(k)-mcy(n)];
        s(m+1,:)=s(m+1,:)-dsm*sign(dot(dsm,v));
        s(1,:)=s(1,:)-dsm1*sign(dot(dsm1,v));
    end
    list_N{k}=s;
end
end

