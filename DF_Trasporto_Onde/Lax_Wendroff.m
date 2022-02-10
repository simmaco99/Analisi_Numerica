function sol = Lax_Wendroff(a,lambda,u,T)
N = length(T);
sol = zeros(length(u),N); %inizializzo usol ponendo l'intervallo temporale orizzontale e quello spaziale verticale
sol(:,1) = u; %valuto nei nodi considerati il dato iniziale

c1 = a*lambda/2;
c2 = (a*lambda)^2/2;

for i = 1:N-1
    fantasma = sol(end-1,i);
    sol(2:end-1,i+1) = sol(2:end-1,i)-c1*(sol(3:end,i)-sol(1:end-2,i))+c2*(sol(3:end,i)-2*sol(2:end-1,i)+sol(1:end-2,i));
    sol(1,i+1) = sol(1,i)-c1*(sol(2,i)-fantasma)+(c2)*(sol(2,i)-2*sol(1,i)+fantasma);
    sol(end,i+1) = sol(1,i+1);
end
end