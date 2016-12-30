function yr=interpBilineal(I,x)
%Se le pasa una x en coordenadas homogeneas y devuelve la yr=I(x) que interpola,
%según la imagen I, con interpolación bilineal

%Identifico los cuatro puntos involucrados de la imagen
v11 = [floor(x(2)) floor(x(1))];
v12 = [floor(x(2)) ceil(x(1))];
v21 = [ceil(x(2)) floor(x(1))];
v22 = [ceil(x(2)) ceil(x(1))];

i = x(2);
j = x(1);

%Elimino casos especiales
if(floor(x(2)) == ceil(x(2)))
    if(floor(x(1)) == ceil(x(1))) %No interpolo, valor de la grilla
        yr = I(i,j);
    else  %Sólo interpolo en j
        yr1 = I(i,v11(2))*max([1-abs(v11(2)-j),0]);
        yr2 = I(i,v12(2))*max([1-abs(v12(2)-j),0]);
        
        yr = yr1 + yr2;
    end
else
    if(floor(x(1)) == ceil(x(1)))  %Sólo interpolo en i
        yr1 = I(v21(1),j)*max([1-abs(v21(1)-i),0]);
        yr2 = I(v22(1),j)*max([1-abs(v22(1)-i),0]);
        
        yr = yr1 + yr2;
    else  %Interpolo en 2D
        yr11 = I(v11(1),v11(2))*max([1-abs(v11(1)-i),0])*max([1-abs(v11(2)-j),0]);
        yr12 = I(v12(1),v12(2))*max([1-abs(v12(1)-i),0])*max([1-abs(v12(2)-j),0]);
        yr21 = I(v21(1),v21(2))*max([1-abs(v21(1)-i),0])*max([1-abs(v21(2)-j),0]);
        yr22 = I(v22(1),v22(2))*max([1-abs(v22(1)-i),0])*max([1-abs(v22(2)-j),0]);
        
        yr = yr11 + yr12 + yr21 + yr22;
    end
end

