function b = LoadAssembler2D_Neumann(p,t,f,N_bound)
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


b_result=b;
element=find(p(1,:)~=0);
matching_indices = any(ismember(element,b),1);
b_result(matching_indices)=b(matching_indices);
b= b_result;
end
  

