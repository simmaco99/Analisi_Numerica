function y=odefun(t,x,select)
% handle delle funzioni test in dimensione 1
switch select
    case 1 
        y =-x.*log(x);
    case 2
        y = -exp(-(t+x));
    case 3
        y=x.*(1-x);
    case 4
        y= 16 * x .*(1-x);
    case 5 
        y= -100 * ( x- exp(-t))-exp(-t);
    case 6
        y= -100 * ( x- exp(-t))-exp(-t);        
end
end

