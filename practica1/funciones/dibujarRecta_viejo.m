function imRes = dibujarRecta(imagen,v1,v2,intensidad)

rangoI = [min([v1(1),v2(1)]) max([v1(1),v2(1)])];
%rangoJ = [min([v1(2),v2(2)]) max([v1(2),v2(2)])];

%Tomo el mínimo según el valor j (corresponde a "x")
if(v1(2)<v2(2))
    vmin = v1;
    vmax = v2;
else
    vmin = v2;
    vmax = v1;
end

imRes = imagen;

if(v1(2)==v2(2)) %Recta vertical
    for i=rangoI(1):rangoI(2)
        imRes(i,v1(2)) = intensidad;
    end  
else %Recta no vertical
    for j=vmin(2):vmax(2)
        ireal = (((vmax(1)-vmin(1))/(vmax(2)-vmin(2)))*(j-vmin(2))) + vmin(1);
        imRes(round(ireal),j) = intensidad;
    end  
end
    

