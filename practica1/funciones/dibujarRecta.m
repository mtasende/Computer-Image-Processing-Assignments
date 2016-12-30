function imRes = dibujarRecta(imagen,v1,v2,intensidad)

%Las 'x' corresponden a j, las 'y' corresponden a i (invertidas)

imRes = imagen;

orientacion = 0; %Angulo menor a 45º

if(v1(2)==v2(2)) %Recta vertical (para no dividir por 0 en el próximo 'if')
    if(v1(1)==v2(1)) %Los dos vértices son el mismo punto, dibujo uno sólo (caso 'patológico')
        imRes(v1(1),v1(2)) = intensidad;
        return;
    end
    orientacion = 1; %Angulo mayor a 45º
else
    if(abs((v1(1)-v2(1))/(v1(2)-v2(2))) > 1)
        orientacion = 1; %Angulo mayor a 45º
    end
end

if(orientacion==0)
    
    %Tomo el mínimo según el valor j (corresponde a "x")
    if(v1(2)<v2(2))
        vmin = v1;
        vmax = v2;
    else
        vmin = v2;
        vmax = v1;
    end
    
    for j=vmin(2):vmax(2)
        ireal = (((vmax(1)-vmin(1))/(vmax(2)-vmin(2)))*(j-vmin(2))) + vmin(1);
        imRes(round(ireal),j) = intensidad;
    end
    
else
    
    %Tomo el mínimo según el valor i (corresponde a "y")
    if(v1(1)<v2(1))
        vmin = v1;
        vmax = v2;
    else
        vmin = v2;
        vmax = v1;
    end

    for i=vmin(1):vmax(1)
        jreal = (((vmax(2)-vmin(2))/(vmax(1)-vmin(1)))*(i-vmin(1))) + vmin(2);
        imRes(i,round(jreal)) = intensidad;
    end
    
end

