clc
clear all
close all

imagen(:,:,1) = rgb2gray(imread('miCI1modif.jpg'));
imagen(:,:,2) = rgb2gray(imread('miCI2modif.jpg'));
imagen(:,:,3) = rgb2gray(imread('miCI3modif.jpg'));
imagen(:,:,4) = rgb2gray(imread('miCI4modif.jpg'));
imagen(:,:,5) = rgb2gray(imread('CIPablo1modif.jpg'));
imagen(:,:,6) = rgb2gray(imread('CISantiago1modif.jpg'));

resultadoEsperado = [3 8 3 5 2 5 8 4;
    3 8 3 5 2 5 8 4;
    3 8 3 5 2 5 8 4;
    3 8 3 5 2 5 8 4;
    3 9 8 0 8 5 8 4;
    4 7 4 2 3 7 9 8
    ];

for indIma=1:length(imagen(1,1,:))
    ima = imagen(:,:,indIma);

p = 0.10; %de umbral para Sobel
K = 1; %Primer pixel

imaSobel = sobel(ima,p);
imaCont = contorno(imaSobel,K);

figure
subplot(1,2,1)
imshow(imaSobel)
subplot(1,2,2)
imshow(imaCont)

%Voy a detectar las cuatro rectas del contorno------------------
[M N]=size(imaCont);
centro = [round(M/2) round(N/2)];

%Detecto la recta de arriba
thetaArriba = -35:0.1:35;
dRhoArriba = 0.5;
mitadArriba = imaCont;
mitadArriba(floor(size(imaCont,1)/2):end,:) = 0;
[matrizHArriba,rhoArriba,thetaArriba] = houghM(mitadArriba,dRhoArriba,thetaArriba);
umbralArriba = ceil(0.3*max(matrizHArriba(:)));
PArriba = picosHough(matrizHArriba,umbralArriba,1);
thArriba = thetaArriba(PArriba(:,2)); 
rArriba = rhoArriba(PArriba(:,1));

%Detecto la recta de abajo
thetaAbajo = -35:0.1:35;
dRhoAbajo = 0.5;
mitadAbajo = imaCont;
mitadAbajo(1:floor(size(imaCont,1)/2),:) = 0;
[matrizHAbajo,rhoAbajo,thetaAbajo] = houghM(mitadAbajo,dRhoAbajo,thetaAbajo);
umbralAbajo = ceil(0.3*max(matrizHAbajo(:)));
PAbajo = picosHough(matrizHAbajo,umbralAbajo,1);
thAbajo = thetaAbajo(PAbajo(:,2)); 
rAbajo = rhoAbajo(PAbajo(:,1));

%Detecto la recta de la derecha
thetaDer = 55:0.1:125;
dRhoDer = 1;
mitadDer = imaCont;
mitadDer(:,1:floor(size(imaCont,2)/2)) = 0;
[matrizHDer,rhoDer,thetaDer] = houghM(mitadDer,dRhoDer,thetaDer);
umbralDer = ceil(0.3*max(matrizHDer(:)));
PDer = picosHough(matrizHDer,umbralDer,1);
thDer = thetaDer(PDer(:,2)); 
rDer = rhoDer(PDer(:,1));

%Detecto la recta de la izquierda
thetaIzq = 55:0.1:125;
dRhoIzq = 1;
mitadIzq = imaCont;
mitadIzq(:,(floor(size(imaCont,2)/2):end)) = 0;
[matrizHIzq,rhoIzq,thetaIzq] = houghM(mitadIzq,dRhoIzq,thetaIzq);
umbralIzq = ceil(0.3*max(matrizHIzq(:)));
PIzq = picosHough(matrizHIzq,umbralIzq,1);
thIzq = thetaIzq(PIzq(:,2)); 
rIzq = rhoIzq(PIzq(:,1));


%Ahora dibujo las lineas resultantes
figure
subplot(3,3,2)
imshow(mitadArriba)
hold on
dibujarLineas(rArriba,thArriba,1:N,centro);
subplot(3,3,8)
imshow(mitadAbajo)
hold on
dibujarLineas(rAbajo,thAbajo,1:N,centro);
subplot(3,3,4)
imshow(mitadIzq)
hold on
dibujarLineas(rIzq,thIzq,1:N,centro);
subplot(3,3,6)
imshow(mitadDer)
hold on
dibujarLineas(rDer,thDer,1:N,centro);
subplot(3,3,5)
imshow(imaCont)
hold on
dibujarLineas([rArriba;rAbajo;rDer;rIzq],[thArriba;thAbajo;thDer;thIzq],1:N,centro);

%Dibujo todas las lineas juntas
figure
imshow(imaCont)
hold on
dibujarLineas([rArriba;rAbajo;rDer;rIzq],[thArriba;thAbajo;thDer;thIzq],1:N,centro);
hold on
%Encuentro los vertices y los muestro en la misma imagen
vertices = interseccion([rArriba;rArriba;rAbajo;rAbajo],[thArriba;thArriba;thAbajo;thAbajo],[rIzq;rDer;rIzq;rDer],[thIzq;thDer;thIzq;thDer],centro);
plot(vertices(:,2),vertices(:,1),'*r','MarkerSize',20)

%Ahora busco la Homografia que pase a una cedula estandar
verticesEstandar = [0 0;0 1024;768 0;768 1024];
Transf = cp2tform([vertices(:,2) vertices(:,1)],[verticesEstandar(:,2) verticesEstandar(:,1)], 'projective');
J = imtransform(ima,Transf,'bicubic','XData',[0 1024],'YData',[0 768],'XYScale',[1 1]);
figure
imshow(J,[0 255])


%Tomo la zona de los numeros
%jNum = [435 673];
jNum = [425 673];
iNum = [368 415];
imaNum = uint8(J(iNum(1):iNum(2),jNum(1):jNum(2)));
figure
imshow(imaNum)


%Repito cosas parecidas al ejercicio 4 para esa imagen (imaNum)------------------------
[imaNumOtsu,umbral] = otsu(imaNum);

Ncifras = 8;
imaNumOtsu = 1-imaNumOtsu;
[imaNumEro,regiones] = erosionAdapt(imaNumOtsu,Ncifras,[0.5 1.5]); %Erosiona hasta obtener 8 regiones "parecidas"
figure
subplot(1,2,1)
imagesc(imaNumOtsu)
subplot(1,2,2)
imagesc(imaNumEro)

figure
imaNumFilt = zeros(size(imaNumEro));
for i=1:Ncifras
    subplot(Ncifras,1,i)
    imagesc(regiones(:,:,i))
    imaNumFilt = imaNumFilt + regiones(:,:,i); %Estan "desordenadas"
    %Ordeno las cifras y las enmarco (no cuesta y despues hace mas corto el procesamiento)
    [cCifra(i),cifraMarco(:,:,i)] = marcoCifra(regiones(:,:,i));
end
[descartar indices] = sort(cCifra);
regiones = cifraMarco(:,:,indices);
figure
for i=1:Ncifras
    subplot(1,Ncifras,i)
    imagesc(regiones(:,:,i))
end

%imwrite(imaNumFilt,['numeros' num2str(indIma) '.bmp'],'BMP');%ESTO SE
%PUEDE USAR PARA SACAR ALGUN PATRON DE CIFRAS DE MATCHEO


%Cargo los patrones de matcheo (Solo conozco los numeros de las cedulas que pude conseguir)
indicesConocidos = [0 2 3 4 5 7 8 9];
Npat = length(indicesConocidos);
for i=1:Npat
    patron{i}=imread(['cifra' num2str(indicesConocidos(i)) '.bmp']);
end


matcheo = zeros(Ncifras,Npat);
for i = 1:Ncifras
    %Veo contra que patron matchea mejor
    for j=1:Npat
        patronTemp = 2*(patron{j}~=0)-1;
        cifraTemp = 2*(regiones(:,:,i)~=0)-1;
        %dif(i,j) = diferencia(cifraTemp,patronTemp); 
        matcheo(i,j) = matchear(cifraTemp,patronTemp);
    end
    [Maximo indMatch] = max(matcheo(i,:));
    %[Minimo indMatch] = min(dif(i,:),[],2);
    cifraMatch(indIma,i) = indicesConocidos(indMatch);
end

end

disp('Resultados:')
cifraMatch
resultadoEsperado