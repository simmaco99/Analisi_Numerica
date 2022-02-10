function [x,it] = my_Richardoson(A, P,b,x,alpha, toll, ITMAX)
% x = my_Richardson(A, P, x, b, toll, ITMAX) applicca il metodo di
% Richardson stazionario
% A     matrice del sistema
% P     precondizionamento
% b     termine noto
% x     valore iniziale 
% alpha parametro (passo)
% toll  tolleranza
% ITMAX massimo numero iterazione (opzionale di default 1000) 

if nargin==6
    ITMAX= 10000;
end
r = b - A * x;
it = 0;
while norm(r)/norm(b) > toll && it<ITMAX
    it = it+1;
    z = P\r;
    w = A * z;
    x = x + alpha* z;
    r = r - alpha*w;
    
end

if it ==ITMAX 
    warning('Raggiunto il numero masismo di iterazioni');
end
end
    
