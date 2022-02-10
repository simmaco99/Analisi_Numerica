function y=odeder(t,x,select)
% handle derivate delle funzioni test dimensione 1
% servono per poter applicare Newton
switch select
    case 1
        y =-log(x) - 1;
    case 2
        y = exp(-(t+x));
    case 3
        y=1-2*x;
    case 4
        y= 16 -32*x;
    case 5
        y= -100 ;
    case 6
        y= -100 ;
end
end

