function main_Richardson
 n = 5; 
 A = gallery('poisson', n) ;
 b = ones(n^2,1) ; 
 x0 = zeros(n^2,1);
 toll = 1e-5;

%  xes = A\b; %mi tolgo un warning
 B = my_ILU(A);
 IL = eye(size(A)) + tril(B,-1) ; 
 IU = triu(B);
 P = IL * IU;
autPmeno1A=eig(inv(P)*A);
 % il metodo connverge se 0 < alpha < 2/lamda 1.
 % Dal teorema di Courant-Fisjer lamda 1 è minore di lmax(A)/lmin(P) 
 amax = 2 / max(autPmeno1A);
 fprintf("I valori accettabili per alpha sono quelli compresi tra %d e %f",0,amax);
 
 for n = 5:5:30
     fprintf("\n\nN=%d con fattorizzazione LU\n",n);
     B = my_LU(A);
     L = eye(size(A)) + tril(B,-1);
     U = triu(B);
     P = L* U ;
     minP= eigs(P,1,'smallestabs');
     maxP = eigs(P,1,'largestabs');
     maxA = eigs(A,1,'largestabs');
     minA= eigs(A,1,'smallestabs');
     aott = 2/(minA/maxP  + maxA/minP);
     tic;
     my_Richardoson(A,P,b,x0,aott,toll);
     toc;
     
     fprintf("N=%d con fattorizzazione LU a bande\n",n);
     tic;
     B = my_LU_bande(A,n,n);
     L = eye(size(A)) + tril(B,-1);
     U = triu(B);
     P= L*U;
     minP= eigs(P,1,'smallestabs');
     maxP = eigs(P,1,'largestabs');
     maxA = eigs(A,1,'largestabs');
     minA= eigs(A,1,'smallestabs');
     aott = 2/(minA/maxP  + maxA/minP);
     my_Richardoson(A,P,b,x0,aott,toll);
     toc;
     
 end