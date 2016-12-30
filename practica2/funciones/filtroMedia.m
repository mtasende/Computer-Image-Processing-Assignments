function res = filtroMedia(imagen,n)

f = ones(n,n)/(n*n);

res = conv2(imagen,f,'same');
