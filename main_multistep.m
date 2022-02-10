function main_multistep
% Il programma risolve un problema di Cauchy usando i metodi di ADAMS
%(espliciti ed impliciti) plottando la soluzione esatta e quella
% approssimata nel medesimo grafico
%
% Il programma inoltre disegna il bordo delle regioni di ASSOLUTA STABILITA
% dei metodi (AM e AB)
%
% Il programma inoltre stima anche gli ordini di consistenza confrontando
% come variano gli errori (in norma infinito) dimezzando il passo

pulisci()
tf = 1;
t0 = 0 ;
h =0.01;
tol=1e-6;
itmax =100;
J = [-21 19 ; 19 21];
dim = menu('Inserisci la dimensione','1','2');

[esplicito,metodo,passo]=Adams_scegli(dim);

if dim ==1
    [y0,select]=Scegli_ODE1();
else
    [y0,select]=Scegli_ODE2();
end

N = floor((tf - t0)/h);

tn = (0 : h:(passo -1)* h);
options =odeset('RelTol',1e-12);
if passo>1
    if dim==1
        [ ~,y]=ode45(@(t,x)odefun(t,x,select),tn,y0,options);
    else
        [~,y]=ode45(@(t,x)ode_fun2_ode(t,x,select),tn,y0,options);
    end
    %per come funzione ode45 se tn ha due elementi prende altri punti
    if passo ==2
        t0v= [ 0; h];
        u0 = [ y(1,:) ; y(end,:)];
    else
        t0v= tn(1:passo)';
        u0 = y(1:passo,:);
    end
else
    t0v=tn;
    u0=y0;
end

if(esplicito==1)
    B = [ 0 1 0 0 0 ;
        0 3/2 -1/2 0 0;
        0 23/12  -16/12 5/12 0 ;
        0 55/24 -59/24 37/24 -9/24];
    A = [ ones(4,1), zeros(4,3)];
    if dim==1
        [t,u]=multistep(metodo,A(metodo,1:metodo), B(metodo,1:metodo+1),tf,t0v,u0,h, @(t,y)odefun(t,y,select),dim) ;
    else
        [t,u]=multistep(metodo,A(metodo,1:metodo), B(metodo,1:metodo+1),tf,t0v,u0,h, @(t,y)ode_fun2(t,y,select),1,1) ;
        
    end
else
    B= [ 1 0 0 0 0;
        1/2 -1/2 0 0 0 ;
        5/12 8/12 -1/12 0 0 ;
        9/24 19/24 -5/24 1/24 0 ;
        251/720 646/720 -264/720 106/720 -19/720];
    A = [ ones(5,1), zeros(5,3)];
    if dim==1
        [t,u]=multistep(metodo-1,A(metodo,1:metodo-1), B(metodo,1:metodo),tf,t0v,u0,h, @(t,y)odefun(t,y,select),@(t,y)odeder(t,y,select),tol,itmax,1);
    else
        [t,u]=multistep(metodo-1,A(metodo,1:metodo-1), B(metodo,1:metodo),tf,t0v,u0,h, @(t,y)ode_fun2(t,y,select),J,tol,itmax,2);
    end
end

if dim==1
    Es= odefun_ES(t,select);
else
    Es = odefun_ES2(t,select,y0(1),y0(2));
end
err =abs(u - Es);
fprintf("Modulo dell'errore al tempo finale: "); disp(err(end));
fprintf("\n Massimo errore in modulo"); disp(max(err));

if dim==1
    subplot(1,2,1);
    plot(t,u,'*');
    hold on
    plot(t,Es,'r')
    title('Confronto tra soluzione esatta e calcolata')
    legend('calcolata','esatta');
    subplot(1,2,2);
    plot(t,err);
    title("Modulo dell'errore");
else
    subplot(3,2,1)
    plot(t,u(:,1),'*');
    hold on
    plot(t,Es(:,1),'r');
    title('Confronto soluzioni (1 componente)')
    legend('calcolata','esatta')
    subplot(3,2,2);
    plot(t,u(:,2),'*');
    hold on
    plot(t,Es(:,2),'r');
    title('Confronto soluzioni (2 componente)')
    legend('calcolata','esatta')
    subplot(3,2,3)
    plot(t,err(:,1))
    title('Modulo errore (1 componente)');
    subplot(3,2,4)
    plot(t,err(:,2))
    title('Modulo errore (2 componente)');
    subplot(3,2,[5 6 ])
    plot(u(:,1),u(:,2),'*')
    hold on
    plot(Es(:,1),Es(:,2),'r')
    legend('calcolata','esatta')
    title('Piano delle fasi')
    
end
bool =menu("Vuoi il grafico delle regioni di assolutà stabilità?","Si","No");
if bool ==1
    main_regioni
end

bool=menu("Vuoi calcolare l'ordine del metodo",'Si','No');
if bool==1
    ordine_multistep(metodo,passo,select,dim,tol,itmax,A,B,0.01);
end
end
%se proviamo per il penultimo (.01 e il bordo per AB2)
