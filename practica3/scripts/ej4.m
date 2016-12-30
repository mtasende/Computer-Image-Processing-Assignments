clc
clear all
close all


imTest = rgb2gray(imread('miCI1modif.jpg'));

imTest = imTest(300:330,231:482);

[imRes,umbral] = otsu(imTest);

imRes = 1-imRes;
figure
subplot(2,1,1)
imagesc(imTest)
subplot(2,1,2)
imagesc(imRes)

%Con una linea
original = imRes;
se = strel('square',1);
afterOpening = imerode(original,se);
figure, imshow(original), figure, imshow(afterOpening)


tic
[imRes2,clases]=etiquetar(afterOpening,8);
toc

figure
subplot(2,1,1)
imagesc(afterOpening)
subplot(2,1,2)
imagesc(imRes2)


%Con un rectangulo
original = imRes;
se = strel('rectangle',[2 1]);
afterOpening = imerode(original,se);
figure, imshow(original), figure, imshow(afterOpening)


tic
[imRes2,clases]=etiquetar(afterOpening,8);
toc

figure
subplot(2,1,1)
imagesc(afterOpening)
subplot(2,1,2)
imagesc(imRes2)
