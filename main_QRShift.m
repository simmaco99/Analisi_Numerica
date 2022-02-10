function main_QRShift
% Si approssimano gli autovalori della matrica A (data) tramite QR-Hessemberg e
% QR con shift. Si plottano gli errori tra autovalori calcolati e esatti in scala semilogaritmica

pulisci;
A= [ 17 24 1  8  15
    23 5  7  14 16
    4  6  13 20 22
    10 12 19 21 3
    11 18 24 2  9 ];
ITMAX= 1000;
toll = 1e-10;
a = sort(eig(A));
[~,~,err] = my_HessembergQR(A,ITMAX,toll,a,1);
%  lambda1 = diag(T) ; % la matrice ha autovalori reali
subplot(1,2,1);
semilogy(err)
title('Hessemberg-QR')

[~,~,err] = my_QRShift(A,ITMAX,toll,a,1);
% lambda2 = diag(T);
subplot(1,2,2);
semilogy(err)
title('QR con shift');
end
