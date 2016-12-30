clc
clear all
close all

imagen = imread('../imagenes/retina.bmp');
nivel = marchSquares(imagen,100,3);

figure
map = [ones(150,1)*[0 1 0]; ones(106,1)*[1 1 1]];
imshow(nivel,[0 255],'Colormap',map); title('Marching Sqares implementado')
figure
contour(flipud(imagen),[100 100]);title('Contour')


imagen = imread('../imagenes/lena.bmp');
nivel = marchSquares(imagen,100,3);

figure
map = [ones(150,1)*[0 1 0]; ones(106,1)*[1 1 1]];
imshow(nivel,[0 255],'Colormap',map); title('Marching Sqares implementado')
figure
contour(flipud(imagen),[100 100]);title('Contour')


figure
A = zeros(10,10);
A(3:5,3:5)=1;
A(6,6)=0.9;
A(2,6)=1.9;
A(2,2)=5.6;
A(6,2)=0.6;
%imshow(A)
imagesc(A)
umbral = 0.5;

figure
subplot(1,3,1)
nivel = marchSquares(A,umbral,1);
imagesc(nivel);title('divGrilla = 1')

subplot(1,3,2)
nivel = marchSquares(A,umbral,3);
imagesc(nivel);title('divGrilla = 3')

subplot(1,3,3)
nivel = marchSquares(A,umbral,20);
imagesc(nivel);title('divGrilla = 20')
