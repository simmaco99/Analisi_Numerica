function [sol,it,res]=main_Iterativi
% Il programa risolve il sistema lineare Ax = b (dova  A è matrice di Poisson e b =onnes(n,1)
% mediante i seguenti algoritmi:
% 1. Jacobi
% 2. Gauss-Seidel
% 3. SOR (con parametro 1.3)
% 4. Richardoson non precondizionato e parametro ottimo
% 5. Richardson precondizionato e parametro ottimo
% 6. Steepest descendt
% 7. Steepest descendt precondizionato con P ottenuta da Cholesky incompleta
% 8. Gradiente coniugato non precondizionato
% 9. Comando backslasch di MATLAB
%
% Per ogni metodo viene specificato l'errore commesso (valutando il
% residuo), il tempo di CPU impiegato e il numero d'iterazioni
pulisci
n=10;
toll = 1e-13;

res= zeros(8,1);
ITMAX =10000;

A = gallery('poisson',n);
b = ones(n^2,1);
x0 = zeros(n^2,1);
sol = zeros(n^2,9);
it= zeros(8,1);
fprintf("Tolleranza:"); disp(toll)
fprintf("\nJacobi\n")
tic;
[sol(:,1),it(1)] = my_Jacobi(A,b,x0,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(1));
res(1) = norm(A*sol(:,1)-b);
fprintf("Errore: "); disp(res(1));


fprintf("Gauss-Seidel\n")
tic;
[sol(:,2),it(2)] = my_SOR(A,b,x0,1,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(2));
res(2) = norm(A*sol(:,2)-b);
fprintf("Errore: "); disp(res(2));


fprintf("SOR (con parametro 1.3)\n")
tic;
[sol(:,3),it(3)] = my_SOR(A,b,x0,1.3,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(3));
res(3) = norm(A*sol(:,3)-b);
fprintf("Errore: "); disp(res(3));

maxA = eigs(A, 1,'largestabs');
minA = eigs(A,1,'smallestabs');
aott = 2/(maxA+minA);

fprintf("Richardoson non precondizionato e parametro ottimo\n")
tic;
[sol(:,4),it(4)] = my_Richardoson(A,eye(n^2),b,x0,aott,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(4));
res(4) = norm(A*sol(:,4)-b);
fprintf("Errore: "); disp(res(4));

C= my_ILU(A);
IL = speye(size(A)) + tril(C,-1);
IU = triu(C);
P = IL * IU;
maxP = eigs(P, 1,'largestabs');
minP = eigs(P, 1,'smallestabs');
lmin= minA/maxP;
lmax = maxA/minP;
aott2 = 2 /(lmin + lmax);

fprintf("Richardson precondizionato e parametro ottimo\n")
tic;
[sol(:,5),it(5)] = my_Richardoson(A,P,b,x0,aott2,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(5));
res(5) = norm(A*sol(:,5)-b);
fprintf("Errore: "); disp(res(5));

fprintf("Steepest descendt\n")
tic;
[sol(:,6),it(6)] = my_grad(A,eye(n^2),b,x0,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(6));
res(6) = norm(A*sol(:,6)-b);
fprintf("Errore: "); disp(res(6));

H = my_Ichol(A);
P2 =H' * H;
fprintf("Steepest descendt precondizionato con P ottenuta da Cholesky incompleta\n")
tic;
[sol(:,7),it(7)] = my_grad(A,P2,b,x0,toll,ITMAX);
toc;
fprintf("Iterazioni: %d\n",it(7));
res(7) = norm(A*sol(:,7)-b);
fprintf("Errore: "); disp(res(7));

fprintf("Gradiente coniugato non precondizionato\n")
tic;
[sol(:,8),it(8) ] = my_GC(A,b,x0,toll,ITMAX);
fprintf("Iterazioni: %d\n",it(8));
res(8) = norm(A*sol(:,8)-b);
fprintf("Errore: "); disp(res(8));

sol(:,9) = A\b;



% fprintf('Jacobi: %d iterazioni\nGauss-Seidel: %d iterazioni\nSORcon parametro 1.3: %d iterazioni\nRichardoson non precondizionato e alpha ottimo: %d iterazioni\nRichardson precondizionato e alpha ottimo: %d iterazioni\nSteepest descendt: %d iterazioni\nSteepest descendt precondizionato P ottenuta da Cholesky incompleta: %d iterazioni\nGradiente coniugato non precondizionato: %d iterazioni\n',it)



end

