clc
clear all
close all

imagen = imread('../imagenes/lena.bmp');
nivel = marchSquares(imagen,100,3);

figure
imshow(nivel,[0 255]); title('Marching Sqares implementado')
figure
contour(flipud(imagen),[100 100]);title('Contour')



figure
A = zeros(5,5);
A(2:4,2:4)=1;
imshow(A)
figure
umbral = 0.5;
nivel = marchSquares(A,umbral,100);

imshow(nivel,[0 255]);

