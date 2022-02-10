function [L,gamma,u0,v0,cond,es,select]=Onde_scegli(select)
if nargin==0
    select=menu('Scegli il problema','u0(x)=sin(2pix), v0(x)=0 e condizioni di Dirichlet','u0(x)=cos(x), v0(x)=0 e condizioni periodiche', 'u0(x) =0 e v0(x)=sin(pix)');
end

switch select
    case 1
        L  =1;
        gamma=1;
        u0=@(x) sin(2*pi*x);
        v0=@(x) 0.*x;
        cond ='D';
        es=@(x,t) .5*(u0(x-gamma*t) + u0 (x+gamma*t));
        
    case 2
        L = 2*pi;
        gamma =1;
        u0=@(x) cos(x);
        v0=@(x) 0.*x;
        cond='P';
        es=@(x,t) .5*(u0(x-gamma*t) + u0 (x+gamma*t));
        
    case 3
        L=1;
        gamma=.5;
        u0=@(x) 0.*x;
        v0=@(x) sin(pi*x);
        cond='D';
        es= @(x,t) 2/pi * sin(pi*x) .* sin(pi *0.5 * t) ;
        
end
end
