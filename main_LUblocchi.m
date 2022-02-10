function main_LUblocchi
pulisci;
N = 100;
k=20;
B =ones(N,N);
C=diag(ones(k,1))+diag(ones(k-1,1),1)+diag(ones(k-1,1),-1);
A=rand(size(kron (C,B))).*kron (C,B);
chechk = controlla_3blocchi(A,N,k);
if(chechk==1)
    fprintf("La matrice e' 3-diagonale a blocchi\n");
else
    fprintf("La matrice non e' 3-diagonale a blocchi\n");
end
b =randn(N*k,1);
fprintf("\nCalcolo con triblocksolvees\n");
tic; x= triblocksolvees(A,b,N); toc;
fprintf("Calcolo con backslash\n");
tic; esatta = A\b; toc;
fprintf("\nNorma dell'errore:%f\n",norm(esatta-x))

end

function b= controlla_3blocchi(A,N,k)
dim= 1:N;
b=true;
for i = 1:k
    for j= 1:k
        if abs(i-j)>1
            B = A(N*(i-1)+dim,N*(j-1)+dim);
            b =( norm(B)==0);
        end
    end
end
end

function x=triblocksolvees(A,b,N)
%input A square block matrix, b column vector, N dimension of block
rows=size(A,1);
if ~mod(N,rows) % Determine if number of rows is a multiple of N
    error('A must have an integer number of N by N blocks');
end
nblk=rows/N; % number of blocks
b=reshape(b,N,nblk);% Convert rhs to matrix
x=zeros(N,nblk);% Store solution as matrix
y=x;
D=zeros(N,N,nblk);% Diagonal blocks
U=D; L=D;
B=zeros(N,N,nblk-1);% subdiagonal blocks
C=B;% superdiagonal blocks
for k=1:nblk-1% Convert A into arrays of blocks
    block=(1:N)+(k-1)*N;
    D(:,:,k)=A(block,block);
    B(:,:,k)=A(block+N,block);
    C(:,:,k)=A(block,block+N);
end
block=(1:N)+(nblk-1)*N;
D(:,:,nblk)=A(block,block);
U(:,:,1)=D(:,:,1);
for k=2:nblk
    L(:,:,k)=B(:,:,k-1)/U(:,:,k-1);
    U(:,:,k)=D(:,:,k)-L(:,:,k)*C(:,:,k-1);
end
y(:,1)=b(:,1);
for k=2:nblk
    y(:,k)=b(:,k)-L(:,:,k)*y(:,k-1);
end
x(:,nblk)=U(:,:,nblk)\y(:,nblk);
for k=(nblk-1):-1:1
    x(:,k)=U(:,:,k)\( y(:,k)-C(:,:,k)*x(:,k+1) );
end
x=x(:);% Revert to vector form
end