function A=my_LU_bande(A,LOWER,UPPER)    
% A = myLU_bande(A,p,q) restituisce la fattorizzazione LU a bande della matrice A (senza pivoting) 
% A matrice a banda 
% LOWER numero di bande inferiori
% UPPER numero di bande superiori
% Per ottenere le due matrici 
%   N = size(A) 
%   L = eye(N) + tril(A,-1) ; 
%   U = triu(A);
    [n,~]= size(A);
    for i = 1: n 
        if A(i,i) ==0
            error('Elemento pivotale nullo')
        else
        riga = i+1: min(n,i+LOWER);
        col = i+1: min(n,i+UPPER);
        A(riga,i)=  A(riga,i) /A(i,i);
        A(riga, col)  = A(riga,col) - A(riga, i).* A(i,col);
        
        end
    end
end