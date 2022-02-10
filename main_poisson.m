function main_poisson()
% Il programma  approssima il problema di Poisson tramite differenze seconde centrate
% usando condizioni aall bordo Dirichlet e miste.
% Viene inoltre plottata la soluzione esatta e quella approssimata, si calconano inoltre
% le norme (1,2 e infinito) tra la soluzione esatta e quella approssimata
%
% Il programma inoltre stima anche gli ordini di consistenza confrontando
% come variano gli errori (in norma 1) dimezzando il passo
% Si consiglia di non utilizzare la sorgente 1 per il calcolo dell'ordine
% (essendo la soluzione "esatta" lineare si perde l'ordine 2)

pulisci
N=50;
[select,x0,cond,cb]=Poisson_scegli();

[x,u]=Poisson(@(x) Poisson_fun(x,select),N,x0,cond,cb);

ES = Poisson_Esatta(x,select);
plot(x,u,'*');
hold on
plot(x,ES,'r');
legend('calcolata','esatta');
h=x(2) - x(1);
einf=max(abs(ES  -u));
e1=sum(abs(ES-u)*h);
e2 =sum((ES-u).^2*h);

fprintf("Problema di Poisson con %d nodi\n", N);
fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n",einf,e1,e2);

bool=menu("Vuoi calcolare l'ordine di convergenza?",'si','no');
if bool ==1
    ordine_poisson(select,x0,cond,cb,50);
end

end





