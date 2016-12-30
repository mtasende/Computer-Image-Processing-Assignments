clc
clear all
close all

%----Cargo imagenes------------------------
lena = double(imread('lena.bmp'));
imwrite(uint8(lena),'../imagenes/lena.png','PNG');

[peppers,map] = imread('peppers.png');
peppers = double(ind2gray(peppers,map));

baboon = imread('baboon.png');
baboon = double(rgb2gray(baboon));
%-------------------------------------------

[Mlena,Nlena] = size(lena);
[Mpeppers,Npeppers] = size(peppers);
[Mbaboon,Nbaboon] = size(baboon);

sigmas = [5 10 20 40];
ps = [0.1 0.3 0.5 0.8];
tamMedia = [3 7 11];
tamMediana = [3 7 11];
tamAdapt = [7 11];

%Uso este for para todo el resto del script. Las imágenes se van a ver de a
%4
for i=1:length(sigmas)
    %a)
    lenasGaussianas{i} = lena + sigmas(i)*randn(Mlena,Nlena);
    figure(1)
    subplot(2,length(sigmas),i)
    imshow(lenasGaussianas{i},[0 255])
    lenasSalYPimienta{i} = salYPimienta(lena,ps(i));
    subplot(2,length(ps),length(sigmas)+i)
    imshow(lenasSalYPimienta{i},[0 255])
    
    %Guardo las imagenes con ruido---------------------------------------
    imwrite(uint8(lenasGaussianas{i}),['../imagenes/lenaRGauss' num2str(sigmas(i)) '.png'],'PNG');
    imwrite(uint8(lenasSalYPimienta{i}),['../imagenes/lenaRSyP' num2str(ps(i)) '.png'],'PNG');
    %--------------------------------------------------------------------
    
    %b)
    %Ruido Gaussiano-------------------------------------
        %Filtro de Media
    figure(2)
    for j=1:length(tamMedia)+1
        if(j<2)
            lenasGaussMedia{i,j} = lenasGaussianas{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussMedia{i,j},[0 255])
            title(['Imagen original con ruido Gaussiano, sigma = ' num2str(sigmas(i))])
        else
            lenasGaussMedia{i,j} = filtroMedia(lenasGaussianas{i},tamMedia(j-1));
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussMedia{i,j},[0 255])
            title(['Con filtro de Media, tam = ' num2str(tamMedia(j-1)) 'x' num2str(tamMedia(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasGaussMedia{i,j}),['../imagenes/lenaRGauss' num2str(sigmas(i)) 'FMedia' num2str(tamMedia(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------------
        end
    end
        %Filtro de Mediana
    figure(3)
    for j=1:length(tamMediana)+1
        if(j<2)
            lenasGaussMediana{i,j} = lenasGaussianas{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussMediana{i,j},[0 255])
            title(['Imagen original con ruido Gaussiano, sigma = ' num2str(sigmas(i))])
        else
            lenasGaussMediana{i,j} = filtroMediana(lenasGaussianas{i},tamMediana(j-1));
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussMediana{i,j},[0 255])
            title(['Con filtro de Mediana, tam = ' num2str(tamMediana(j-1)) 'x' num2str(tamMediana(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasGaussMediana{i,j}),['../imagenes/lenaRGauss' num2str(sigmas(i)) 'FMediana' num2str(tamMedia(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------
        end
    end
    
        %Filtro Adaptivo
    figure(4)
    for j=1:length(tamAdapt)+1
        if(j<2)
            lenasGaussAdapt{i,j} = lenasGaussianas{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussAdapt{i,j},[0 255])
            title(['Imagen original con ruido Gaussiano, sigma = ' num2str(sigmas(i))])
        else
            lenasGaussAdapt{i,j} = filtroAdaptivo(lenasGaussianas{i},tamAdapt(j-1),sigmas(i)^2);
            subplot(4,4,4*(j-1)+i)
            imshow(lenasGaussAdapt{i,j},[0 255])
            title(['Con filtro Adaptativo, tam = ' num2str(tamAdapt(j-1)) 'x' num2str(tamAdapt(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasGaussAdapt{i,j}),['../imagenes/lenaRGauss' num2str(sigmas(i)) 'FAdapt' num2str(tamAdapt(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------
        end
    end
    %------------------------------------------------------
    
    %Ruido Sal y Pimienta----------------------------------
        %Filtro de Media
    figure(6)
    for j=1:length(tamMedia)+1
        if(j<2)
            lenasSYPMedia{i,j} = lenasSalYPimienta{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSYPMedia{i,j},[0 255])
            title(['Imagen original con ruido Sal y Pimienta, p = ' num2str(ps(i))])
        else
            lenasSYPMedia{i,j} = filtroMedia(lenasSalYPimienta{i},tamMedia(j-1));
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSYPMedia{i,j},[0 255])
            title(['Con filtro de Media, tam = ' num2str(tamMedia(j-1)) 'x' num2str(tamMedia(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasSYPMedia{i,j}),['../imagenes/lenaRSyP' num2str(ps(i)) 'FMedia' num2str(tamMedia(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------
        end
    end
    
        %Filtro de Mediana
    figure(7)
    for j=1:length(tamMediana)+1
        if(j<2)
            lenasSYPMediana{i,j} = lenasSalYPimienta{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSYPMediana{i,j},[0 255])
            title(['Imagen original con ruido Sal y Pimienta, p = ' num2str(ps(i))])
        else
            lenasSYPMediana{i,j} = filtroMediana(lenasSalYPimienta{i},tamMediana(j-1));
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSYPMediana{i,j},[0 255])
            title(['Con filtro de Mediana, tam = ' num2str(tamMedia(j-1)) 'x' num2str(tamMedia(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasSYPMediana{i,j}),['../imagenes/lenaRSyP' num2str(ps(i)) 'FMediana' num2str(tamMediana(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------
        end
    end
    
    %Filtro Adaptivo
    figure(8)
    %Calculo el sigma2 del ruido Sal y Pimienta, primero...
    muSP = 255*ps(i)/2;
    sigma2SP = (ps(i)/2)*(255^2) - muSP^2;
    sigmaSyP(i) = sqrt(sigma2SP);
    for j=1:length(tamAdapt)+1
        if(j<2)
            lenasSyPAdapt{i,j} = lenasSalYPimienta{i};
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSyPAdapt{i,j},[0 255])
            title(['Imagen original con ruido Sal y Pimienta, p = ' num2str(ps(i))])
        else
            lenasSyPAdapt{i,j} = filtroAdaptivo(lenasSalYPimienta{i},tamAdapt(j-1),sigma2SP);
            subplot(4,4,4*(j-1)+i)
            imshow(lenasSyPAdapt{i,j},[0 255])
            title(['Con filtro Adaptativo, tam = ' num2str(tamAdapt(j-1)) 'x' num2str(tamAdapt(j-1))])
            
            %Guardo las imagenes filtradas---------------------------------------
            imwrite(uint8(lenasSyPAdapt{i,j}),['../imagenes/lenaRSyP' num2str(ps(i)) 'FAdapt' num2str(tamAdapt(j-1)) '.png'],'PNG');
            %--------------------------------------------------------------
        end
    end
    %------------------------------------------------------
    
end

sigmaSyP

