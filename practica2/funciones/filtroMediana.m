function res = filtroMediana(imagen,n)
%Solo para n impar, porque no necesito otros, por ahora.
%Para n par, habría que revisar lo de floor(n/2)

[M,N] = size(imagen);
temp = zeros(M,N);

for i=1:M
    for j=1:N
        ibajo = max(1,i-floor(n/2));
        ialto = min(M,i+floor(n/2));
        jbajo = max(1,j-floor(n/2));
        jalto = min(N,j+floor(n/2));
        submat = imagen(ibajo:ialto,jbajo:jalto);
        temp(i,j) = median(reshape(submat,1,[]));
    end
end

res = temp;
