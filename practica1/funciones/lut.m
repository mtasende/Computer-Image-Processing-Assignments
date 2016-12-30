function [p1,p2,n]=lut(v)

%v es un vector de 4 componentes indicando un valor 0 o 1 para cada uno de
%los vértices del cuadrado, tomados en sentido horario, empezando desde el
%de arriba a la izquierda

%Esta es la Look Up Table. No tiene inteligencia. Para diferenciar casos
%ambiguos hay que hacerlo por afuera. Trabaja con valores 0 y 1.

ind = v * [8 4 2 1]'; %Paso de binario a decimal

% n representa la cantidad de bordes que hay en la celda (columna 9). Puede ser 0, 1,
% 2. p1 y p2 son los vértices del primer borde. Únicamente si n=2 es que 
% tienen sentido p3 y p4 (vértices del segundo borde).
% Los valores "ant" y "pos" identifican la arista del cuadrado en que se
% encuentra p1, p2, p3 o p4 (son las coordenadas (i,j) de los vértices de 
% ese cuadrado que son extremos del segmento donde se encuentra pi)

% tabla = [i_p1_ant j_p1_ant i_p1_pos j_p1_pos i_p2_ant j_p2_ant i_p2_pos j_p2_pos
% n i_p3_ant j_p3_ant i_p3_pos j_p3_pos i_p4_ant j_p4_ant i_p4_pos
% j_p4_pos]

tabla = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 1 0 1 1 1 1 0 0 0 0 0 0 0 0;
         1 0 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0;
         0 0 0 1 1 0 1 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 1 2 1 0 1 1 1 1 0 1; %ambiguo
         0 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 0;
         0 0 1 0 1 0 1 1 2 0 0 0 1 0 1 1 1; %ambiguo
         0 0 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0;
         0 0 0 1 1 0 1 1 1 0 0 0 0 0 0 0 0;
         1 0 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0;
         0 0 0 1 0 1 1 1 1 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    ];

    p1(1,:) = tabla(ind+1,1:4);
    p2(1,:) = tabla(ind+1,5:8);
    n = tabla(ind+1,9);
    
    if(n==2)
        p1(2,:) = tabla(ind+1,10:13);
        p2(2,:) = tabla(ind+1,14:17);
    end

