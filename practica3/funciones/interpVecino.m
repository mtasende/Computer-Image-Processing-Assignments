function yr=interpVecino(I,x)
%Se le pasa una x en coordenadas homogeneas y devuelve la yr=I(x) que interpola,
%según la imagen I, con el vecino más cercano

yr = I(round(x(2)),round(x(1)));


