function [x,it]= my_GC( A,b,x,toll,ITMAX) 
% function x= my_GC( A, x,b) applica il metodo del gradiente coniugato 
% A matrice del sistema
% b     termine noto
% x     valore iniziale 
% toll  tolleranza
% ITMAX massimo numero d'iterazioni (default 10000)
n=size(A,1);
if nargin==5
    ITMAX= 10000;
end
normb=norm(b);
r = b - A * x;
it = 0;
p=r;
while norm(r)/normb > toll && it<ITMAX
    it = it+1;
    c = norm(r)^2;
    z = A* p;
    alpha = c / ( p' * z);
    x = x + alpha * p ;
    r = r - alpha * z ;
    beta = - norm( r)^2/c;
    p = r - beta * p ;
    
end
if it ==ITMAX 
    warning('Raggiunto il numero masismo di iterazioni');
end
end    