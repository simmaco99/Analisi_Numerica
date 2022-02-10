function x = Indietro(U,b)
% x = Indietro(U,b) restituisce la soluzione del sistema lineare Ux = b
% utilizzando la sostituzione in avanti 
% U matrice triangolare superiore
% b vettore colonna dei termini noti
% 

n=size(U,1);
if n ~= size(U,2) 
    error('Matrice non quadrata')
end
if n ~= length(b) 
    error('Dimensioni incompatibili') 
end

if min(abs(diag(U)))==0 
    error('L non invertibile')
end

if U ~= triu(U)
    warning('La matrice del sistema non è triangolare superiore')
end

x= zeros(n,1);
x(n) = b(n)/U(n,n);

for i = n-1: -1: 1
    x(i) = b(i) - U(i,i+1:n) * x(i+1:n);
    x(i) = x(i) / U(i,i);
end

end

