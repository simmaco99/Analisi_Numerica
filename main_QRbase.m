function main_QRbase
% Si approssimano gli autovalori della matrica A (random) e di A+A^t con il metodo  QR base.
% Si plottano gli errori tra autovalori calcolati e esatti in scala
% semilogaritmic

pulisci
n = 5;
ITMAX=10000;
toll = 1e-12;
A = rand(n);
As = A + A';

as =sort( eig(As));
[~,~,err] = my_QRBase(As,ITMAX,toll,as,1);
subplot(1,2,1);
semilogy(err);
title("A +A^t");

a = sort(eig(A));
[~,~,err]= my_QRBase(A,ITMAX,toll,a,0);
% lamda = Auto_QuasiTriangolare(T,1e-6);
% lamda = sort(lamda);
subplot(1,2,2);
semilogy(err);
title("A");
end