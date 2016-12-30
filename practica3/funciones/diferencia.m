function dif = diferencia(imagen,template)
%Se asumen imagenes de 1s sobre fondo '0'
%dif es la minima diferencia de sumas de valores absolutos al recorrer toda
%la imagen con el template

[M N] = size(imagen);
[m n] = size(template);

imaGrande = zeros(M+m,N+n);
imaGrande(m+1:end,n+1:end) = imagen;

dTemp = m*n; %La peor diferencia que puede haber (el template negado)
k = 1;
for i=M
    for j=1:N
        %keyboard
        d(k) = sum(sum(abs(imaGrande(i+1:m+i,j+1:n+j)-template)));
        if(d(k)<dTemp)
            dTemp=d(k);
        end
        k = k+1;
    end
end


Nunos = sum(sum(template~=0));%Esto lo hago para que no haya "templates privilegiados" al hacer la diferencia con ceros.
%figure
%plot(1:length(d),d/(n*m))

dif = dTemp/Nunos;
        
        

