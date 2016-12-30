function [imRes,regiones] = erosionAdapt(imagen,Nreg,p)
%Nreg es el numero de regiones que se quiere
%Se devuelve una imagen erosionada y las Nreg regiones con mas pixels
%Se erosiona hasta que la ultima de las Nreg regiones tenga un tamanio entre p(1) y p(2) del
%tamanio promedio de las anteriores Nreg-1
%Esto se hace para que las Nreg regiones sean de tamanio similar

maxiter = 20;
erosion = 0;
imTemp = imagen;
imOriginal = imagen;
frac = 0; %fraccion del tamanio de la region Nreg respecto del promedio
iter = 0;
tengoPlanB = 0;
while((~(frac>p(1) && frac<p(2))) && iter<maxiter)
    se = strel('line',erosion,90);
    imTempE = imerode(imOriginal,se);
    [imTemp,clases]=etiquetar(imTempE,8);
    
    %Calculo frac
    imVec = imTemp(:);
    histograma = hist(imVec(imVec~=0),1:Nreg); %Dejo espacio a los costados para otras regiones chicas
    [mOrd,ind] = sort(histograma,'descend');
    if(length(ind)<Nreg)
        NcMax = length(ind);
        clasesGrandes = ind(1:NcMax);
        tam = mOrd(1:NcMax);
        frac = 0;
    else
        clasesGrandes = ind(1:Nreg);
        tam = mOrd(1:Nreg);
        frac = tam(Nreg)/mean(tam(1:Nreg-1));
        
        if(tengoPlanB == 0) %Lo guardo para el posible "Plan B". Esta es la primera vez que consigo mas de Nreg clases
            imagenPlanB = imTemp;
            clasesPlanB = clasesGrandes;
            tengoPlanB = 1;
        end
    end

    %keyboard
    erosion = erosion+1;
    iter = iter+1;
end

for i=1:Nreg
    if(iter==maxiter)
        regiones(:,:,i) = imagenPlanB.*(imagenPlanB==clasesPlanB(i));
    else
        regiones(:,:,i) = imTemp.*(imTemp==clasesGrandes(i));
    end
end

if(iter==maxiter)
    imRes = imagen;
else
    imRes = imTemp;
end

disp(['Erosion: ' num2str(erosion)])

