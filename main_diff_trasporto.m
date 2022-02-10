function main_diff_trasporto
% Il programma calcola un'approssimazione tramite le differenze finite
% centrate del problema di diffusione-trasporto
%           -mu u'' +bu'  =f in(a,b)
% usando al bordo condizione di Dirichlet
% Il programma plotta la soluzione esatta e quella approssimata

pulisci
nu=menu("Scegli nu",'1','0.1','0.001');
nu = 10^-(nu-1);
b=1;
N=50;

x=linspace(0,1,N);
dx = x(2) -x(1);
Pe = b * dx/(2*nu);
if Pe>1
    warning("Numero di Peclet maggiore di 1. Si generano soluzuioni oscillati");
end

f = @(x) 0.*x;
Es=@(x) (1-exp(b*x/nu))./(1-exp(b/nu));


cb=[0 1];

[x,u]=diff_trasporto(f,N,x,cb,nu,b);

ES = Es(x);
plot(x,u,'*-');
hold on;
plot(x,ES,'r');
h=x(2) - x(1);
einf=max(abs(ES  -u));
e1=sum(abs(ES-u)*h);
e2 =sum((ES-u).^2*h);
fprintf("Problema diffusione trasporto con %d nodi\n", N);
fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n",einf,e1,e2);

end