function [matrizH,rho,thetaS]=houghM(imagen,dRho,theta)
%Se cambio el origen al centro de la imagen, asi que para tener todo el espacio,
%theta tiene que recorrer 180 grados.
%theta tiene que ser un vector fila

[m n]=size(imagen);
rho = -norm([m n])/2:dRho:norm([m n])/2;
M = length(rho);
%M = floor(norm([m n])/dRho); %La diagonal del rectangulo de la imagen, dividida por el paso de Rho
N = length(theta);
H = zeros(M,N); %Rho en las filas, theta en las columnas

thetaS = theta;

thetaRad = theta*pi/180;

centro = [round(m/2) round(n/2)]; %Muevo el origen al centro

for i=1:m
    for j=1:n
        if(imagen(i,j)>0) %Es un punto de borde
            %tomo x=i, y=j. Es decir que los ejes quedan rotados
            r = (i-centro(1))*cos(thetaRad) + (j-centro(2))*sin(thetaRad); %theta es un vector fila
            %Calculo en que celda de rho quedan esos
            for indTheta=1:N
                indRho = floor(r(indTheta)/dRho)+floor(M/2)+1;           
                H(indRho,indTheta) = H(indRho,indTheta) + 1;
            end
        end
    end
end

matrizH = H;
