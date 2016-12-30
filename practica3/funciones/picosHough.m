function picos=picosHough(matrizH,umbral,Nmax)
%Devuelve una lista de coordenadas (rho,theta) con los picos encontrados

m = size(matrizH,1);
hVec = matrizH(:);
[mOrd,ind] = sort(hVec,'descend'); %Para que si limita Nmax, devuelva los mejores
z = ind(1:min(Nmax,length(ind)));
z = z(hVec(z)>umbral);

%z = find(matrizH>umbral,Nmax);
y=ceil(z/m);
x=z-(y-1)*m;

picos = [x y];

