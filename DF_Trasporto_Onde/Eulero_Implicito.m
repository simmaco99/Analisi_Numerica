function sol= Eulero_Implicito(a,lambda,u,t)
N=length(t);
Nx=length(u);
sol=zeros(length(u),N);
c = a*lambda/2;
e = ones(Nx-1,1);
A =diag(e) + c*diag(e(1:end-1),1)- c*diag(e(1:end-1),-1);
A(1,end) = -c;
A(end,1) = c;
[L,U]=lu(A);
sol(:,1) =u;

for i =1:N-1
    y= U\ sol(1:end-1,i);
    sol(1:end-1,i+1) = L\y;
    sol(end,i+1) = sol(1,i+1);
end

end