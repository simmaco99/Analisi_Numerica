function [u0,a,problem]=rigido_scegli(problem)
if nargin==0
    problem=menu('Scegli la condizione iniziale',"max((1-x^2)^2,0) e a =0.5","1-|x|  e a=3", "-1 se x<=0 e 1 se x>0 e a=1");
end

switch problem
    case 1
        u0 = @(x) max((1-x.^2).^2,0).*(-1<=x) .* (x<=1);
        a=0.5;
    case 2
        u0=@(x) (1 -abs(x)).*(-1<=x) .* (x<=1);
        a=1.5;
    case 3
        u0 =@(x)((x>0) - (x<=0)).*( x>=-1).*(x<=1);
        a= 1;
end