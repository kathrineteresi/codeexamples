clc; clear all; close all;



a = 0 
b = 1
c = 0 
d = 1

N= 3


h = 1/N;

%% To construct the b vector

for i = 0:N

x(i+1) = a + i*h;

end

y = x;

[X,Y] = meshgrid(x,y);

XX = X(2:end-1, 2:end-1);
YY= Y(2:end-1, 2:end-1);

%%f = (-2*(pi^2))*((cos(2*pi*XX)).*(sin(pi*YY)).^2 + ((sin(pi*XX)).^2).*cos(2*pi*YY));


B = (h^2)*f;

b=B(:);



%% To construct matrix A

main = 4*ones(1,(N-1)^2);
last= -1*ones(1, (N-1)^2 - (N-1));

ul= -1*ones(1,(N-1)^2 -1);



%%alternating the ul for the first upper and second upper. 

for i = 0:length(ul)-1

if mod(i+1,N-1) ==0;
ul(i+1) = 0;
end

end

A = diag(main,0) + diag(ul,1) + diag(ul,-1) + diag(last,(N-1)) + diag(last,-(N-1))

w = A\b;

Utrue = (sin(pi*X).^2).*(sin(pi*Y).^2);
figure ('DefaultAxesFontSize',18);
mesh (X, Y, Utrue);
xlabel ('x'); ylabel ('y'); zlabel ('u_{true}');
grid off; box on;
title('True solution')


% Reshape solution vector, notice it has only the interior points:
Uin = reshape (w, [N-1, N-1]);

% Construct U including boundary points for homogenous Dirichlet b.c.:
U = zeros (length(x), length(y));
U(2:end-1,2:end-1) = Uin;

figure ('DefaultAxesFontSize',18);
mesh (X, Y, U);
xlabel ('x'); ylabel ('y'); zlabel ('u');
grid off; box on;
title('Numerical solution')

figure ('DefaultAxesFontSize',18);
mesh (X, Y, abs(U-Utrue));
xlabel ('x'); ylabel ('y'); zlabel ('error');
grid off; box on;
title('Error')

utrue = Utrue(:);
u     = U(:);
E = norm(utrue-u, inf)


