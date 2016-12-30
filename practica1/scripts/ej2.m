clc
clear all
close all

lena = imread('lena.bmp');
lena = double(lena);

%Rotación
theta = pi/4;
H = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];

lenaRotada = transformar(lena,H,'vecino','si');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaRotada,[0 255]);title('Rotación con vecino mas cercano. Ventana agrandada.')

figure
lenaRotada = transformar(lena,H,'bilineal','no');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaRotada,[0 255]);title('Rotación con int. bilineal. Ventana no cambiada.')

figure
lenaRotada = transformar(lena,H,'bilineal','si');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaRotada,[0 255]);title('Rotación con int. bilineal. Ventana agrandada')


figure
tic
lenaRotada = transformar(lena,H,'bicubica','si');
toc

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaRotada,[0 255]);title('Rotación con int. bicubica. Ventana agrandada')


%Traslacion
H = [1 0 100;0 1 50;0 0 1];
figure
lenaTrasladada = transformar(double(lena),H,'bilineal','no');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaTrasladada,[0 255]);title('Traslación con int. bilineal')

%Afinidad
H = [1.2 0.7 10;0.4 0.9 5;0 0 1];
det(H(1:2,1:2))
figure
lenaAfin = transformar(double(lena),H,'vecino','no');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaAfin,[0 255]);title('Afinidad')

%Proyectividad
H = [2.2 0.7 10;0.5 1.9 50;1 0 1];
det(H)
figure
lenaProy = transformar(double(lena),H,'bilineal','no');

subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaProy,[0 255]);title('Proyectividad')


%Rotación centrada, multiplicando matrices
theta = pi/4;
Hr = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
Ht = [1 0 length(lena(:,1))/2;0 1 length(lena(1,:))/2;0 0 1];
Htinv = [1 0 -length(lena(:,1))/2;0 1 -length(lena(1,:))/2;0 0 1];

lenaRTM = transformar(lena,Ht*Hr*Htinv,'vecino','no');

figure
subplot(1,2,1)
imshow(lena,[0 255])
subplot(1,2,2)
imshow(lenaRTM,[0 255]);title('Rotacion centrada en cero, multiplicando matrices')

