function [x,k,it] =GMRES(A,b,x0,m,toll)
% x =GMRES(A,b,x0,m,toll) applica il metodo GMRES
% A matrice del sistema
% b termine noto
% x0 soluzione iniziale
% m massima dimensione sottospazio di Krylov
% toll tolleranza 

r = b- A*x0;
n0 =norm(r);
n =n0;
 
if n==0
    x = x0;
end
V = r /n0;
H =[];
k=0;
it=0;
while k<=m-1 && n/norm(b)>toll
    [k,V,H]= GS_Arnoldi(A,m,k,V,H);
    [r,c]=size(H);
    e1 = zeros(r,1);  e1(1) = 1;
    z = H\e1 * n0;
    x = x0 + V(:,1:c)*z;
    n = norm(b-A*x);
    it=it+1;
end
end


    