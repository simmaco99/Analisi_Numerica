function [A,it,err] = my_QRBase(A,ITMAX,toll,esatto,bool)
% A = my_QR(A,ITMAX,toll,esatto,bool) esgue ITMAX iterazioni del metodo QR
% bool=1 se la m
it=1;
err = zeros(ITMAX,1);
err(1)  =1;
esatto = sort(esatto);
%         cond= abs(A(end,end-1))/abs( A(end-1,end-1) + A(end,end));

while it<=ITMAX   && err(it)>toll
%     &&  cond> toll
    it = it+1;
    [ Q,R ] = my_QR(A);
    A = R * Q;
    if bool==1
        approx = diag(A);
    else
        approx= Auto_QuasiTriangolare(A,toll);
    end
        err(it)= max(abs(esatto-sort(approx)));
%         cond= abs(A(end,end-1))/abs( A(end-1,end-1) + A(end,end));
end
err = err(2:it);
if it==ITMAX+1
    warning('Raggiunto il numero massimo di iterazioni');
end
end