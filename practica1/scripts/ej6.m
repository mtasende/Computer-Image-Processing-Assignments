clc
clear all
close all

escan = imread('escaneado2.jpg');
are = imread('are.jpg');
knowledge = imread('knowledge.jpg');
imageProcessing = imread('ImageProcessing.jpg');

%Are
%Transformada
figure
umbralPU = 0.999965;
alargue = 3;
imRes = matchear(escan,are,umbralPU,alargue);
imagesc(imRes)
%Convolucion
figure
umbralPU = 0.92;
alargue = 1;
imRes2 = matchearConv(escan,are,umbralPU,alargue);
imagesc(imRes2)

%knowledge
%Transformada
figure
umbralPU = 0.99974;
alargue = 5;
imRes = matchear(escan,knowledge,umbralPU,alargue);
imagesc(imRes)
%Convolucion
figure
umbralPU = 0.9;
alargue = 1;
imRes2 = matchearConv(escan,knowledge,umbralPU,alargue);
imagesc(imRes2)



%Image Processing
%Transformada
figure
umbralPU = 0.99964;
alargue = 7;
imRes = matchear(escan,imageProcessing,umbralPU,alargue);
imagesc(imRes)
%Convolucion
figure
umbralPU = 0.9;
alargue = 1;
imRes2 = matchearConv(escan,imageProcessing,umbralPU,alargue);
imagesc(imRes2)
