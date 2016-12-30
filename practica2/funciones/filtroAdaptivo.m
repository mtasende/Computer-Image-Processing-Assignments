function res = filtroAdaptivo(imagen,n,sigma2N)
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
        subvec = reshape(submat,1,[]);
        
        mu = mean(subvec);
        m = length(subvec);
        sigma2 = sum(((subvec-mu).^2))/m;
        temp(i,j) = mu + ((sigma2-sigma2N)/sigma2)*(imagen(i,j)-mu);
    end
end

res = temp;
