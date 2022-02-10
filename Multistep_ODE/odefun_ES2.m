function y=odefun_ES2(t,select,x0,y0)
% handle delle soluzioni esatte
switch select
    case 1
        y = [x0* cos(t)+y0* sin(t), -x0*sin(t) + y0 *cos(t)];
    case 2
        a1 = exp(-2*t)/2; a2= exp(-40*t)/2;c=a1+a2;d= a1-a2;
        y= [x0*c + y0*d,x0*d + y0*c];
    case 3
        warning("Soluzione esatta non disponibile");
    case 4
        warning("Soluzione esatta non disponibile");
end
end

