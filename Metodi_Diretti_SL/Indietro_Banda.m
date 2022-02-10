function x = Indietro_Banda(U,UPPER,b)
% x = Indietro_Banda(U,UPPER,b) restituisce la soluzione del sistema lineare Ux = b
% utilizzando la sostituzione all'indietro considerando U come matrice
% triangolare superiore con UPPER bande
% U matrice triangolare inferiore
% UPPER numero di bande superiori
% b vettore colonna dei termini noti
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

if (UPPER> n-1) 
    error('Numero di bande superiori dichiarato eccessivo');
end


if U ~= triu(U)
    warning('La matrice del sistema non è triangolare superiore')
end

x= zeros(n,1);
x(n) = b(n)/U(n,n);

for i = n-1: -1: 1
    col=i+1: min(i+UPPER,n);
    x(i) = b(i) - U(i,col) * x(col);
    x(i) = x(i) / U(i,i);
end

end
