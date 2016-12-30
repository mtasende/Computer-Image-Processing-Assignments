function err=mse(x,z)

[M N] = size(x);

err = (1/(M*N-1)) * sum(sum((z-x).^2));
