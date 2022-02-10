function main_QR
% Il programma calcola la fattorizzazione QR di due matrici date e verifica
% che le matrici Q siano effettivamente ortogonali
% Trova inoltre la soluzione del problema dei minimi quadrati applicato a
% A1x=b in 3 differenti modi
% Usando le equazioni normali con metodo di Cholesky
% Usando la fattorizzazione QR
% Soluzione esatta con il comando \ di MATLAB

pulisci

A= [ 3 0; 4 5 ; 0 4 ] ;
A2 = [ 3 0 ; 4 0 ; 0 4 ] ;
b = [ 1 2 1]';
[Q,R]=my_QR(A);
Q2=my_QR(A2);

I = transpose(Q)*Q;
I2 = transpose(Q2)*Q2;

a1=norm(I-eye(2));
a2= norm(I2-eye(2));


%Risolvo (A^t A) x = A^t b
H = transpose(A)*A;
c = transpose(A)*b;

H = my_chol(H);
y= Indietro(H,c);
xchol = Avanti(transpose(H),y);

% x* = inv(R) * Qt b
xqr= Indietro(R,transpose(Q)*b);
norm(xchol-xqr);


% matrici pseudorandom
A = randn(200,20);
b =randn(200,1);

%Easatta
esatta= A\b;
res =norm(A*esatta -b)^2;


%Equazioni normali
H = transpose(A)*A;
c = transpose(A)*b;
H = my_chol(H);
y= Indietro(H,c);
xchol = Avanti(transpose(H),y);
resnorm=norm(A*xchol-b)^2;
enorm=norm(xchol - esatta);

%Metodo QR
[Q,R]=my_QR(A);
xqr= Indietro(R,transpose(Q)*b);
resqr=norm(A*xqr-b)^2;
eqr=norm(xqr-esatta);

if a1==0 && a2==0
    fprintf("Le matrice calcolate sono ortogonali\n\n");
end
fprintf("Residuo con equazioni normali:\t%f\nResiduo con metodo QR:\t\t%f\nResiduo soluzione esatta:\t%f\n\nErore con equazioni normali:\t%f\nErrore con metodo QR:\t\t%f\n",resnorm,resqr,res,enorm,eqr)


end
