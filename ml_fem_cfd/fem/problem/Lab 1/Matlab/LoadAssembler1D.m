function b=LoadAssembler1D(x,f,g)
n=length(x)-1;  %number of subintervals
b=zeros(n+1,1); % allocate mass matrix

for i=1:n % loop over subintervals
    h=x(i+1)-x(i); % interval length
    b(i)= b(i)+f(x(i))*h/2; % add h/2 to b(i)
    b(i+1)= b(i+1)+f(x(i+1))*h/2; % add h/2 to b(i,i)
end


b(1)=g(1);
b(n+1)=g(2);

end
