function A = my_LU(A)
% A = my_LU(A) fattorizzazione LU della matrice senza pivoting
% Per ottenere le due matrici 
%   N = size(A) 
%   L = eye(N) + tril(A,-1) ; 
%   U = triu(A);
    [n,~]= size(A);
    for i = 1: n 
    if A(i,i) ==0 
        error('Elemento pivotale nullo') 
    else
        A(i+1:end,i)=  A(i+1:end,i) /A(i,i);
        A(i+1: end, i+1:end)  = A(i+1:end,i+1:end) - A(i+1:end, i).* A(i,i+1:end);
        
    end
    end
end