function sol= Eulero_Esplicito(a,lambda,u,T)
% t vettore dei timespam
% u vettore colonna con u =u0(x_j) j=1:end-1;
% si usano condizioni periodiche sol(1,i) = sol(end,i);
sol=zeros(length(u),length(T));
sol(:,1) = u;
for i=2:length(T)
    sol(2:end-1,i) = sol(2:end-1,i-1) + a*lambda/2 * (sol(1:end-2,i-1) - sol(3:end,i-1));
    sol(1,i) = sol(1,i-1) + a* lambda/2 * (sol(end-1,i-1) - sol(2,i-1));
    sol(end,i) = sol(1,i);
end
end

% u_j = u_j + ah/2 ( u_(j-1) - u_j)
% u_0 = u_0 + ah/2 ( u_-1 - u_0)
% j=0 -> posizione 1
% u_-1 = U