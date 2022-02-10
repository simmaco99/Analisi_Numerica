function main_onde
% Il programma  approssima il problema del calore
%    u_tt ?gamma 2u_xx =0 in(0,L)×(0,T)
% dove u(x,0)=u0(x),ut(x,0)=v0(x)in(0,L)
% con condizioni al bordo periodiche e Dirichlet tramite Leap-Frog
% Confrontare le soluzioni ottenute con quella esatta fornita dalla formula di d?Alembert.
%
% Il programma inoltre stima anche gli ordini di consistenza confrontando
% come variano gli errori (in norma infinito) dimezzando il passo

pulisci()

T=1;
animato=1; % se uguale ad 1 non fa vedere le animazioni
dx= 0.01;

[L,gamma,u0,v0,cond,es]=Onde_scegli();

dt=dx/gamma; %Esatto
% dt = dx/(2*gamma);  %Non esatto
x= (0:dx:L)';
T =(0:dt:T)';
lambda=dt/dx;
sol=Leap_Frog(cond,gamma,lambda,dt,u0(x),v0 (x),T);
Es =zeros(length(x),length(T));

for i = 1:length(T)
    Es(:,i) =es(x,T(i) );
end
if animato==1
    
    m =min(min(Es))-0.5;
    M =max(max(Es))+.5;
    for i = 1:length(T)
        subplot(2,1,1);
        plot(x,sol(:,i));
        title("Soluzione approssimata");
        axis([0 1 m M]);
        subplot(2,1,2);
        plot(x,Es(:,i));
        title("Soluzione esatta");
        axis([0 1 m M]);
        pause(.01)
    end
end

einf= max(abs(sol(:,end) - Es(:,end)));
e2= sum(abs(sol(:,end)-Es(:,end)).^2 *dx);
e1 = sum(abs(sol(:,end)-Es(:,end))*dx);
fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n\n",einf,e1,e2);

bool=menu("Vuoi calcolare l'ordine di convergenza?",'si','no');
if bool ==1
    ordine_leap(cond,L,gamma,u0,v0,es,.1)
end

end