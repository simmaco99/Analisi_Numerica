function [esplicito,metodo,passo]=Adams_scegli(dim)
esplicito= menu('Scegli un tipo di metodo','esplicito','implicito');
if esplicito ==1 || dim==2 
 	metodo = menu('Scegli un metodo esplicito','AB1','AB2','AB3','AB4');
    
    passo = metodo;
else    
    passo= menu('Scegli un metodo implicito','AM1','AM2','AM3','AM4');
    metodo = passo+1;
else
   
end
end
