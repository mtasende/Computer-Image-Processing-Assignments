function imRes = matchear(imagen,patron,umbralPU,alargue)

tic
patronG = 255*ones(length(imagen(:,1)),length(imagen(1,:)));
patronG(1:length(patron(:,1)),1:length(patron(1,:))) = patron;
res = ifft2( conj(fft2(double(patronG)))  .* fft2(double(imagen)));
toc

umbral = max(max(res))*umbralPU;

imRes = zeros(length(imagen(:,1)),length(imagen(1,:)));
for i=1:length(imagen(:,1))
    for j=1:length(imagen(1,:))
        if(real(res(i,j)) >=umbral)
            finI = i+length(patron(:,1));
            finJ = j+alargue*length(patron(:,1));
            if(finI > length(imRes(:,1)))
                finI = length(imRes(:,1));
            end
            if(finJ > length(imRes(1,:)))
                finJ = length(imRes(1,:));
            end
            imRes(i:finI,j:finJ) = double(imagen(i:finI,j:finJ));
        end
    end
end


