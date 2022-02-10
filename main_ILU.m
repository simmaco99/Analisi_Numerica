function main_ILU
% Il programma esegue le seguenti operazioni sulla matrice di Poisson:
% 1. Verifica la struttura e le proprietà della matrice:
% 2. Valuta e visualizza graficamente come cresce il numero di condizionamento K2(A)
%   rispetto a n e a N = n^2
% 3. Calcola la fattorizzazione LU e la fattorizzazione LU incompleta di A
% 4. Determinare una stima del massimo e minimo autovalore di inv(P)A dove P
%   è la matrice ottenuta dalla fattorizzazione ILU di A
% 5. Calcola alcuni valori "fondamentali" per i metodi iterativi applicati
%   ad A
pulisci
n=5;
A= gallery('poisson',n);
imagesc(A);
axis square
title("Matrice di Poisson")
colorbar
[i,j]=find(A);
nozero=unique(i-j); %elementi diversi
disp(nozero); % diagonali non nulle principale, sotto sopra e n-esima sotto e sopra
%calcoliamo i valori sulle diagonali
d=zeros(length(nozero),1);
for i=1:length(nozero)
    z= full(unique(diag(A,nozero(i))));
    d(i) =z(1);
end

fprintf("La matrice ha 4 diagonali non nulle:")
fprintf(" %d" ,nozero);
fprintf("\nSu tali diagonali vale constantemente:")
fprintf(" %d",d);
%vale costantemente -1 sulle 4 diagonali non principali mentre 4 sulla
%diagonale  principale -> la matrice è a dominal diagonanza stretta -> sdp

%condizionamento rispetto n
figure()
c = zeros(n,1);
for n=1:15
    A =gallery('poisson',n);
    c(n) = cond(full(A));
end
v = 1:n;
subplot(2,1,1);
plot(v,c);
title('Condizionamento matrice di poisson 2d nxn')
subplot(2,1,2);
plot(v.^2, c);
title('Condizionamento in funzione di n^2')
figure()

% fattorizzazione LU e ILU
A= gallery('poisson',5);
B = my_LU(A);
N = size(A);
L = eye(N) + tril(B,-1) ;
U = triu(B);
C= my_ILU(A);
IL = speye(N) + tril(C,-1);
IU = triu(C);
subplot(2,3,1)
spy(A)
title('matrice originale')
subplot(2,3,2)
spy(L)
title('parte inferiore di LU')
subplot(2,3,3)
spy(U)
title('parte superiore di LU')
subplot(2,3,4)
spy(A)
title('Matrice originale')
subplot(2,3,5)
spy(IL)
title('parte inferiore di ILU')
subplot(2,3,6)
spy(IU)
title('parte superiore di ILU')

P = IL * IU;
maxa = eigs(A,1,'largestabs');
mina = eigs(A,1,'smallestabs');
% dal teorema di Courant-Fisher  autovalori di inv(P)* A sono compresi in
% [lmin(A)/lmax(P) , lmax(A)/lmin(P)]

condA = maxa/mina;
condPA = cond(full(inv(P)*A));
fprintf('\n\n\nK_2(A) \t\t\t\t\t%f\nK_2(inv(P)*A)\t\t\t\t%f\n(K_2(A)-1)/(K_2(A)+1)\t\t\t%f\n(K_2(inv(P)*A)-1)/(K_2(inv(P)*A)+1)\t%f\n',condA,condPA,(condA-1)/(condA + 1),(condPA-1)/(condPA + 1));

end