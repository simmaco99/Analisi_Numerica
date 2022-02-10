function [y0,select]=Scegli_ODE1(select)
if nargin==0
    select = menu("Scegli un problema di Cauchy","dy/dt=-ylny  y(0) = 0.5", "dy/dt=-exp(-(t+y))   y(0)=1","dy/dt=y(1-y)   y(0)=1", "dy/dt=16y(1-y)    y(0) =0.5","dy/dt=-100(y-exp(-t))-exp(-t)   y(0)=1");
end

switch select
    case 1
        y0=.5;
    case 2
        y0=1;
    case 3
        y0 =.5;
    case 4
        y0=1/1024;
    case 5
        y0=1;
    case 6
        y0=0;
end
end
