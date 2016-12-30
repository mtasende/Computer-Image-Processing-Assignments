function imRes=centrarImagen(lienzo,imagen)

[M N] = size(lienzo);
[m n] = size(imagen);

imRes = lienzo;

if (m>M) || (n>N)
    disp('Error. La imagen tiene que ser menor que el lienzo.')
    return
end

verticeSI = [floor((M-m)/2) floor((N-n)/2)];

imRes(verticeSI(1)+1:verticeSI(1)+m,verticeSI(2)+1:verticeSI(2)+n) = imagen;

