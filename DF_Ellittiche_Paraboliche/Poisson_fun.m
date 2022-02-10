function y=Poisson_fun(x,select)
switch select
    case 1
        y = 0.* x;
    case 2
        y=exp(x);
    case 3
        y=sin(x);
    case 4
        y =3*x+2;
    case 5
        y=2*exp(x).*sin(x);
end
end
