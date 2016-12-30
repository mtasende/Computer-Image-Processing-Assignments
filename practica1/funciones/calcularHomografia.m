function matrizTransformacion = calcularHomografia(puntosA,puntosB)
%Se asume que se pasan los puntos en coordenadas uniformes
% puntosA =[x1 x2 x3 x4;y1 y2 y3 y4;1 1 1 1]
% puntosB =[x1 x2 x3 x4;y1 y2 y3 y4;1 1 1 1]
% Entonces puntosAt * Ht = puntosBt

H = zeros(3,3);
puntosBt = puntosB';
puntosAt = puntosA';

N = size(puntosAt,1); %deberia ser 4 para este caso

A = zeros(2*N,8);

%keyboard
A(1:N,1:3) = puntosAt;
A(N+1:end,4:6) = puntosAt;
A(1:N,7:end) = -puntosAt(:,1:2).*[puntosBt(:,1) puntosBt(:,1)];
A(N+1:end,7:end) = -puntosAt(:,1:2).*[puntosBt(:,2) puntosBt(:,2)];

y = [puntosBt(:,1);puntosBt(:,2)];

H = A\y;
H = [H;1];

matrizTransformacion = reshape(H,3,3)';

