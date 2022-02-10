function [Q,R]=my_QR(A)
[m,n]=size(A);
Q= zeros(m,n);
R=zeros(n);
Q(1:m,1) = A(1:m,1);
R(1,1)=1;

for k=1:n
    R(k,k) = norm(A(1:m,k));
    Q(1:m,k) = A(1:m,k)/R(k,k);
    j=k+1:n;
    R(k,j) = Q(1:m,k)'* A(1:m,j);
    A(1:m,j) = A (1:m,j)-Q(1:m,k)*R(k,j);
end

end