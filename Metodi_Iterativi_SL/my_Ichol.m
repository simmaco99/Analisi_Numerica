function A = my_Ichol(A)
% A = Cholesky(A) calcola il termine triangolare superiore della
% fattorizzazione di Cholesky incompleta
% DA VETTORIALIZZARE
n = size(A,1);
A(1,1) = sqrt(A(1,1));
for j = 2:n
     if A(j,j)==0 
        error('Matrice non definita positiva');
    end
    for i = 1: j-1
        if (A(i,j)~=0) 
            A(i,j) = (A(i,j) - A(1:i-1,i)' * A(1:i-1,j))/A(i,i);
        end
    end
    A(j,j) = sqrt(A(j,j) - A(1:j-1,j)'* A(1:j-1,j));
    
end
A = triu(A);
end

