clc
clear all
close all

imagen = 255*ones(200,200);
imagen = dibujarRecta(imagen,[10 10],[70 150],20);
imagen = dibujarRecta(imagen,[10 10],[70 10],100);
imagen = dibujarRecta(imagen,[70 10],[70 150],150);

imshow(imagen,[0 255])
figure
imagesc(imagen)
