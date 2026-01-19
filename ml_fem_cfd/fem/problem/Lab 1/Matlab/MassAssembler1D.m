function M=MassAssembler1D(x,p)
n=length(x)-1; % number of subintervals
M=zeros(n+1,n+1); % allocate mass matrix
for i=1:n % loop over subintervals
    xmid=(x(i+1)+x(i))/2;  %inerval mid point
    pmid=p(xmid);
    h=x(i+1)-x(i); % interval length
    M(i,i)= M(i,i)+pmid*h/3; % add h/3 to M(i,i)
    M(i,i+1)= M(i,i+1)+pmid*h/6;
    M(i+1,i)= M(i+1,i)+pmid*h/6;
    M(i+1,i+1)= M(i+1,i+1)+pmid*h/3;
end
M(1,1)=0;
M(1,2)=0;
M(n+1,n+1)=0;
M(n+1,n)=0;
end