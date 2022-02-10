function [N,err,terza]=ordine_calore(theta,problem,N0)

[a,b,ua,ub,T,f,~,u0,~,sol]=Calore_scegli(problem);
bc =[ ua ub ] ;
m=3;
err = zeros(m,1);
N= zeros(m+1,1);
N(1) = N0;
for i =1:m
    n = N(i);
    h=(b-a)/n;
    Dt=h^2/2;
    N2 =floor(T/Dt);
    [x,u] =theta_metodi([n N2], [a b],[0 T],u0,f,bc,theta);
    ES = sol(x,T);
    err(i) = max(abs(ES-u));
    N(i+1) = 2*N(i) ;
end

N =N(1:end-1);

terza= log2(err(1:end-1)./err(2:end));
terza = [ 0 ; terza]; %contiene log(e2h/eh)

a = min(err);
disp([ N err/a terza]);
fprintf("La seconda colonna è stata moltiplicata per")
disp(a)