function [a,b,ua,ub,T,f,nu,u0,s,sol,problem]=Calore_scegli(problem)

if nargin==0
    problem =menu('Scegli il problema', 'f=0, u0=sin(pi x) in (0,1)x(0,1)','f=0, u0=I[-1,1] in (-3,3)x(0,1)');
end

switch  problem
    case 1
        a=0; b=1; ua=0; ub=0; T=1;
        f=@(x,t) (0.*x); nu=1;
        u0=@(x) sin(pi*x);
        s=true;
        sol=@(x,t) exp(-pi^2*t).* sin(pi*x);
        
    case 2
        a = -3; b =3; ua=0; ub=0; T=1;
        f=@(x,t) (0.*x); nu=1;
        u0=@(x) (-1<=x).*(x<=1);
        s=false;
        sol=0;
end
end

