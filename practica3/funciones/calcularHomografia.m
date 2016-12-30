function matrizTransformacion = calcularHomografia(puntosA,puntosB)
%Se asume que se pasan los puntos en coordenadas uniformes
% puntosA =[x1 x2 x3 x4;y1 y2 y3 y4;1 1 1 1]
% puntosB =[x1 x2 x3 x4;y1 y2 y3 y4;1 1 1 1]
% Entonces puntosAt * Ht = puntosBt

Ht = zeros(3,3);
puntosBt = puntosB';
puntosAt = puntosA';

for i=1:3
   Ht(:,i) =  puntosAt\puntosBt(:,i);
end

matrizTransformacion = Ht';

