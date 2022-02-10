function [N,err,terza]=ordine_poisson(select,x0,cond,cb,N0)
m=5;
N=zeros(m+1,1); %contiene i passi
N(1) = N0;
err = zeros(m,1);
for i =1:m
    n = N(i);
    [x,u]=Poisson(@(x) Poisson_fun(x,select),n,x0,cond,cb);
    Es = Poisson_Esatta(x,select);
    err(i) = max(abs(Es-u));
    N(i+1) = 2*N(i) ;
end

N =N(1:end-1);

terza= log2(err(1:end-1)./err(2:end));
terza = [ 0 ; terza]; %contiene log(e2h/eh)

a = min(err);
fprintf("Passo\tErrore\tOrdine\n")
disp([ N err/a terza]);
fprintf("La seconda colonna è stata moltiplicata per")
disp(a)
end