function lamda= Auto_QuasiTriangolare(A,toll)
% trova gli autovalori a di A dove A è quasi triangolare superiore
n= size(A,1);
lamda = zeros(n,1);
k=1;
while k <=n-1
    if abs(A(k+1,k))<=toll
        lamda(k) = A(k,k);
        k = k+1;
    else
       %blocco dimensione due per due
       lamda(k:k+1) =eig(A(k:k+1,k:k+1));
       k = k + 2;
    end
end
lamda(n) = A(n,n);
end

% function [l1,l2]= AutoBlocco(A)
% a = A(1,1); b = A(1,2); c=A(2,1); d= A(2,2);
% 
% % evitiamo cancellazioni numeriche
% e = a* d - b*c;
% f = a+ b;
% if e<0
%     delta = f^2 - 4*e;
%     if f>0 
%         l1 = (f + sqrt(delta))/2;
%     else
%         l1 = (f - sqrt(delta))/2;
%     end
%     l2 = a*d/l1;
% else
%     delta = f^2 + 4*e;
%     if f>0 
%         l1 = -( f + sqrt(delta))/2;
%     else
%         l1 = -(f-sqrt(delta))/2;
%     end
%     l2=a*d/l1;
% end
% end
%     