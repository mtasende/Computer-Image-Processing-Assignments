clc
clear all
close all


imag1 = imread('1viewfigs-keble.000.bmp'); %izquierda
imag1 = double(rgb2gray(imag1));
imag2 = imread('1viewfigs-keble.003.bmp'); %centro
imag2 = double(rgb2gray(imag2));
imag3 = imread('1viewfigs-keble.006.bmp'); %derecha
imag3 = double(rgb2gray(imag3));

%Voy a establecer un lienzo comun, con sistema de coordenadas comun
M = size(imag1,1) + size(imag2,1) + size(imag3,1);
N = size(imag1,2) + size(imag2,2) + size(imag3,2);

ima1grande = centrarImagen(zeros(M,N),imag1);
ima2grande = centrarImagen(zeros(M,N),imag2); %Esta es la unica importante, para que quede centrada
ima3grande = centrarImagen(zeros(M,N),imag3);

figure
imshow(ima1grande,[0 255])
disp('Elegir 4 puntos')
[x1,y1]=ginput(4);
puntos1 = [x1';y1';ones(1,4)];
hold on
plot(x1,y1,'*r')

figure
imshow(ima2grande,[0 255])
disp('Elegir 4 puntos')
[x2,y2]=ginput(4);
puntos2 = [x2';y2';ones(1,4)];
hold on
plot(x2,y2,'*r')

figure
imshow(ima3grande,[0 255])
disp('Elegir 4 puntos')
[x3,y3]=ginput(4);
puntos3 = [x3';y3';ones(1,4)];
hold on
plot(x3,y3,'*r')

save puntos puntos1 puntos2 puntos3