function [x,it] = my_grad(A, P,b,x, toll, ITMAX)
% x = grad_pre(A, P, x, b, toll, ITMAX) applicca il metodo del gradiente steepest descent precondizionato
% A     matrice del sistema
% P     precondizionamento
% b     termine not
% x     valore iniziale 
% toll  tolleranza
% ITMAX massimo numero iterazione (opzionale di default 1000) 

if nargin==5
    ITMAX= 10000;
end

r = b - A * x;
it = 0;

% P = my_LU(P);
%   L = eye(size(P)) + tril(P,-1) ; 
%   U = triu(P);
    [n,~]= size(A);

while norm(r)/norm(b) > toll && it<ITMAX
    it = it+1;
    z = P\r; 
    % y = U\r;
    % z = L\y;
    w = A *z;
    alpha = (z' * r)/( z' * w) ;
    
    x = x + alpha* z;
    r = r - alpha*w;
    
end
if it ==ITMAX 
    warning('Raggiunto il numero masismo di iterazioni');
end
end

    
