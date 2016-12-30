function imRes=subMuestreo(imagen,n)

M = length(imagen(:,1));
N = length(imagen(1,:));

Msub = floor(M/n);
Nsub = floor(N/n);

imRes = zeros(Msub,Nsub);
imRes = im2uint8(imRes);

for i=1:Msub
    for j=1:Nsub
        imRes(i,j) = imagen(1+(i-1)*n,1+(j-1)*n);
    end
end

