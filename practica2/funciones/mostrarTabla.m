function mostrarTabla(c)

[M N]=size(c);

%Hago que todas las etiquetas tengan el mismo largo
largoH = 0;
for i=1:length(c(1,:))
    if(length(c{1,i})>largoH)
        largoH = length(c{1,i});
    end
end
for i=1:length(c(1,:))
    temp = repmat(' ',1,largoH);
    temp(1:length(c{1,i})) = c{1,i};
    c{1,i} = temp;
end

largoV = 0;
for i=1:length(c(:,1))
    if(length(c{i,1})>largoV)
        largoV = length(c{i,1});
    end
end
for i=1:length(c(:,1))
    temp = repmat(' ',1,largoH);
    temp(1:length(c{i,1})) = c{i,1};
    c{i,1} = temp;
end
%----------------------------------------------------------------------

for i=1:M
    temp = '';
    for j=1:N
        if(i>=2 && j>=2)
            agregar = num2str(c{i,j});
            celda = repmat(' ',1,largoH);
            celda(1:length(agregar)) = agregar;
            
            temp = [temp celda sprintf(' ')];
        else
            temp = [temp c{i,j} sprintf(' ')];
        end
    end
    disp(temp);
end