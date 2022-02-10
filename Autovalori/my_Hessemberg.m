function  [Q,H] = my_Hessemberg(A) 
% [Q,T] = my_Hessemerg(x,m) calcola T = Q' A Q dove T in forma di Hessemberg
% da migliorare la moltiplicazione
[n,m]=size(A);
if n~=m 
    error('Matrice non quadrata')
end
Q = eye(n); H=A;
for k = 1:n-2
    v =zeros(n,1);
    v(k+1:end) = my_Householder(H(k+1:end,k),1);
    P = eye(n) - 2*v*(v)';
    H = P * H * P';
    H(k+2:end,k) =0;
    Q = P * Q;
end
end


