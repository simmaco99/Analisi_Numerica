function [h,Err,terza]= ordine_rigido(metodo, u0, a,x0,xf,Tf,h0)
m=5;
h=zeros(m+1,1);
h(1) =h0;
Err=zeros(m,1);

for i = 1: m
    dx=h(i) ;
    if metodo~=1
        dt = dx/(3*abs(a));
    else
        dt = .5*(dx/a)^2;
    end
    lamda=dt/dx;
    x= (x0:dx:xf)';
    T=(0:dt:Tf)';
    switch metodo
        case 1 ; sol=Eulero_Esplicito(a,lamda,u0(x),T);
        case 2 ; sol=Eulero_Implicito(a,lamda,u0(x),T);
        case 3 ; sol=UpWind(a,lamda,u0(x),T);
        case 4 ; sol= Lax_Friedrich(a,lamda,u0(x),T);
        case 5 ;sol = Lax_Wendroff(a,lamda,u0(x),T);
    end
    Ex = u0(x-a*Tf);
    Err(i) = (sum(abs(sol(:,end) -Ex)*dx));
    h(i+1) = dx/2;
end

terza = log2(Err(1:end-1)./Err(2:end));
terza = [ 0 ; terza];
a=min(Err);
fprintf("Passo\tErrore\tOrdine\n")
disp([h(1:end-1) Err/a terza])
fprintf("La seconda colonna è stata divisa per "); disp(a)
end



