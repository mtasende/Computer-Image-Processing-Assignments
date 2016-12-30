%analizarBD

clc
clear all
close all

load pielFinal

%Histogramas
figure
hist(double(rPielFinal),50);title('R')
figure
hist(double(gPielFinal),50);title('G')
figure
hist(double(bPielFinal),50);title('B')

%Comprobacion con clasificacion simple de la literatura
w = max([rPielFinal gPielFinal bPielFinal],[],2) - min([rPielFinal gPielFinal bPielFinal],[],2);
p = sum(rPielFinal>90 & gPielFinal>40 & bPielFinal>20 & w>15 & abs(rPielFinal-gPielFinal)>15 & rPielFinal>gPielFinal & rPielFinal>bPielFinal)/length(rPielFinal);
disp(['Porcentaje de aciertos, usando regla simple de la literatura: ' num2str(p*100) '%']);


figure
plot3(rPielFinal,gPielFinal,bPielFinal,'.b')
xlabel('R')
ylabel('G')
zlabel('B');
grid on

pielFinal = double([rPielFinal gPielFinal bPielFinal]);

distInternas = mahal(pielFinal,pielFinal);
maxInterna = max(distInternas);
medianInterna = median(distInternas);
pFalsoNeg = 0.007;
distOrdenadas = sort(distInternas);
pDist = distOrdenadas(floor((1-pFalsoNeg)*length(distOrdenadas)));
limite = pDist;%medianInterna;%(2/3)*maxInterna;

M=255;
N=500000;
frontera = 255*[rand(N,1) rand(N,1) rand(N,1)];
frontera = frontera(abs(mahal(frontera,pielFinal)-limite)<5,:);

hold on
plot3(frontera(:,1),frontera(:,2),frontera(:,3),'.r')


%Pruebo con imagenes fuera del set de entrenamiento...
%pFalsoNeg = 0.007;
%distOrdenadas = sort(distInternas);
%pDist = distOrdenadas(floor((1-pFalsoNeg)*length(distOrdenadas)));
limite = pDist;
nombres = {'ID-10027590.jpg','ID-100209403.jpg','ID-10040375.jpg','ID-10044107.jpg','ID-10071091.jpg','ID-10082088.jpg'};

for i=1:length(nombres)
    imagenExtra = imread(nombres{i});
    imagenExtra = double(imagenExtra);
    imResultado=obtenerPiel(imagenExtra,pielFinal,limite);
    figure
    subplot(1,2,1)
    imshow(uint8(imagenExtra))
    subplot(1,2,2)
    imshow(uint8(imResultado))
end

