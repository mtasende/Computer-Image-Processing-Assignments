function res = salYPimienta(imagen,p)

[M,N] = size(imagen);

aleat = rand(M,N);
res = imagen;
res(aleat<p/2) = 0;
res(aleat>(1-(p/2))) = 255;

