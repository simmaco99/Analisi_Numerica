function y=odefun_ES(t,select)
% handle delle soluzioni esatte
switch select
    case 1
        y= exp(log(0.5)*exp(-t));
    case 2
        y = log(exp(1) +exp(-t)-1);
    case 3
        y= exp(t)./(1+exp(t));
    case 4
        y= exp(16*t -log(1023))./(1 + exp(16*t-log(1023)));
    case 5
        y=exp(-t);
    case 6
        y= exp(-t) -exp(-100*t);
end
end

