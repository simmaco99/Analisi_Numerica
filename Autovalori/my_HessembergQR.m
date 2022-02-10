function [A,it,err]=my_HessembergQR(A,ITMAX,toll,esatta,bool)
% A=my_HessembergQR(A,ITMAX) esegue ITMAX iterazione del metodo QR dove
% aver trasformato A in forma di Hessemberg superiore
[~,A] = my_Hessemberg(A);
esatta = sort(esatta);
err= zeros(ITMAX,1);
err(1) =1;
it=1;
% cond= abs(A(end,end-1))/abs( A(end-1,end-1) + A(end,end));
while it<=ITMAX && err(it)>toll
%     &&  cond>toll
    it =it +1;
    [Q,R]=QR_Hessemberg(A);
    A  = R * Q;
    if bool==1
        approx= diag(A);
    else
        approx =Auto_QuasiTriangolare(A,toll);
    end
    err(it) = max(abs(esatta-sort(approx)));
%     cond= abs(A(end,end-1))/abs( A(end-1,end-1) + A(end,end));
end
err=err(2:it);
it =it-1;
if it==ITMAX + 1
    warning("Raggiunto il numero massimo d'iterazioni");
end
end

function [Q,R]=QR_Hessemberg(A)
% calcola la fattorizzazione QR per una matrice in forma di Hessemberg
n = size(A,1);
Q = eye(n);
for k = 1:n-1
    % annullare l'elemento A(k+1,k) usando A(k,k)
    [s,c] = Sin_Cos_Given(A(k,k),A(k+1,k));
    A= Prod_Given(A,k+1,k,c,s);
    Q = Prod_Given(Q,k+1,k,c,s);
end
R = A ;
Q = Q';
end

function M = Prod_Given(M,i,k,c,s)
 % calcola il prodotto G(i,k,theta)* M dove s =sin(theta) e c
 % =cos(theta)
v1= c *M(i,:) + s * M(k,:);
v2 = -s * M(i,:) + c * M(k,:);
M(i,:) = v1;
M(k,:)= v2;
end



function [s,c]=Sin_Cos_Given(x,y) 
% calcola i seni e coseni nella matrice di Givens per annullare y
    den = sqrt(x^2 + y^2);
    s = -y/den; 
    c  = x/den;
end
