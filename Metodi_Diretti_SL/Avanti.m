function x = Avanti(L,b)
% x = Avanti(L,b) restituisce la soluzione del sistema lineare Lx = b
% utilizzando la sostituzione in avanti 
% L matrice triangolare inferiore
% b vettore colonna dei termini noti

n=size(L,1);
if n ~= size(L,2) 
    error('Matrice non quadrata')
end
if n ~= length(b) 
    error('Dimensioni incompatibili') 
end

if min(abs(diag(L)))==0 
    error('L non invertibile')
end

if L~= tril(L)
    warning('La matrice del sistema non è triangolare inferiore')
end

x= zeros(n,1);
x(1) = b(1)/L(1,1);

for i = 2: n 
    x(i) = b(i) - L(i,1:i-1) * x(1:i-1);
    x(i) = x(i) / L(i,i);
end

end

