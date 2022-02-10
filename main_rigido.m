function main_rigido()
%Il programma approssima il problema del trasporto rigido con condizioni al
%bordo periodiche tramite i seguenti metodi alle differenze finite (tra
%parentesi gli ordini di consistenza:
%   Eulero Esplicito O(dt+dx)
%   Eulero Implicito  O(dt+dx)
%   Upwind O(dt + dx)
%   Lax-Friedrich O(dt+dx^2 + dx^2/dt)
%   Lax-Wendroff  O(dt^2 + dx^2)
%
% Il programma mostra il grafico delle soluzione esatta e di quella
% approssima allo scorrere del tempo
%
% Il programma inoltre stima anche gli ordini di consistenza confrontando
% come variano gli errori (in norma 1) dimezzando il passo
%
% Notiamo come non usando la CFL massima:
% UPWIND        riduce l'ampiezze dell'onda     (effetto DISSIPATIVO)
% LAW-WENDROFF  distorce l'ampiezza dell'onda   (effetto DISPERSIVO)

pulisci;
stampa = 1; %se vale 1 viene mostrato il grafico animato della soluzione esatta e approssimata
x0=-4; xf = 4;
Tf=1;

[u0,a]=rigido_scegli(); %scelta del problema

metodo =menu('Scegli il metodo',"Eulero avanti","Eulero indietro","Up-wind","LaxFriedrich","Lax-Wendroff");
dx= input('Inserire passo spaziale: ');

bool=menu("Vuoi lavorare alla massima stabilitá",'si','no'); %se si  numero di Courant = 1
if bool ==1
    if metodo==1
        dt=(dx/2)^2;
    else
        dt =dx/abs(a);
    end
else
    dt= input('Inserire passo temporale: ');
    if metodo==1 && dt> (dx/2)^2
        dt = (dx/2)^2;
        error("Non è verificata la condizione di stabilità. Si consiglia di scegliere dt=%f",dt);
    end
    CFL = abs(a)* dt>dx;
    if metodo>2 && CFL
        dt = dx/abs(a);
        error("Per avere numero di Courant pari ad 1: dt=%f\n",dt);
    end
end

if stampa==1
    
    x= (x0:dx:xf)';
    T=(0:dt:Tf)';
    
    Ex = zeros(length(x),length(T));
    for i = 1 :length(T)
        Ex(:,i) = u0(x-a*T(i));
    end
    
    m= min(min(Ex))-.5;
    M = max(max(Ex))+.5;
    passo = floor(0.01/dt);
    if passo ==0
        passo =1;
    end
    lamda = dt/dx;
    switch metodo
        case 1 ; sol=Eulero_Esplicito(a,lamda,u0(x),T);
        case 2 ; sol=Eulero_Implicito(a,lamda,u0(x),T);
        case 3 ; sol=UpWind(a,lamda,u0(x),T);
        case 4 ; sol= Lax_Friedrich(a,lamda,u0(x),T);
        case 5 ; sol = Lax_Wendroff(a,lamda,u0(x),T);
    end
    for i = 1:passo:length(T)
        subplot(2,1,1);
        plot(x,sol(:,i),'b')
        title('soluzione approssimata');
        axis([x0 xf m M]);
        subplot(2,1,2);
        plot(x,Ex(:,i),'r');
        title('soluzione esatta');
        axis([ x0 xf m M]);
        pause(0.01);
    end
    figure()
    plot(x,sol(:,1),'g');
    hold on
    plot(x,sol(:,end),'b');
    plot(x,Ex(:,end),'r');
    legend('Dato iniziale','Soluzione  finale calcolata','Soluzione finale esatta');
    
    absdiff = abs(sol(:,end)  - Ex(:,end));
    einf= max(absdiff);
    e1 = sum(absdiff*dx);
    e2 = sum(absdiff.^2*dx)^(1/2);
    fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n",einf,e1,e2);
end
bool=menu("Vuoi calcolare l'ordine di convergenza?",'si','no');
if bool ==1
    ordine_rigido(metodo, u0, a,x0,xf,Tf,0.1);
end



