function [v] = mshift(u)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
n=length(u);
m=(n-1)/2;
as=u;
as(1:2:n)=u(m+1:end);
as(2:2:n-1)=u(1:m);
v=zeros(n-2,3);
for k=1:n-2
    v(k,:)=as(k:k+2);
end
end

