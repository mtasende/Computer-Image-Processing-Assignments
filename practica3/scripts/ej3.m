clc
clear all
close all

imTest = imread('para_etiquetar.bmp');
imTest = 1-(imTest/255);
%imshow(imTest)

%[imRes,clases]=etiquetar(imTest,4);
[imRes,clases]=etiquetar(imTest,8);

figure
subplot(1,2,1)
imagesc(imTest)
subplot(1,2,2)
imagesc(imRes)
