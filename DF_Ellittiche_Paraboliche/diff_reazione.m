function [u,x]= diff_reazione(f,N,x,cond,cb,mu,sigma)
x= linspace(x(1),x(2),N)';
dx = x(2)-x(1);
dx2 = dx^2;
u = zeros(N,1);
switch cond
    case 'D'
        A=(2*mu+ sigma*dx2)* eye(N-2) - mu* diag(ones(N-3,1),1) - mu * diag(ones(N-3,1),-1);
        F= f(x(2:end-1))* dx2;
        F(1) =F(1) + mu*cb(1);
        F(end) = F(end) + mu * cb(end);
        u(2:end-1) = A\F;
        u(1) = cb(1);
        u(end) = cb(2);
    case 'Mi'
        A=(2*mu+ sigma*dx2)* eye(N-1) - mu* diag(ones(N-2,1),1) - mu * diag(ones(N-2,1),-1);
        A(1,1)= 1;
        A(1,2)= -1;
        F=[-cb(1)*dx; f(x(2:end-1))*dx2];
        F(end) = F(end) + cb(2);
        
        u(1:end-1)=A\F;
        u(end) = cb(2);
    case 'Mf'
        A=(2*mu+ sigma*dx2)* eye(N-1) - mu* diag(ones(N-2,1),1) - mu * diag(ones(N-2,1),-1);
        A(end,end) = 1;
        A(end,end-1)=-1;
        F =[ f(x(3:end-1))*dx2 ; cb(2)*dx];
        u(2:end)=A\F;
        u(1) = cb(1);
    case 'N'
        A=(2*mu+sigma*dx2)*eye(N) - mu * diag(ones(N-1,1),1) - mu * diag(ones(N-1,1),-1);
        A(1,1)=1;
        A(1,2) = -1;
        A(end,end-1) =-1;
        A(end,end) = 1;
        F= [-cb(1) * dx; f(x(2:end-1))*dx2; cb(2) *dx];
        u=A\F;
        
end
end