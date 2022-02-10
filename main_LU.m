function main_LU
% Data la matrice 3 diagonali con:
% 6 sulla diagonale principale
% -1 sulla seconda sopra diagonale
% -1 sulla seconda sotto diagonale
%
% Il programma calcola:
% La fattorizzazione LU e LU a bande confrontando (confrontandola con quella di MATLAB)
% I tempi di CPU impiegati dalle due fattorizzazioni
% La fattorizzazione di Cholesky (confrontandola con quella di MATLAB)
% Risolve il sistema lineare Ax= b utilizzando la fattorizzazione LU e
% sostituzione avanti-indietro (confrontando i tempi di CPU tra algoritmi a
% bande e non)
pulisci

N=1000;
A = 6*eye(N) -diag(ones(N-2,1),2) - diag(ones(N-2,1),-2);
b = ones(N,1);
fprintf("Fattorizzazione LU: ")
tic;
LU= my_LU(A);
toc;
L = eye(N) + tril(LU,-1) ;
U = triu(LU);
[LL,UU]=lu(A);
checkL = sum(L~=LL,'all');
checkU=sum(U~=UU,'all');
if checkL + checkU ==0
    fprintf("La fattorizzazione LU calcolata coincide con quella di MATLAB\n");
else
    fprintf("La fattorizzazione LU calcolata non coincide con quella di MATLAB. L'errore in norma infinito \`e: %f\n",norm(L-LL,'inf')+norm(U-UU,'inf'));
end

fprintf("\n\nFattorizzazione LU a bande: ")
tic;
LU = my_LU_bande(A,2,2);
toc;

Lb = eye(N) + tril(LU,-1) ;
Ub = triu(LU);

checkLb = sum(Lb~=LL,'all');
checkUb=sum(Ub~=UU,'all');

if checkLb + checkUb ==0
    fprintf("La fattorizzazione LU a bande calcolata coincide con quella di MATLAB\n");
else
    fprintf("La fattorizzazione LU a bande calcolata non coincide con quella di MATLAB. L'errore in norma infinito \`e: %f\n",norm(Lb-LL,'inf')+norm(Ub-UU,'inf'));
end


H= my_chol(A);
HH = chol(A,'upper');
checkH = sum(H~=HH,'all');

if checkH ==0
    fprintf("\n\nLa fattorizzazione di Cholesky calcolata coincide con quella di MATLAB\n");
else
    fprintf("\n\nLa fattorizzazione di Cholesky calcolata non coincide con quella di MATLAB. L'errore in norma infinito \`e: %f\n",norm(H-HH,'inf'));
end

x= A\b; %soluzione esatta

fprintf("\n\nNon sfruttando la struttura: ");
%non sfruttando la banda
tic;
LU= my_LU(A);
L = eye(N) + tril(LU,-1);
U = triu(LU);
y = Avanti(L,b);
sol1= Indietro(U,y);
toc;
fprintf("Errore: ");
e = norm(x-sol1);

disp(e);

fprintf("Sfruttando la struttura a bande: ");

%sfruttando la banda
tic;
LU = my_LU_bande(A,2,2);
Lb = eye(N) + tril(LU,-1) ;
Ub = triu(LU);
y = Avanti(Lb,b);
sol2= Indietro(Ub,y);
toc;

eb = norm(x-sol2);


fprintf("Errore: ")
disp(eb);
end