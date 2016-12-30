function yr=interpBicubica(I,x)
%Se le pasa una x en coordenadas homogeneas y devuelve la yr=I(x) que interpola,
%según la imagen I, con interpolación bicubica

M = length(I(:,1));
N = length(I(1,:));

a = -0.5;

%Identifico los cuatro puntos involucrados de la imagen
v11 = [floor(x(2)) floor(x(1))];
v12 = [floor(x(2)) ceil(x(1))];
v21 = [ceil(x(2)) floor(x(1))];
v22 = [ceil(x(2)) ceil(x(1))];

V = [v11;
    v12;
    v21;
    v22;
    [v11(1)-1,v11(2)];
    [v11(1),v11(2)-1];
    [v11(1)-1,v11(2)-1];
    [v12(1)-1,v12(2)];
    [v12(1),v12(2)+1];
    [v12(1)-1,v12(2)+1];
    [v21(1),v21(2)-1];
    [v21(1)+1,v21(2)];
    [v21(1)+1,v21(2)-1];
    [v22(1),v22(2)+1];
    [v22(1)+1,v22(2)];
    [v22(1)+1,v22(2)+1]
    ];


i = x(2);
j = x(1);


ytemp = zeros(1,length(V(:,1)));
for l=1:4
    ytemp(l) = I(V(l,1),V(l,2))*(1 - (a+3)*(i-V(l,1))^2 + (a+2)*(abs(i-V(l,1)))^3 ) * (1 - (a+3)*(j-V(l,2))^2 + (a+2)*(abs(j-V(l,2)))^3 );
end
for l=5:length(V(:,1))
    if(V(l,1)>=1 && V(l,1)<=M && V(l,2)>=1 && V(l,2)<=N) %Ahora aunque ingrese puntos dentro de la imagen, pueden haber involucrados afuera...
        ytemp(l) = I(V(l,1),V(l,2)) * (-4*a + 8*a*abs(i-V(l,1)) - 5*a*(i-V(l,1))^2 + a*(abs(i-V(l,1)))^3 ) * (-4*a + 8*a*abs(j-V(l,2)) - 5*a*(j-V(l,2))^2 + a*(abs(j-V(l,2)))^3 );
    else
        ytemp(l) = 255 * (-4*a + 8*a*abs(i-V(l,1)) - 5*a*(i-V(l,1))^2 + a*(abs(i-V(l,1)))^3 ) * (-4*a + 8*a*abs(j-V(l,2)) - 5*a*(j-V(l,2))^2 + a*(abs(j-V(l,2)))^3 );
    end
end

yr = sum(ytemp);
