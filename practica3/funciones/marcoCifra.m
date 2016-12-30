function [centro,cifraMarco] = marcoCifra(imagen)
%Se asume que la imagen tiene ceros y unos
%Se busca el centro de los unos y se toma un marco de 15 pixels para cada
%lado en la horizontal y el rango total en la vertical

delta = 15;

[M N] = size(imagen);

acum = 0;
Npart = 0;
for i=1:N
    acum = acum + sum(imagen(:,i))*i;
    Npart = Npart + sum(imagen(:,i));
end

if(Npart == 0 || acum==0)
    centro = round(N/2);
else
    centro = round(acum/(Npart)); %Si es cero que de un buen error (no deberia ser)
end
imaGrande = zeros(M,N+2*delta+2); %Le agrego uno a cada lado por el "round" que hice
imaGrande(:,delta+1:N+delta) = imagen;

cifraMarco = imaGrande(:,centro:centro+2*delta);