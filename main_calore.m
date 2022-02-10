function main_calore

N=50; %numero nodi in spazio
theta =0.5;


[a,b,ua,ub,T,f,nu,u0,s,sol,problem]=Calore_scegli();

h=(b-a)/N;
Dt=h; %Stabile sotto CFL iperbolica dt <= dx^2/2 prendiamola uguale ad 1

N2 =floor(T/Dt);
n = [N N2];
[x,u,time] =theta_metodi(n, [a b],[0 T],u0,f,[ua ub],theta);

plot(x,u,'b*-');
if s ==true
    ES = sol(x,T);
    hold on
    plot(x,ES,'r');
    legend('soluzione calcolata','soluzione esatta');
    einf=max(abs(ES-u));
    e1 = sum(abs(ES-u)*h);
    e2=sum(abs(ES-u).^2*h).^(1/2);
    fprintf("Errore in norma infinito:\t%f\nErore in norma 1:\t\t%f\nErrore in norma 2:\t\t%f \n",einf,e1,e2);
    
    bool=menu("Vuoi calcolare l'ordine di convergenza?",'si','no');
    if bool ==1
        ordine_calore(theta,problem,50);
    end
else
    fprintf("Non conosciamo la soluzione esatta\n");
end
end



