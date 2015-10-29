clc; clear all; close all;

a = 0 
b = 1
c = 0 
d = 1

N= 4


h = 1/N;

%% To construct the b vector

for i = 0:N

x(i) = a + i*h

end

y = x;

[X,Y] = meshgrid(x,y);

XX = X(2:end-1, 2:end-1);
YY= Y(2:end-1, 2:end-1);

return;
f = (-2*(pi^2))*((cos(2*pi*XX))*(sin(pi*YY)).^2 + ((sin(pi*XX)).^2)*cos(2*pi*YY))

B = -(h^2)*f(X,Y)

b=B(:);



%% To construct matrix A

main = 4*ones(1,(N-1)^2);
last= -1*ones(1, (N-1)^2 - (N-1));

ul= -1*ones(1,(N-1)^2 -1);

%%alternating the ul for the first upper and second upper. 

for i = 0:length(ul)-1

if mod(i+1,N-1) ==0
u(i+1) = 0
end
end

A = diag(main,0) + diag(ul,1) + diag(ul,-1) + diag(last,(N-1)) + diag(last,-(N-1))
