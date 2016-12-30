function imRes = matchearConv(imagen,patron,umbralPU,alargue)

tic
res = correlacion2d(imagen,patron);
toc

umbral = max(max(res))*umbralPU;

imRes = zeros(length(imagen(:,1)),length(imagen(1,:)));
for i=1:length(imagen(:,1))
    for j=1:length(imagen(1,:))
        if(real(res(i,j)) >=umbral)
            iniI = max(i - round(length(patron(:,1))/2),1);
            finI = min(i + round(length(patron(:,1))/2),length(imRes(:,1)));
            iniJ = max(j - alargue*round(length(patron(1,:))/2),1);
            finJ = min(j + alargue*round(length(patron(1,:))/2),length(imRes(1,:)));
            
            imRes(iniI:finI,iniJ:finJ) = double(imagen(iniI:finI,iniJ:finJ));
        end
    end
end

