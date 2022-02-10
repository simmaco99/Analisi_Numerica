function [x,it]= my_SOR(A,b,x,omega,toll,ITMAX)
% da vettorializzare (se possibile)
% omega = 1 si ottiene Gauss-Seide altrimenti SOR
n = size(A,1);
r = b - A*x;
r0 =norm(r);
err = r0;
it= 0;
z = x;
om1 = 1- omega;
while it<ITMAX && err>toll
    it = it+1;
    for i = 1: n
        x(i) =  b(i) - A(i,1:i-1)* x(1:i-1) - A(i,i+1:end) * z(i+1:end);
        x(i) = omega * x(i) /A(i,i) + om1 * z(i);
    end
    
    r = b - A*x;
    err = norm(r)/r0;
    z= x;
end
if it ==ITMAX 
    warning('Raggiunto il numero masismo di iterazioni');
end
end
        