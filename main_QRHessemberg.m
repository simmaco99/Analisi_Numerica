function main_QRHessemberg
% Si approssimano gli autovalori della matrica A (random) e di A+A^t con il metodo QR-Hessemberg e
% QR base Si plottano gli errori tra autovalori calcolati e esatti in scala
% semilogaritmica e si calcola il tempo di CPU impiegato dai due metodi

pulisci

n = 5; %dimensione della matrice

ITMAX=10000;
toll=1e-8;
A = rand(n);
As = A + A';
as= sort(eig(As));
fprintf("Calcolo autovalori di A+A^t\n\n");
fprintf("Metodo QR in forma di Hessemberg: ");
tic;
[~,~,err] = my_HessembergQR(As,ITMAX,toll,as,1);
toc;
subplot(1,2,1);
semilogy(err)
title("Matrice simmetrica: Hessemberg-QR: ");

fprintf("Metodo QR base");
tic;
[~,~,err]=my_QRBase(As,ITMAX,toll,as,1);
toc;
subplot(1,2,2);
semilogy(err);
title('Matrice simmetrica: QR base')

figure()
fprintf("\n\nCalcolo autovalori di A\n");

fprintf("Metodo QR in forma di Hessemberg: ");
a = sort(eig(A));
tic;
[~,~,err] = my_HessembergQR(A,ITMAX,toll,a,0);
toc;
subplot(1,2,1);
semilogy(err);
title('Matrice random: Hessemberg-QR');

fprintf("Metodo QR base: ");
tic;
[~,~,err]=my_QRBase(A,ITMAX,toll,as,0);
toc;
subplot(1,2,2);
semilogy(err);
title('Matrice random: QR base')


end