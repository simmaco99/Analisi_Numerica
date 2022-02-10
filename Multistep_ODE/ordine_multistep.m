function [h,err,terza]=ordine_multistep(metodo,passo,select,dim,tol,itmax,A,B,h0)

options =odeset('RelTol',1e-12);
tf = 1;

if metodo == passo
    esplicito=1;
    m=5;
else
    esplicito=2
    m=5;
end
% t0 = 0 ;
if dim==1
    y0=Scegli_ODE1(select);
else
    y0=Scegli_ODE2(select);
    
end
err = zeros(m,1);
hh=zeros(m+1,1); %contiene i passi
hh(1) = h0;

for i = 1:m
    h=hh(i);
    tn = (0 : h:(passo -1)* h);
    if passo>1
        [ ~,y1]=ode45(@(t,x)odefun(t,x,select),tn,y0,options);
        %per come funzione ode45 se tn ha due elementi prende altri punti
        if passo ==2
            t0v1= [ 0; h];
            u01 = [ y1(1) ; y1(end)];
        else
            t0v1= tn(1:passo)';
            u01 = y1(1:passo);
        end
    else
        t0v1=tn;
        u01=y0;
    end
    if esplicito==1
        [t,u]=multistep(metodo,A(metodo,1:metodo), B(metodo,1:metodo+1),tf,t0v1,u01,h, @(t,y)odefun(t,y,select),dim) ;
    else
        [t1,u1]=multistep(metodo-1,A(metodo,1:metodo-1), B(metodo,1:metodo),tf,t0v1,u01,h, @(t,y)odefun(t,y,select),@(t,y)odeder(t,y,select),tol,itmax,1);
        
    end
    Es= odefun_ES(t1,select);
    err(i) =max(abs(u1-Es));
    hh(i+1) = h/2;
end
h=hh(1:m);
a=min(err);
terza= log2(err(1:end-1)./err(2:end));
terza = [ 0 ; terza]; %contiene log(e2h/eh)
fprintf("Passo\tErrore\tOrdine\n");
disp([ h, err/a, terza]) %tabella richiesta
fprintf("La seconda colonna è stata divisa per ") ; disp(a);
max(terza)
end

