function cn = marchSquares(imagen,nivel,divGrilla)

M = length(imagen(:,1));
N = length(imagen(1,:));

imagenBin = imagen<=nivel;

ctemp = 255*ones(M*divGrilla,N*divGrilla);


for i = 1:M-1
    for j = 1:N-1
        v = [imagenBin(i,j) imagenBin(i+1,j) imagenBin(i+1,j+1) imagenBin(i,j+1)];
        [p1,p2,n]=lut(v);
%         %Version sin interpolación para ver...
%         if(n>0)
%             vert1 = [i j] + [(p1(1,1)+p1(1,3))/2 (p1(1,2)+p1(1,4))/2];
%             vert1 = round(vert1*divGrilla);
%             vert2 = [i j] + [(p2(1,1)+p2(1,3))/2 (p2(1,2)+p2(1,4))/2];
%             vert2 = round(vert2*divGrilla);
%             ctemp = dibujarRecta(ctemp,vert1,vert2,nivel);
%             if(n>1)
%                 vert3 = [i j] + [(p1(2,1)+p1(2,3))/2 (p1(2,2)+p1(2,4))/2];
%                 vert3 = ceil(vert3*divGrilla);
%                 vert4 = [i j] + [(p2(2,1)+p2(2,3))/2 (p2(2,2)+p2(2,4))/2];
%                 vert4 = ceil(vert4*divGrilla);
%                 ctemp = dibujarRecta(ctemp,vert3,vert4,nivel);    
%             end
%         end

        
        %Ahora interpolo para hallar los vertices del(de los) borde(s)
        if(n==1)
            %vert1 = [i j] + [(p1(1,1)+p1(1,3))/2 (p1(1,2)+p1(1,4))/2];
            vert1 = [i j] + interpPreLin(nivel,p1(1:2),p1(3:4),imagen(i+p1(1),j+p1(2)),imagen(i+p1(3),j+p1(4)));
            vert1 = round(vert1*divGrilla);
            %vert2 = [i j] + [(p2(1,1)+p2(1,3))/2 (p2(1,2)+p2(1,4))/2];
            vert2 = [i j] + interpPreLin(nivel,p2(1:2),p2(3:4),imagen(i+p2(1),j+p2(2)),imagen(i+p2(3),j+p2(4)));
            vert2 = round(vert2*divGrilla);
            ctemp = dibujarRecta(ctemp,vert1,vert2,nivel);
        else
            if(n==2) %Caso ambiguo con dos rectas
                %Primero determino que caso es
                promedio = mean([imagen(i,j) imagen(i+1,j) imagen(i,j+1) imagen(i+1,j+1)]);
                ind = v * [8 4 2 1]';
                if(ind==5)
                    if(promedio>=nivel)
                        [p1,p2,n]=lut([1 0 1 0]);
                    end
                else
                    if(promedio>=nivel)
                        [p1,p2,n]=lut([0 1 0 1]);
                    end 
                end
                
                
                %vert1 = [i j] + [(p1(1,1)+p1(1,3))/2 (p1(1,2)+p1(1,4))/2];
                vert1 = [i j] + interpPreLin(nivel,p1(1,1:2),p1(1,3:4),imagen(i+p1(1,1),j+p1(1,2)),imagen(i+p1(1,3),j+p1(1,4)));
                vert1 = round(vert1*divGrilla);
                %vert2 = [i j] + [(p2(1,1)+p2(1,3))/2 (p2(1,2)+p2(1,4))/2];
                vert2 = [i j] + interpPreLin(nivel,p2(1,1:2),p2(1,3:4),imagen(i+p2(1,1),j+p2(1,2)),imagen(i+p2(1,3),j+p2(1,4)));
                vert2 = round(vert2*divGrilla);
                ctemp = dibujarRecta(ctemp,vert1,vert2,nivel);
    
                %vert3 = [i j] + [(p1(2,1)+p1(2,3))/2 (p1(2,2)+p1(2,4))/2];
                vert3 = [i j] + interpPreLin(nivel,p1(2,1:2),p1(2,3:4),imagen(i+p1(2,1),j+p1(2,2)),imagen(i+p1(2,3),j+p1(2,4)));
                vert3 = ceil(vert3*divGrilla);
                %vert4 = [i j] + [(p2(2,1)+p2(2,3))/2 (p2(2,2)+p2(2,4))/2];
                vert4 = [i j] + interpPreLin(nivel,p2(2,1:2),p2(2,3:4),imagen(i+p2(2,1),j+p2(2,2)),imagen(i+p2(2,3),j+p2(2,4)));
                vert4 = ceil(vert4*divGrilla);
                ctemp = dibujarRecta(ctemp,vert3,vert4,nivel);
            end
         end
    end
    disp(['Procesando: ' num2str(100*(i)/(M-1)) '%'])
end

cn = ctemp;

