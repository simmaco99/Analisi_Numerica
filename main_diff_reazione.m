function main_diff_reazione()
% Il programma calcola un'approssimazione tramite le differenze finite
% centrate del problema di diffusione-reazione
%           -mu u'' +sigma u  =f in(a,b)
% usando al bordo condizione di Dirichlet
% Il programma plotta la soluzione esatta e quella approssimata
%
% Il programma genera un errore se il numero di Peclet b* dx/(2 mu) >1 per
% evitare soluzioni oscillanti
%
% É utile osservare le due diverse configurazioni che si ottengono
% b >> mu -> trasporto dominato (presente lo strato limite)
% b << mu -> diffusione dominata

pulisci;

sigma =menu('Scegli il valore di sigma','1','10','100','1000');
sigma = 10^-(sigma-1);
mu=.1;
N=100;

alpha = sqrt(sigma/mu);
den = exp(alpha)- exp(-alpha);
f = @(x) 0.*x;
Es=@(x) (exp(alpha*x)-exp(-alpha*x))./den;
x=[0 1 ];

cond =menu("Condizioni al bordo", "Dirichlet: u(0) =0 e u(1) =1","Neumannn: u'(0) = 2a/(exp(a) -exp(-a)) e u'(1) =(exp(a) + exp(-a))/(exp(a)-exp(-a)) dove a = sqrt(sigma)/mu");
if cond==1
    cond ='D';
    cb=[ 0 1];
else
    cond ='N';
    cb = [ 2*alpha/(exp(alpha)-exp(-alpha)) ; (exp(alpha)+exp(-alpha))/(exp(alpha)-exp(-alpha))];
end

[u,x]=diff_reazione(f ,N,x,cond,cb,mu,sigma);
ES = Es(x);
plot(x,u,'*');
hold on;
plot(x,ES,'r');

h=x(2) - x(1);
einf=max(abs(ES  -u));
e1=sum(abs(ES-u)*h);
e2 =sum((ES-u).^2*h);
fprintf("Problema diffusione reazione con %d nodi\n", N);
fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n",einf,e1,e2);
end