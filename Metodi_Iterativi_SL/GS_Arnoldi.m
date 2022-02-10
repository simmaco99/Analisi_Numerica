function [j,V,H]=GS_Arnoldi(A,m,j,V,H)
% [j,V,H]=GS_Arnoldi(A,m,j,V,H) funzione che ortogonalizza alla
% Ghrahm-Smith per funzione arnoldi
% se c'e un break-down j = m+ 1;
% j numero di vettori gia ortogonalizzati 
% m dimensione massima
% V vettori ortogonalizzati
% H coefficienti 

j=j+1; 
vj=A*V(:,j);
H=[H,V(:,1:j)'*vj]; % viene aggiunta una colonna a H

s = 0 ;
for i = 1:j
    s = s +H(i,j) * V(:,i);
end
w=vj-s; 
H(j+1,j)=norm(w,2);
if (H(j+1,j)>=eps && j<m)
    V=[V,w/H(j+1,j)]; 
else 
    j=m+1;
end

end