clc
clear all
close all

%Pruebo el cálculo de homografía con una artificial
edif = imread('edificio.jpg');
edif = double(rgb2gray(edif));

H = [1.1 0.9 0;0.7 1.2 0;0 0 1];
det(H)
H
edifProy = transformar(edif,H,'vecino','si');

figure
subplot(1,2,1)
imshow(edif,[0 255])
subplot(1,2,2)
imshow(edifProy,[0 255])

figure
imshow(edif,[0 255])
disp('Elegir 4 puntos')
[x y] = getpts
puntosA = [x(1) x(2) x(3) x(4);y(1) y(2) y(3) y(4);1 1 1 1];
puntosB = H*puntosA

figure
edifProy2 = edifProy;
for i=1:4
    edifProy2(round(puntosB(2,i)),round(puntosB(1,i))) = 1000;
end
imagesc(edifProy2)

Hcalc = calcularHomografia(puntosA,puntosB)


figure
imshow(edif,[0 255])
disp('Elegir muchos puntos')
[x y] = getpts
puntosA = [x';y';ones(1,length(x))];
puntosB = H*puntosA

HcalcMC = calcularHomografiaMC(puntosA,puntosB)
