function y=ode_fun2(t,x,select)
% handle delle funzioni test in dimensione 2 (servono per multistep)
% f = [f1 f2]
y=zeros(size(x));
switch select
    case 1
        y(:,1) = x(:,2);
        y(:,2) = -x(:,1);
    case 2
        y(:,1) = -21 * x(:,1) + 19 * x(:,2);
        y(:,2) = 19 * x(:,1) - 21 * x(:,2);
    case 3
        y(:,1) = x(:,2);
        y(:,2) = -sin(x(:,1));
    case 4
        alpha=.25; beta  =.01;gamma=1; delta=.01;
        prod=x(:,1).*x(:,2);
        y(:,1)= alpha*x(:,1) -beta *prod;
        y(:,2)=-gamma*x(:,2) +delta *prod;
end
end
