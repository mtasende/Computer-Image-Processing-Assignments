function imRes = subGrilla(imagen,Ni,Nj)
%Esta función toma una imagen muestreada según una grilla cualquiera y la
%remuestrea a una frecuencia mayor, hasta tener Ni x Nj puntos.

Niprev = length(imagen(:,1));
Njprev = length(imagen(1,:));

factorI = floor(Ni/Niprev); 
factorJ = floor(Nj/Njprev);

