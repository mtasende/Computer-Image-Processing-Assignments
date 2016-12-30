function err=psnr(x,z,E)

err = 10*log10(((E-1)^2)/rmse(x,z));

