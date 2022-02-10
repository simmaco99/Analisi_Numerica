function ordine_leap(cond,L,gamma,u0,v0,es,dx0)
m=5;
err =zeros(m,1);
h=zeros(m+1,1);
Tf=1;
h(1)= dx0;
for i = 1:m
    dx = h(i);
    dt=dx/(2*gamma);
    x= (0:dx:L)';
    T =(0:dt:Tf)';
    lambda=dt/dx;
    sol=Leap_Frog(cond,gamma,lambda,dx,u0(x),v0 (x),T);
    Es =es(x,Tf );
    err(i) = max(abs(Es-sol(:,end)));
    h(i+1) = dx/2;
end
a=min(err);
terza = log2(err(1:end-1)./err(2:end));
terza = [ 0 ; terza];
fprintf("Passo\t\tErrore\t\tOrdine\n")
disp([h(1:end-1) err/a terza])
fprintf("La seconda colonna è stata moltiplicata per"); disp(a);
fprintf("Ordine calcolato: %f\n", max(terza));
end
