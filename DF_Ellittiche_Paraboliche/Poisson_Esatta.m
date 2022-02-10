function y=Poisson_Esatta(x,select)
y=zeros(size(x));
switch select
    case 1
        y=x;
    case 2
        y = 1 - exp(x) - (1 - exp(1))*x;
    case 3
        y=sin(x);
    case 4
        y= -x.^3/2-x.^2+5*x/2;
    case 5
        y=exp(x).* cos(x);
end
end