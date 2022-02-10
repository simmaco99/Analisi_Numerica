function v = my_Householder(x, m) 
% v = Householder(x, m) calcola il vettore di Householder che mappa x in
% alpha e_m
% il segno viene scelto per evitare cancellazioni numeriche
v= x;
v(m) = v(m)  + sign(v(m)) * norm(x,2); 
v = v/norm(v);
end