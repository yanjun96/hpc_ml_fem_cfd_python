function [nodes_E, volume_E] = computeVolume(P,connectivity)
% computeVolume computes volume of each element.
% It also removes those with zero volume (a bug in Matlab function
% delaunayTriangulation)
%
% Ardeshir Hanifi
% Feb. 2020

nodes_E=connectivity;
NT=length(nodes_E);
NE =length(nodes_E(1,:));

eps1=1e-8;
vol=zeros(NT,1);

for k=1:NT
    ii=nodes_E(k,:);
    vv1=[P(ii(2),:)-P(ii(1),:), 0];
    vv2=[P(ii(3),:)-P(ii(1),:), 0];
    vol(k)=norm(cross(vv1,vv2))*0.5;
    
    if NE==4 % this assumes that nodes of each element are orderd anticlockwise
        vv1=[P(ii(4),:)-P(ii(1),:), 0];
        vv2=[P(ii(3),:)-P(ii(1),:), 0];
        vol(k)=vol(k)+norm(cross(vv1,vv2))*0.5;
    end
end

kk=vol>eps1;
nodes_E=nodes_E(kk,:);
volume_E=vol(kk);

NT1=length(volume_E);

if NT1<NT
    disp([num2str(NT-NT1),' triangles removed due to zero volume.'])
end

end

