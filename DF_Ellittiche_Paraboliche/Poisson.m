function [x,u]=Poisson(f,N,x,cond,cb)
% f     funzione sorgente
% N     numero di nodi
% x     vettore posizione iniziale e finale
% cond  puo asumere i valori
%                           D :Dirichlet)
%                           Mi:Miste con derivata al bordo iniziale
% cb     valori al bordo
if length(x)~=2
    error("x: non conforme");
end
if length(cb)~=2
    error("u: non conforme");
end

x = linspace(x(1),x(2),N)';

dx =x(2) -x(1);
dx2=dx*dx;
switch cond
    case 'D'
        u = zeros(N,1);
        u([1 N]) =cb;
        e = ones(N-2,1);
        A = spdiags([-e 2*e -e], -1:1, N-2, N-2);
        F = dx2*f(x(2:end-1));
        F(1) = F(1) + u(1);
        F(end) = F(end) + u(end);
        u(2:end-1)=A\F;
        
    case 'Mi'
        u = zeros(N,1);
        u(end) = cb(2);
        e=ones(N-1,1);
        A = spdiags([-e 2*e -e], -1:1, N-1, N-1);
        A(1,1)= 1;
        %         F=[-cb(1)*dx; f(x(2:end-1))*dx2];%
        F = [-cb(1)*dx + 0.5*dx2*f(x(1));f(x(2:end-1))*dx2];
        F(end) = F(end) + cb(2);
        u(1:end-1)=A\F;
    case 'Mf'
        u = zeros(N,1);
        u(1) = cb(1);
        e =ones(N-1,1);
        A = spdiags([-e 2*e -e], -1:1,N-1,N-1);
        A(end,end) = 1;
        %        F = [ f(x(2:end-1))*dx2; cb(2)*dx];
        F=[f(x(2:end-1))*dx2;cb(2)*dx + .5*dx2* f(x(end))];
        F(1)  = F(1) + cb(1);
        u(2:end)=A\F;
    otherwise
        error("cond: non conformi");
end

end




