function A = StiffnessAssembler2D(p,t,a,N_bound) 
np = size(p,2);
nt = size(t,2); 
n=np;
A = sparse(np,np); % allocate stiffness matrix 
for K = 1:nt
    loc2glb = t(1:3,K); % local-to-global map 
    x = p(1,loc2glb); % node x-coordinates 
    y = p(2,loc2glb); % node y- 
    [area,b,c] = HatGradients(x,y); 
    xc = mean(x); 
    yc = mean(y); % element centroid 
    %abar = a(xc,yc); % value of a(x,y) at centroid
    abar = a;
    AK = abar*(b*b'+c*c')*area; % element stiffness matrix 
    A(loc2glb,loc2glb) = A(loc2glb,loc2glb)+ AK; % add element stiffnesses to A
end

for i=1:N_bound
A(i,:)=0;
A(i,i)=1;
end

end