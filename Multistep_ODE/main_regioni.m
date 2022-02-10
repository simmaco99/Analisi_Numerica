theta = linspace(0,2*pi,100000);

zeta =exp(1i*theta);
B = [ 0 1 0 0 0 ;
    0 3/2 -1/2 0 0;
    0 23/12  -16/12 5/12 0 ;
    0 55/24 -59/24 37/24 -9/24];
A = [ ones(4,1), zeros(4,3)];

for k=1:4
    rho= @(r) r.^(k+1) - r.^k;
    sigma=@(r) B(k,1:k+1) * r.^(k - ( -1:1:k-1)');
    z = rho(zeta)./sigma(zeta);
    subplot(2,2,k)
    plot(z)
    axis equal
    s= sprintf("AB%d",k);
    title(s);
end

figure()

BE=[ 1/2 -1/2 0 0 0 ;
    5/12 8/12 -1/12 0 0 ;
    9/24 19/24 -5/24 1/24 0 ;
    251/720 646/720 -264/720 106/720 -19/720];
for k =2:4
    rho= @(r) r.^(k+1) - r.^k;
    sigma=@(r) BE(k,1:k+1) * r.^(k - ( -1:1:k-1)');
    z = rho(zeta)./sigma(zeta);
    subplot(2,2,k)
    plot(z)
    axis equal
    s= sprintf("AM%d",k);
    title(s);
    
end

