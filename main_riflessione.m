function main_riflessione
% Dato il vettore x = (1, 3) del piano cartesiano, si calcolino i vettori
%v = x ? |x|_2 e1 e y = P x (dove P è la matrice di riflessione di
%Householder relativa a). Si disegnino tutti nella stessa finestra grafica [?5, 5] × [?3, 5]
%insieme alla retta ortogonale a v.

x=[1;3]; e1=[1;0];
v=x-norm(x,2)*e1;
nv=norm(v,2);
beta = 2/nv^2;
P = eye(2) - beta*v*(v)';
y=P*x;
figure();
plot([0 x(1)], [0 x(2)]);
hold on
plot([0 y(1)],[ 0 y(2)]);
plot([0 v(1)], [0,v(2)]);
x= -5:1:5;
y=(-v(1) /v(2)) *x;
plot(x,y)
hold off
axis([-5 5 -3 5])
legend('x','y','v','retta ortogonale');
end
