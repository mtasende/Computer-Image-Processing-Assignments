clc
clear all
close all

trapo = imread('trapo.jpg');

trapoSub=subMuestreo(trapo,4);

subplot(1,2,1)
imshow(trapo);title('Imagen original')
subplot(1,2,2)
imshow(trapoSub);title('Imagen submuestreada')

%Visualizar Transformadas
figure
subplot(1,2,1)
dftTrapo = fft2(double(trapo));
dftTrapoS = fftshift(dftTrapo);
imagesc(log(1+abs(dftTrapoS)));title('Imagen original')
subplot(1,2,2)
dftTrapoSub = fft2(double(trapoSub));
dftTrapoSubS = fftshift(dftTrapoSub);
imagesc(log(1+abs(dftTrapoSubS)));title('Imagen submuestreada')

%%Arreglar el problema de submuestreo

%Definición del filtro
filtro = zeros(512,512);
corte = 64;
filtro(1:corte,1:corte) = 1;
filtro(512-corte+1:512,512-corte+1:512) = 1;
filtro(1:corte,512-corte+1:512) = 1;
filtro(512-corte+1:512,1:corte) = 1;
%Filtro listo

dftTrapoFiltrada = dftTrapo.*filtro;
trapoFiltrado = real(ifft2(dftTrapoFiltrada));
trapoFiltradoSub = subMuestreo(trapoFiltrado,4);


%Visualización
figure
subplot(1,2,1)
imshow(trapo);title('Imagen original')
subplot(1,2,2)
imshow(trapoFiltradoSub,[0 255]);title('Imagen filtrada y submuestreada')

%Visualizar Transformadas
figure
subplot(1,2,1)
imagesc(log(1+abs(dftTrapoS)));title('Imagen original')
subplot(1,2,2)
dftTrapoFiltradoSub = fft2(trapoFiltradoSub);
dftTrapoFiltradoSubS = fftshift(dftTrapoFiltradoSub);
imagesc(log(1+abs(dftTrapoFiltradoSubS)));title('Imagen filtrada y submuestreada')


