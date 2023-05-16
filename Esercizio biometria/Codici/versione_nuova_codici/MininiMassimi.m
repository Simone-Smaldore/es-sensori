%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Ricerca Minimi locali per la ROI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% funzione diff per derivata approssimata%%%%%%%%%%%%%%%
VettoreDifferenze = diff(distanzeSmooth); 

indice = 1;

for i = 1 : length(VettoreDifferenze)
    if(VettoreDifferenze(i,1) >0 && VettoreDifferenze(i+1)<=0)
        
        LL(indice,1) = VettoreDifferenze(i+1,1);
        indiciLL(indice,1) = i+1;
        indice = indice +1;
    end
end

IndiceMin = 1; % ricerca parte dal primo massimo in poi
for i = indiciLL(1)+1 : length(VettoreDifferenze)-1 % ho messo + 1 indicill(1)
    if(VettoreDifferenze(i,1) <=0 && VettoreDifferenze(i+1)>0)
        
        provaMin(IndiceMin,1) = VettoreDifferenze(i,1);
        iMin(IndiceMin,1) = i;
        IndiceMin = IndiceMin +1;
    end
end
  
if(length(indiciLL)> 5)
        indiciLL(1)= []; % messo If in quanto si trovano due massimi nel pollice
end

%Genera il grafico delle distanze indicando i punti di minimo e massimo
%figure,plot(distanzeSmooth)
%hold on
for i = 1:length(iMin)
    XX1 = iMin(:,1);
    YY1 = distanzeSmooth(iMin);
   % plot(XX1,YY1,'oy');
end
%hold on
for i = 1:length(indiciLL)
    XXX = indiciLL(:,1);
    YYY = distanzeSmooth(indiciLL);
    %plot(XXX,YYY,'or');
end
%title('Minimi e massimi della Mano')
%xlabel('Indice delle distanze')
%ylabel('Distanze')

%Genera il grafico della mano indicando i punti di minimo e massimo
%figure,imshow(aa)  %%%% di default L
%hold on 
for i = 1:length(iMin)
    psa = VettoreElimina(iMin,2);
    rsa = VettoreElimina(iMin,1);
    %plot(psa,rsa,'oy');
end
%hold on
for i = 1:length(indiciLL)
    psa = VettoreElimina(indiciLL,2);
    rsa = VettoreElimina(indiciLL,1);
   % plot(psa,rsa,'or');
end
%title('Minimi e massimi della Mano')