function imaRes=contorno(imagen,K)

[M N] = size(imagen);

imaRes = zeros(M,N);

for i=1:M %Puntos de entrada
    temp = find(imagen(i,:),K,'first');
    if(length(temp)>0)
        jIzq = temp;
        imaRes(i,jIzq) = imagen(i,jIzq);
    end
    temp = find(imagen(i,:),K,'last');
    if(length(temp)>0)
        jDer = temp;
        imaRes(i,jDer) = imagen(i,jDer);
    end
end

for j=1:N %Puntos de entrada
    temp = find(imagen(:,j),K,'first');
    if(length(temp)>0)
        iArriba = temp;
        imaRes(iArriba,j) = imagen(iArriba,j);
    end
    temp = find(imagen(:,j),K,'last');
    if(length(temp)>0)
        iAbajo = temp;
        imaRes(iAbajo,j) = imagen(iAbajo,j);
    end
end
