function c = correlacion2d(im1,im2)
%c va a tener el tamaño de im1

M = length(im1(:,1));
N = length(im1(1,:));

m2 = length(im2(:,1));
n2 = length(im2(1,:));

medioBajo = [floor(m2/2) floor(n2/2)];
%medioAlto = [ceil(m2/2) ceil(n2/2)];
if(mod(m2,2)~=0)
    medioBajo(1) = medioBajo(1)-1;
end
if(mod(n2,2)~=0)
    medioBajo(2) = medioBajo(2)-1;
end

imtemp = zeros(M+m2,N+n2);

imtemp(medioBajo(1)+1:medioBajo(1)+M,medioBajo(2)+1:medioBajo(2)+N) = im1;

%im2d = flipud(fliplr(double(im2)));
im2d = double(im2);

c = zeros(M,N);
for i=1:M
    for j=1:N
        c(i,j) = sum(sum( imtemp(i:i+m2-1,j:j+n2-1) .* im2d )) / (sum(sum(imtemp(i:i+m2-1,j:j+n2-1).^2)));
    end
end

