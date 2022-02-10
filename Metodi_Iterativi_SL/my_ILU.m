function A = my_ILU(A)
% A = my_ILU(A) fattorizzazione LU incompleta della matrice A  senza pivoting
% Per ottenere le due matrici 
%   N = size(A) 
%   L = eye(N) + tril(A,-1) ; 
%   U = triu(A);
n =size(A,1) ;
for k = 1: n-1 
    if A(k,k) ==0  
        error('elemento pivotale nullo');
    end
    % i contiene gli indici di riga degli elementi non nulli sulla colonna k sotto la diagonale
    i = find(A(k+1:end,k))+k;
    A(i,k) = A(i,k)./A(k,k);
    for j =1:length(i) 
        riga = i(j);
        s = find(A(riga,k+1:end)) + k ;
        A(riga,s) = A(riga,s) - A(riga,k)* A(k,s) ;
    end
end             
end