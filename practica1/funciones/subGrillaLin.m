function imRes=subGrillaLin(imagen,Ni,Nj)
%Esta función toma una imagen muestreada según una grilla cualquiera y la
%remuestrea a una frecuencia mayor, hasta tener Ni x Nj puntos.
%Realiza interpolación lineal

Niprev = length(imagen(:,1));
Njprev = length(imagen(1,:));

factorI = ceil(Ni/Niprev);
factorJ = ceil(Nj/Njprev);

imRes = 255*ones(Ni,Nj);

for i=1:Ni
    for j=1:Nj
        
    end
end
