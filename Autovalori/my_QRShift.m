function [A,it,err] = my_QRShift(A,ITMAX,toll,esatto,bool)
% A = my_QR(A,ITMAX) esgue ITMAX iterazioni del metodo QR
n = size(A,1);
it=0;
err =zeros(ITMAX,1);
esatto =sort(esatto);
while it<=ITMAX &&  abs(A(end,end-1)) >= toll * ( abs(A(end-1,end-1)) + abs(A(end,end)))
    it = it+1;
    mu = A(end,end);
    [ Q,R ] = my_QR(A-mu*eye(n));
    
    A = R * Q + mu*eye(n);
    if bool==1
        approx = diag(A);
    else
        approx = Auto_QuasiTriangolare(A,toll);
    end
    err(it)= max(abs(esatto- sort(approx)));
    
end
if it == ITMAX + 1
    warning("Raggiunto il numero massimo d'iterazioni");
end
end