function sol=Leap_Frog(cond,gamma,lamda,dt,u,v,T)
Nt=length(T);
Nx = length(u);
sol=zeros(Nx,Nt);
sol(:,1)= u;
sol(:,2) = u + dt * v;
coeff= (lamda*gamma).^2;


switch cond
    case 'P'
        for n=2:Nt-1
            sol(1,n+1) = 2* sol(1,n)-sol(1,n-1) + coeff*(sol(2,n)-2*sol(1,n) + sol(end-1,n));
            sol(2:end-1,n+1) = 2* sol(2:end-1,n) - sol(2:end-1,n-1)+ coeff*(sol(3:end,n) -2*sol(2:end-1,n) + sol( 1:end-2,n));
            sol(end,n+1) = 2*sol(end,n) -sol(end,n-1)+ coeff*(sol(2,n) - 2*sol(end,n)  +sol(end-1,n));
        end
    case 'D'
        for n=2:Nt-1
            sol(2:end-1,n+1) = 2* sol(2:end-1,n) - sol(2:end-1,n-1)+ coeff* (sol(3:end,n)- 2*sol(2:end-1,n) + sol( 1:end-2,n));
            
        end
end
