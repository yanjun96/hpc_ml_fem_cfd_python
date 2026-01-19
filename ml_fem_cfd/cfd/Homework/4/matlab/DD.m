function A = DD(n,h)
% DD(n,h)
%
% One-dimensional finite-difference derivative matrix 
% of size n times n for second derivative:
%
% This function belongs to SG2212.m


for j=2:n
    D(j,j)=-2;
    D(j,j+1)=1;
    D(j,j-1)=1;
end
D(1,1)=-1;
D(1,2)=1;
D(n,n)=-1;
D(:,n+1) = [];


A =(1/h)^2.*D;
