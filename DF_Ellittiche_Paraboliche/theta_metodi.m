function [x,u,time]= theta_metodi(N,I,T,u0,f,bc,theta)
% N vettore di dimensione 2 numero di passi spazio-tempo
% I intervallo spaziale
% T intervallo temporale
% cb soluzioni al bordo

h= (I(2) - I(1))/N(1);
x = (I(1) : h : I(2))';
dx = x(2) - x(1);
dt =(T(2)-T(1))/N(2);

e=ones(N(1)-1,1);
A = -2*diag(e) + diag(e(1:end-1),1) + diag(e(1:end-1),-1);
A=A/(dx^2);
K = eye(N(1)-1)-theta*dt*A;
B=eye(N(1)-1) + (1-theta)*dt*A;
[L,U]=lu(K);


uold=u0(x(2:end-1)); fold= f(x(2:end-1),T(1));
time = T(1)+ dt:dt:T(2);
for i = 1:length(time)
    fnew=f(x(2:end-1),time(i));
    b = dt*theta*fnew + dt*(1-theta)*fold + B*uold;
    y= L\b;
    u = U\y;
    uold =u ;
    fold=fnew;
    u=[bc(1);uold;bc(2)];
end

