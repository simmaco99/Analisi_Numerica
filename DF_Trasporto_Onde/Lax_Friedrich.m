function sol= Lax_Friedrich(a,lambda,u,t)
N=length(t);
sol=zeros(length(u),N);

sol(:,1) =u;
for i =1:N-1
    fantasma = sol(end-1,i);
    sol(2:end-1,i+1) = ( sol(3:end,i) + sol(1:end-2,i))/2 - a*lambda/2 * (sol(3:end,i) - sol(1:end-2,i));
    sol(1,i+1) = (sol(2,i) + fantasma)/2 - a*lambda/2 *(sol(2,i) -fantasma);
    sol(end,i+1)= sol(1,i+1);
    
end
