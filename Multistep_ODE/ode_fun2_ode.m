function y=ode_fun2_ode(t,x,select)
% handle delle funzioni test in dimensione 1 (servono per ode45)
% prima componente posizione
% seconda componete velocita
% f = [ f1; f2]

y=zeros(2,1);
switch select
    case 1
        y(1) = x(2);
        y(2) = -x(1);
    case 2
        A = [ -21 19 ; 19 , -21];
        y = A*x;
    case 3
        y(1) = x(2) ;
        y(2) = -sin(x(1));
    case 4
        alpha=.25; beta  =.01;gamma=1; delta=.01;
        y(1)= alpha*x(1) -beta *x(1)*x(2);
        y(2)=-gamma*x(2) +delta *x(1) *x(2);
end

end


