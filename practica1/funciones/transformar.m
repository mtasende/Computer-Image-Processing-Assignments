function J=transformar(I,MatrizTransformacion,TipoInterpolacion,entera)

M = length(I(:,1));
N = length(I(1,:));
H = MatrizTransformacion;

%La x corresponde a j, la y corresponde a i (invertida)

%Veo cuáles son los extremos del plano transformado
if(strcmp('si',entera))
    v11 = H*[1,1,1]';
    v12 = H*[N,1,1]';
    v21 = H*[1,M,1]';
    v22 = H*[N,M,1]';
    imin = floor(min([v11(2)/v11(3) v12(2)/v12(3) v21(2)/v21(3) v22(2)/v22(3)]));
    imax = ceil(max([v11(2)/v11(3) v12(2)/v12(3) v21(2)/v21(3) v22(2)/v22(3)]));
    jmin = floor(min([v11(1)/v11(3) v12(1)/v12(3) v21(1)/v21(3) v22(1)/v22(3)]));
    jmax = ceil(max([v11(1)/v11(3) v12(1)/v12(3) v21(1)/v21(3) v22(1)/v22(3)]));
else
    imin = 1;
    imax = M;
    jmin = 1;
    jmax = N;
end

J = 255*ones(imax-imin+1,jmax-jmin+1);
%J = zeros(imax-imin+1,jmax-jmin+1);

for i=imin:imax
    for j=jmin:jmax
        xp = [j,i,1]'; %punto transformado
        x = H\xp; %preimagen
        x = x/x(3);
        if(x(2)<=M && x(2)>=1 && x(1)<=N && x(1)>=1) %Verifico que la preimagen estuviera en el rango original
        switch TipoInterpolacion
            case 'vecino'
                J(i-imin+1,j-jmin+1) = interpVecino(I,x);
            case 'bilineal'
                J(i-imin+1,j-jmin+1) = interpBilineal(I,x);
            case 'bicubica'
                J(i-imin+1,j-jmin+1) = interpBicubica(I,x);
        end
        end
    end
end




