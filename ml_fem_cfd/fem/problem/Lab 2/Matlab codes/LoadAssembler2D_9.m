function b = LoadAssembler2D_9(p,t,f,N_bound)
np = size(p,2); % number of global nodes
nt = size(t,2); % number of triangles
b = zeros(np,1); % right hand side vector
n=np;
for K = 1:nt
loc2glb = t(1:3,K); % local to global index
x = p(1,loc2glb);
y = p(2,loc2glb);
area = polyarea(x,y);
% element load vector
bK = [f(x(1),y(1));
f(x(2),y(2));
f(x(3),y(3))]/3*area;
% add element loads to b
b(loc2glb) = b(loc2glb) + bK;
end


b(1:N_bound)=9;
%b(1,1)=0+kappa(1);
% b(1,4)=0+kappa(1);
% b(1,4)=0+kappa(1);

% element=find(p(1,:)==0);
% for i=1:length(element)
% b(1,element(i))=0+kappa(1);
% i=i+1;
% end
end