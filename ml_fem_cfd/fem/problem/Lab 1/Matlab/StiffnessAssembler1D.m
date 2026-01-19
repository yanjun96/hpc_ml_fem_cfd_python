function A=StiffnessAssembler1D(x,k,kappa)

n=length(x)-1; % number of subintervals
A=zeros(n+1,n+1); % allocate stiffness matrix
for i=1:n % loop over subintervals
    h=x(i+1)-x(i); % interval length
    xmid=(x(i+1)+x(i))/2;  %inerval mid point
    
    A(i,i)=A(i,i)+ k(xmid)/h; 
    A(i,i+1)=A(i,i+1) -k(xmid)/h;
    A(i+1,i)=A(i+1,i) -k(xmid)/h;
    A(i+1,i+1)=A(i+1,i+1)+ k(xmid)/h;
end
A(1,1)=A(1,1)+kappa(1);
A(n+1,n+1)=A(n+1,n+1)+kappa(2);
A(1,1)=1+kappa(1);
A(1,2)=0;
A(n+1,n+1)=1+kappa(2);
A(n+1,n)=0;
end
