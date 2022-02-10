function [x,it]= my_Jacobi(A,b,x,toll,ITMAX)
% [x,it]= my_Jacobi(A,b,x,toll,ITMAX) applica il metodo di Jacobi
% A     matrice del sistema
% b     termine noto
% x v   ettore iniziale
% toll  tolleranza
% ITMAX numero d'iterazioe (default = 1000)

if nargin==4
    ITMAX = 1000;
end

it =0 ;
v = diag(A);
B = A -diag(v);
r = b - A * x;
r0 = norm(r);
err = r0;
while it < ITMAX  && err > toll
    it = it +1;
    x = ( b - B * x)./v ;
    r =  b - A*x;
    err = norm(r)/r0; 
end
if it ==ITMAX 
    warning('Raggiunto il numero masismo di iterazioni');
end
end
