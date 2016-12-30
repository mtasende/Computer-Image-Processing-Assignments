function imResultado=obtenerPiel(imagen,datosBase,umbral)
%Esta funcion devuelve una imagen rgb con los puntos que estan a menos de
%la distancia de Mahalanobis umbral, respecto de los datosBase.

%rBase = reshape(datosBase(:,:,1),[],1);
%gBase = reshape(datosBase(:,:,2),[],1);
%bBase = reshape(datosBase(:,:,3),[],1);
%vecBase = [rBase gBase bBase];
vecBase = datosBase; %Se pasan como matriz de 3 columnas

[m n] = size(imagen(:,:,1));
r = reshape(imagen(:,:,1),[],1);
g = reshape(imagen(:,:,2),[],1);
b = reshape(imagen(:,:,3),[],1);
vec = [r g b];

dist = mahal(vec,vecBase);
piel = dist<umbral;

rRes = r.*piel;
gRes = g.*piel;
bRes = b.*piel;

imResultado(:,:,1) = reshape(rRes,m,n);
imResultado(:,:,2) = reshape(gRes,m,n);
imResultado(:,:,3) = reshape(bRes,m,n);

