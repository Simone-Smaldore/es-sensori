% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%  Individuazione punto di riferimento per la mano
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


L = bwlabel(bw2);

%Regionprops individua le superfici chiuse
area = regionprops(L, 'Area');

sizea = size(area);
sizeL = size(L);

%Elimina le superfici chiuse inferiori ai 200 pixel 
for i = 1 : sizea(1)
    [X,Y]= find(L ==i);
    sizeX = size(X);
    if(sizeX(1)<5000)
        for j = 1:sizeX(1)
            L(X(j),Y(j))=0;
        end
    else
        if(and(numel(X(X(:,1)==1))==0,numel(X(X(:,1)==sizeL(1)))==0)&& and(numel(Y(Y(:,1)==1))==0,numel(Y(Y(:,1)==sizeL(2)))==0))
            for j = 1:sizeX(1)
                L(X(j),Y(j))=0;
            end
        end    
    end
end

[B,L1,N,A] = bwboundaries(L); 
bordi = B{1};


%Calcola il punto di riferimento al centro del polso
partenza = round(median(bordi(or(bordi(:,1)==1,bordi(:,2)==sizeL(2))|or(bordi(:,2)==1,bordi(:,1)==sizeL(1)),: )));
indicePartenza = find(bordi(:,1) == partenza(:,1)& bordi(:,2) == partenza(:,2) );

distanzaEuclidea = round(sqrt((bordi(:,2)-partenza(2)).^2+(bordi(:,1)-partenza(1)).^2)); 
lunghezzaMano = max(distanzaEuclidea);
distanzeNormalizzate = distanzaEuclidea/max(distanzaEuclidea);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&
%%          Plotto bordi e distanze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Visualizza il centro del polso nell'immagine binarizzata
%figure,imshow(bw2)
%title('Binarizzata con punto di riferimento');
%hold on
%plot(partenza(:,2),partenza(:,1),'ok')

%Grafica gli indici delle distanze
%figure,
%plot(distanzaEuclidea)
%hold on
%plot(indicePartenza,distanzaEuclidea(indicePartenza),'or') %% plotta il punto di partenza 
%title('Distanze Euclidee')
%xlabel('Indice delle distanze')
%ylabel('Distanze')

%figure,
%plot(distanzeNormalizzate)
%hold on
%plot(indicePartenza,distanzeNormalizzate(indicePartenza),'or') %% plotta il punto di partenza 
%title('Distanze Normalizzate')
%xlabel('Indice delle distanze')
%ylabel('Distanze')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Shift delle distanze a partire dal punto di partenza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
indiceC = 1;

for i = indicePartenza : length(distanzeNormalizzate)
    distanzeShift(indiceC,1) = distanzeNormalizzate(i,1);
    indiceC = indiceC +1;
  
end
 for j = 1 : indicePartenza-1
        distanzeShift(indiceC,1) = distanzeNormalizzate(j,1);
        indiceC = indiceC +1;
 end

%figure,plot(distanzeShift)
%title('Shift Distanze')
%xlabel('Indice delle distanze')
%ylabel('Distanze')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Eliminazione distanze superfle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distanzeShift(distanzeShift<0.3) = [];

%figure,plot(distanzeShift)
%title('Distanze Utili')
%xlabel('Indice delle distanze')
%ylabel('Distanze')


distanzeSmooth = smooth(distanzeShift,30);
%figure,plot(distanzeSmooth)
%title('Smooth Distanze')
%xlabel('Indice delle distanze')
%ylabel('Distanze')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Creazione di un terzo vettore colonna che tiene traccia della distanza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VettoreBordo = bordi;
VettorePartenza = find(bordi(:,1) == partenza(:,1)& bordi(:,2) == partenza(:,2) );
VettoreBordo(:,3) = distanzaEuclidea;
VettoreBordo(:,4) = distanzeNormalizzate;

VettoreIndice = VettoreBordo;
VettoreIndice(:,3)= [];

indiceVettore = 1;

for i = VettorePartenza  : length(VettoreIndice)
    VettoreShift(indiceVettore,1) = VettoreIndice(i,1);
    VettoreShift(indiceVettore,2) = VettoreIndice(i,2);
    VettoreShift(indiceVettore,3) = VettoreIndice(i,3);
    indiceVettore = indiceVettore +1;
  
end
 for j = 1 : VettorePartenza -1
    VettoreShift(indiceVettore,1) = VettoreIndice(j,1);
    VettoreShift(indiceVettore,2) = VettoreIndice(j,2);
    VettoreShift(indiceVettore,3) = VettoreIndice(j,3);
    indiceVettore = indiceVettore +1;
 end

VettoreLungPalm = VettoreShift;
 
indiceVLP = 1;

for i = 1 : length( VettoreShift)
    if( VettoreShift(i,3) < 0.3) 
       VettoreELungPalm(indiceVLP,:) = VettoreShift(i,:);
       indiceVLP = indiceVLP +1;
    end
end


indice = 1;

for i = 1 : length( VettoreShift)
    if( VettoreShift(i,3) > 0.3) 
      VettoreElimina(indice,:) = VettoreShift(i,:);
       indice = indice +1;
    end
end

while(length(distanzeSmooth) > length(VettoreElimina))
   distanzeSmooth(end,:) = []; 
       
end

VettoreElimina(:,4) = distanzeSmooth;
VettoreElimina(:,3) = []; 