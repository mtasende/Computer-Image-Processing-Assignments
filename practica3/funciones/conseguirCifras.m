function conseguirCifras(nombreImagen)
clc
close all

imagen = imread(nombreImagen);

figure(1)
imshow(imagen)
for i=1:8
    figure(1)
    V = ginput(2);
    c = imagen(:,round(V(1,1)):round(V(2,1)));
    
    figure(2)
    subplot(2,4,i)
    imshow(c)
    
    nombreCifra = input('Nombre de archivo de esta cifra:    ')
    imwrite(c,[nombreCifra '.bmp'],'BMP') %ESTO SE PUEDE
end

