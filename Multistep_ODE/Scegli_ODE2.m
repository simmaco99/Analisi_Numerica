function [y0,select]=Scegli_ODE2(select)
if nargin==0
    select = menu("Scegli un problema di Cauchy", "oscillatore armonico","Nodo stabile","Pendolo","Lotka-Voltera");
end

switch select
    case 1
        y01=input("Inserisci la prima condizione iniziale: ");
        y02=input("Inserisci la seconda condizione iniziale: ");
        
    case 2
        y01= 10;
        y02= 20;
    case 3
        y01=input("Inserisci la prima condizione iniziale: ");
        y02=input("Inserisci la seconda condizione iniziale: ");
    case 4
        y01=80;
        y02=30;
end
y0=[y01 y02];
end