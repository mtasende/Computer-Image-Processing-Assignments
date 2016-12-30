clc
clear all
close all

lena = imread('lena.png');

%Formo los nombres de archivo a cargar-------------------------------------
sigmas = [5 10 20 40];
ps = [0.1 0.3 0.5 0.8];
tamMedia = [3 7 11];
tamMediana = [3 7 11];
tamAdapt = [7 11];

Nr1 = length(sigmas);
Nr2 = Nr1+length(ps);
for i=1:Nr1
    tiposRuido{i} = ['RGauss' num2str(sigmas(i))];
end
for i=Nr1+1:Nr2
    tiposRuido{i} = ['RSyP' num2str(ps(i-Nr1))];
end

tiposFiltro{1} = '';
Nf1 = length(tamMedia)+1;
Nf2 = Nf1 + length(tamMediana);
Nf3 = Nf2 + length(tamAdapt);
for i=2:Nf1
    tiposFiltro{i} = ['FMedia' num2str(tamMedia(i-1))];
end
for i=Nf1+1:Nf2
    tiposFiltro{i} = ['FMediana' num2str(tamMediana(i-Nf1))];
end
for i=Nf2+1:Nf3
    tiposFiltro{i} = ['FAdapt' num2str(tamAdapt(i-Nf2))];
end
tiposFiltro{Nf3+1} = 'FNLM';

Nruidos = length(tiposRuido);
Nfiltros = length(tiposFiltro);

valorPSNR = -1*ones(Nruidos,Nfiltros);
valorRMSE = -1*ones(Nruidos,Nfiltros);

for i=1:Nruidos
    for j=1:Nfiltros
        nombre{i,j} = ['lena' tiposRuido{i} tiposFiltro{j} '.png'];
        filtrada = imread(nombre{i,j});
        
        valorPSNR(i,j) = psnr(lena,filtrada,255);
        valorRMSE(i,j) = rmse(lena,filtrada);
    end
end

tablaPSNR = cell(Nruidos+1,Nfiltros+1);
tablaPSNR{1,1} = '';
tablaPSNR(2:end,1) = tiposRuido';
tablaPSNR(1,2:end) = tiposFiltro;
tablaPSNR{1,2} = 'Ninguno';
tablaPSNR(2:end,2:end) = mat2cell(valorPSNR,ones(1,Nruidos),ones(1,Nfiltros));

disp('PSNR')
disp('---------------------------------------------------------------------------------------------------------')
mostrarTabla(tablaPSNR);
disp('---------------------------------------------------------------------------------------------------------')
disp('')


tablaRMSE = cell(Nruidos+1,Nfiltros+1);
tablaRMSE{1,1} = '';
tablaRMSE(2:end,1) = tiposRuido';
tablaRMSE(1,2:end) = tiposFiltro;
tablaRMSE{1,2} = 'Ninguno';
tablaRMSE(2:end,2:end) = mat2cell(valorRMSE,ones(1,Nruidos),ones(1,Nfiltros));

disp('')
disp('RMSE')
disp('---------------------------------------------------------------------------------------------------------')
mostrarTabla(tablaRMSE);
disp('---------------------------------------------------------------------------------------------------------')



%Muestro las imagenes del filtro NLM
%Gaussianas
figure
for i=1:4
    nombreOrig{i} = ['lena' tiposRuido{i} '.png'];
    nombreFiltrada{i} = ['lena' tiposRuido{i} 'FNLM.png'];
    orig = imread(nombreOrig{i});
    filtrada = imread(nombreFiltrada{i});
    
    subplot(2,4,i)
    imshow(orig)
    title(['Imagen original con ruido Gaussiano, sigma = ' num2str(sigmas(i))])
    subplot(2,4,4+i)
    imshow(filtrada)
    title('Con filtro NLM')
end
%Sal y Pimienta
figure
for i=5:Nruidos
    nombreOrig{i} = ['lena' tiposRuido{i} '.png'];
    nombreFiltrada{i} = ['lena' tiposRuido{i} 'FNLM.png'];
    orig = imread(nombreOrig{i});
    filtrada = imread(nombreFiltrada{i});
    
    subplot(2,4,i-4)
    imshow(orig)
    title(['Imagen original con ruido Sal y Pimienta, p = ' num2str(ps(i-4))])
    subplot(2,4,i)
    imshow(filtrada)
    title('Con filtro NLM')
end
