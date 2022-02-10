function [t0,u]=multistep(ordine,a,b,tf,t0, u0,h,fun,dfun,toll,ITMAX,dim)

f= fun(t0,u0);
p = length(a) - 1;
u = u0;
nt = floor((tf - t0(1))/h);
k=1;

while k <=nt-ordine + 1
    lu = size(u,1);
    G = a* u(lu:-1:lu-p,:) + h * b(2:p+2) * f( lu:-1:lu-p,:);
    t0= [ t0; t0(end) + h];
    if b(1) ==0 %esplicito
        unew=G; fn =fun(t0(end),unew);
    else
        if dim==1
            un=u(lu);unew=un;
            t=t0(lu+1); err =toll+1; it=0;
            while err>toll &&it<=ITMAX
                den =1-h*b(1)*dfun(t,unew);
                fn =fun(t,unew);
                if den==0
                    it = itmax+1;
                else
                    it =it+1;
                    unew1= unew-(unew-G-h*b(1)*fn)/den;
                    err=abs(unew1-unew);
                    unew=unew1;
                end
            end
            
        else
           error("I metodi impliciti in 2 dimensioni non sono implementati"
		end
        
    end
    u = [ u ; unew];
    f  = [f;fn];
    k=k+1;
end

end
%
