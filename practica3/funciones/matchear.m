function res = matchear(imagen,patron)

patronG = zeros(length(imagen(:,1)),length(imagen(1,:)));
patronG(1:length(patron(:,1)),1:length(patron(1,:))) = patron;
res = max(max(ifft2( conj(fft2(double(patronG)))  .* fft2(double(imagen)))));


