function [select,x,cond,cb]=Poisson_scegli(select)
if nargin==0
    select =menu('Scegli la sorgente', 'f(x) = 0 in (0,1)','f(x) = exp(x) in (0,1)', 'f(x) = sin(x) in (0,2pi)','f(x) =3x+2 in (0,1)','f(x) = 2sin(x)exp(x) inn (0,2pi)');
end

switch select
    case 1
        x=[ 0 1];
        cond = menu('Condizioni al bordo','Dirichlet: u(0)=0 e u(1) =1',"Miste: u(0)=0 e u'(1)=1");
        cb=[0 1];
        if cond==1
            cond='D';
        else
            cond='Mf';
        end
    case 2
        x = [ 0 1];
        cond = menu('Condizioni al bordo','Diriichlet: u(0)=0 e u(1) =0',"Miste: u(0)=0 e u'(1)=-1");
        if cond==1
            cond='D';
            cb=[0 0 ];
        else
            cond='Mf';
            cb=[ 0 -1];
        end
    case 3
        x = [0 2*pi];
        cond = menu('Condizioni al bordo','Dirichlet: u(0)=0 e u(2?) =0',"Miste: u'(0)=1 e u(2?)=0");
        if cond==1
            cond='D';
            cb=[0 0 ];
        else
            cond='Mi';
            cb=[ 1 0];
        end
        
    case 4
        x=[0 1 ];
        cond = menu('Condizioni al bordo','Dirichlet: u(0)=0 e u(1) =1',"Miste: u'(0)=5/2 e u(1)=1");
        if cond==1
            cond='D';
            cb=[ 0 1];
        else
            cond ='Mi';
            cb=[5/2 1];
        end
    case 5
        x=[ 0 2*pi];
        cond=menu('Condizioni al bordo','Dirichlet: u(0)=1 e u(2pi)=exp(2pi)',"Miste: u'(0) = 1 e u(2pi) = exp(2pi)");
        cb=[1 exp(2*pi)];
        if cond==1
            cond='D';
        else
            cond = 'Mf';
        end
end
