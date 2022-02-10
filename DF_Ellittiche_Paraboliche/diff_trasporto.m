function [x,u]=diff_trasporto(f,N,x,cb,mu,b)
x= linspace(x(1),x(end),N)';
dx = x(2) - x(1);
dx2 = dx^2;
u=zeros(N,1);

e = ones(N-2,1);
giu=- mu + b*dx*.5;
su = -mu- b*dx*.5;

A =2*mu* diag(e) + giu *  diag(e(1:end-1),1) +su* diag(e(1:end-1),-1);
F = f(x(2:end-1))*dx2;
F(1) = F(1) -cb(1)*giu;
F(end) = F(end) -cb(2) *su;
u(2:end-1) = A\F;
u(1) = cb(1);
u(end) = cb(2);
end

