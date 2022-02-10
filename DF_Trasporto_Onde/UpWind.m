function sol= UpWind(a,lambda,u,t)
N=length(t);
sol=zeros(length(u),N);

sol(:,1) =u;
if a>0
    for i =1:N-1
        fantasma = sol(end-1,i);
        sol(2:end-1,i+1) = sol(2:end-1,i) - a*lambda*(sol(2:end-1,i) - sol(1:end-2,i));
        sol(1,i+1) = sol(1,i) -a*lambda*(sol(1,i) -fantasma);
        sol(end,i+1)= sol(1,i+1);
    end
else
    for i =1:N-1
        fantasma = sol(end-1,i);
        sol(1:end-1,i+1) = sol(1:end-1,i) - a*lambda*(sol(2:end,i) - sol(1:end-1,i));
        sol(end,i+1)= sol(1,i+1);
    end
end
