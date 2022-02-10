function main_GMRES
% La funzione risolve il sistema lineare Ax = b mediante l'algoritmo GMRES
% specificando il numero d'iterazioni, la tolleranza
n=10;
toll=1e-6;
m = 10; % massima dimensione sottospazio di Krylov
A = rand(n);
b = rand(n,1);
x0 = zeros(n,1);
[x,k,it] = GMRES(A,b,x0,m,toll);
if k> m
    fprintf("In Arnoldi c'è stato un breakdown\n");
end
fprintf("Iterazioni: %d\nErrore: ",it);
disp(norm(x-A\b))

end