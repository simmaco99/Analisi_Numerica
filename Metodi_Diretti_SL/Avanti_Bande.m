function x = Avanti_Bande(L,LOWER,b)
% x = Avanti_Bande(L,LOWER,b) restituisce la soluzione del sistema lineare Lx = b
% utilizzando la sostituzione in avanti considerando L come matrice
% triangolare inferiore con LOWER bande
% L matrice triangolare inferiore
% LOWER numero di bande inferiori
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

if (LOWER> n-1) 
    error('Numero di bande inferiori dichiarate  eccessive');
end


if L~= tril(L)
    warning('La matrice del sistema non è triangolare inferiore')
end


x= zeros(n,1);
x(1) = b(1)/L(1,1);

for i = 2: n 
    c = max(i-LOWER,1);
    x(i) = b(i) - L(i,c:i-1) * x(c:i-1);
    x(i) = x(i) / L(i,i);
end

end

