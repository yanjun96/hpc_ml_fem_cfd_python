function [f,dfxa,dfya,ddfa] = setf(P)
% setf computes values of the test function and its analytic
% derivatives to be used for comparison
%
% Ardeshir Hanifi
% Feb. 2020

x=P(:,1);
y=P(:,2);


for i=1:length(P)
 
f(i)=20;  % Here the values of the function need to be added (must be an array (NP x 1)) 
dfxa(i)=0;   % Here the values of the analytical x-derivative need to be added (must be an array (NP x 1))
dfya(i)=0;   % Here the values of the analytical y-derivative need to be added (must be an array (NP x 1))
ddfa(i)=0; % Here the values of the laplacian need to be added (must be an array (NP x 1))

f=f';
dfxa=dfxa';
dfya=dfya';
ddfa=ddfa';

%end

end


%%

%for i=1:length(P)
 
%f(i)=sin(pi*x(i)).*cos(pi*y(i));  % Here the values of the function need to be added (must be an array (NP x 1)) 
%dfxa(i)=pi.*cos(pi.*x(i)).*cos(pi.*y(i));   % Here the values of the analytical x-derivative need to be added (must be an array (NP x 1))
%dfya(i)=-pi.*sin(pi.*x(i)).*sin(pi.*y(i));   % Here the values of the analytical y-derivative need to be added (must be an array (NP x 1))
%ddfa(i)=-2*pi*pi.*sin(pi.*x(i)).*cos(pi.*y(i)); % Here the values of the laplacian need to be added (must be an array (NP x 1))

%f=f';
%dfxa=dfxa';
%dfya=dfya';
%ddfa=ddfa';

%end

end

