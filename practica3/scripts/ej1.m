clc
clear all
close all

%I = imread('lena.bmp');
%ima = rgb2gray(imread('miCI1chica.jpg'));
%ima = rgb2gray(imread('miCI2chica.jpg'));
%ima = rgb2gray(imread('miCI5chica.jpg'));
ima = rgb2gray(imread('miCI1modif.jpg'));
%ima = imread('oclusion.bmp');


imaSobel = sobel(ima,0.1);

imshow(imaSobel)
figure

theta = -90:0.1:90;
dRho = 1;

[matrizH,rho,theta] = houghM(imaSobel,dRho,theta);

surf(theta,rho,matrizH)
xlabel('\theta');ylabel('\rho')
figure

%umbral = input('Elija el umbral =');

%Esto muestra las sinusoides y los puntos de corte con mas cruces
imshow(matrizH,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
Hordenados = sort(matrizH(:));
%umbral = Hordenados(floor(0.9*length(Hordenados)));
%umbral = ceil(0.45*max(matrizH(:)));
umbral = ceil(0.6*max(matrizH(:)));
%umbral = 160;

P = picosHough(matrizH,umbral,150);
th = theta(P(:,2)); 
r = rho(P(:,1));
plot(th,r,'s','color','white');

%Ahora dibujo las lineas resultantes
figure
imshow(imaSobel)
hold on
[M N]=size(imaSobel); %x,y maximas

centro = [round(N/2) round(M/2)];
centro = [round(M/2) round(N/2)];
dibujarLineas(r,th,1:N,centro)
