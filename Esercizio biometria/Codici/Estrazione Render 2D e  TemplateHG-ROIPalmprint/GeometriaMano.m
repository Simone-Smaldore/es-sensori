j%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Geometria Mano 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%In questa function vengono individuati tutti i punti noti (massimi, valli, medi) relativi
%alla mano, e tutte le 26 caratteristiche che vengono utilizzate in fase di matching 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Individuare Secondo Minimo Pollice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%% coordinate x e y punto di Massimo dito Pollice dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del quinto massimo trovato

XmassimoPollice  = VettoreElimina(indiciLL(1),2);
YmassimoPollice = VettoreElimina(indiciLL(1),1);

%%% coordinate x e y del Secondo punto valle Pollice dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del primo minimo trovato

XsecondoPollice = VettoreElimina(iMin(1),2);
YsecondoPollice = VettoreElimina(iMin(1),1);


indiceValP = 1;
for i = 1  : indiciLL(1)-1
        provaValP(indiceValP,1) = distanzeSmooth(i,1);
        indiceValP = indiceValP +1;
end


%% con find
distanza10Pollice = VettoreElimina(iMin(1),3) * 0.17364817;  % 5 gradi più sotto
PrimoMinimoPollice1 = find(provaValP - distanzeSmooth(iMin(1),1)> - distanza10Pollice);
PrimoMinimoPollice = (PrimoMinimoPollice1(1,1)); % indice del primo minimo del pollice

%%% coordinate x e y del Secondo punto valle Pollice
XprimoPollice = VettoreElimina(PrimoMinimoPollice(1),2);
YprimoPollice = VettoreElimina(PrimoMinimoPollice(1),1);

%%% Calcolo del punto medio del dito Pollice
XMedioPollice = (XprimoPollice + XsecondoPollice)/2;
YMedioPollice = (YprimoPollice + YsecondoPollice)/2;

%%% Calcolo lunghezza Dito Pollice
LunghezzaDitoPollice = round(sqrt((XmassimoPollice-XMedioPollice).^2+(YmassimoPollice-YMedioPollice).^2)); 


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %           Individuare Secondo Minimo Indice
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% coordinate x e y punto di Massimo dito Indice dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del quarto massimo trovato

XmassimoIndice  = VettoreElimina(indiciLL(2),2);
YmassimoIndice = VettoreElimina(indiciLL(2),1);

%%% coordinate x e y Secondo punto valle Indice dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del secondo minimo trovato
 
XsecondoIndice = VettoreElimina(iMin(2),2);
YsecondoIndice = VettoreElimina(iMin(2),1);


indiceVal = 1;
for i = iMin(1)+1 : indiciLL(2)-1
        provaVal(indiceVal,1) = distanzeSmooth(i,1);
        indiceVal = indiceVal +1;
end


%% con find
distanza3Indice = VettoreElimina(iMin(2),3) * 0.0523359;  % 5 gradi più sotto

PrimoMinimoIndice1 = find(provaVal - distanzeSmooth(iMin(2),1)> - distanza3Indice);

PrimoMinimoIndice = (PrimoMinimoIndice1(1,1))+ iMin(1); % indice del secondo minimo dell'indice

%%% coordinate x e y del Primo punto valle Indice

XprimoIndice = VettoreElimina(PrimoMinimoIndice,2);
YprimoIndice = VettoreElimina(PrimoMinimoIndice,1);

%%% Calcolo del punto medio del Dito Indice

XMedioIndice = (XprimoIndice + XsecondoIndice)/2;
YMedioIndice = (YprimoIndice + YsecondoIndice)/2;

%%% Calcolo lunghezza Dito Indice

LunghezzaDitoIndice = round(sqrt((XmassimoIndice-XMedioIndice).^2+(YmassimoIndice-YMedioIndice).^2)); 

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %           Lunghezza Dito Medio
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% coordinate x e y dei punti valle( minimi dito Medio)dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del secondo e terzo minimo trovati del dito Medio

XprimoMedio = VettoreElimina(iMin(2),2);
YprimoMedio = VettoreElimina(iMin(2),1);
XsecondoMedio = VettoreElimina(iMin(3),2);
YsecondoMedio = VettoreElimina(iMin(3),1);

%%% coordinate x e y punto di Massimo dito Medio dato dalle cordinate presenti nel
%%% vettoreElimina dall'indice delle distanze del terzo massimo trovato

XmassimoMedio  = VettoreElimina(indiciLL(3),2);
YmassimoMedio = VettoreElimina(indiciLL(3),1);

%%% Calcolo del punto medio del Dito Medio

XpuntoMedio = (XprimoMedio + XsecondoMedio)/2;
YpuntoMedio = (YprimoMedio + YsecondoMedio)/2;

%%% Calcolo lunghezza Dito Medio

LunghezzaDitoMedio = round(sqrt((XmassimoMedio-XpuntoMedio).^2+(YmassimoMedio-YpuntoMedio).^2)); 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %           Lunghezza Dito Anulare
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%% coordinate x e y dei punti valle( minimi dell'anulare)dato dalle cordinate presenti nel
% %%% vettoreElimina dall'indice delle distanze del primo e secondo minimo trovati del dito Anulare

XprimoAnulare = VettoreElimina(iMin(3),2);
YprimoAnulare = VettoreElimina(iMin(3),1);
XsecondoAnulare = VettoreElimina(iMin(4),2);
YsecondoAnulare = VettoreElimina(iMin(4),1);

% %%% coordinate x e y punto di Massimo dito Anulare dato dalle cordinate presenti nel
% %%% vettoreElimina dall'indice delle distanze del secondo massimo trovato

XmassimoAnulare  = VettoreElimina(indiciLL(4),2);
YmassimoAnulare = VettoreElimina(indiciLL(4),1);

%%% Calcolo del punto medio del Dito Anulare

XMedioAnulare = (XprimoAnulare + XsecondoAnulare)/2;
YMedioAnulare = (YprimoAnulare + YsecondoAnulare)/2;

%%% Calcolo lunghezza Dito Anulare

LunghezzaDitoAnulare = round(sqrt((XmassimoAnulare-XMedioAnulare).^2+(YmassimoAnulare-YMedioAnulare).^2)); 


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %           Individuare Primo Minimo Mignolo
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Si ricerca il punto adiacente al secondo minimo a partire dalla punta del
% %mignolo - in questo caso a sinistra

% %%% coordinate x e y punto di Massimo dito Mignolo dato dalle cordinate presenti nel
% %%% vettoreElimina dall'indice delle distanze del primo massimo trovato

XmassimoMignolo  = VettoreElimina(indiciLL(5),2);
YmassimoMignolo = VettoreElimina(indiciLL(5),1);

% %%% coordinate x e y Primo punto valle Mignolo dato dalle cordinate presenti nel
% %%% vettoreElimina dall'indice delle distanze dal quarto minimo trovato

XprimoMignolo = VettoreElimina(iMin(4),2);
YprimoMignolo = VettoreElimina(iMin(4),1);



indiceMi = 1;
for i = indiciLL(5)+1 : length(distanzeSmooth)
        provaMi(indiceMi,1) = distanzeSmooth(i,1);
        indiceMi = indiceMi +1;
end

%%% test con find 

distanza5 = VettoreElimina(iMin(4),3) * 0.087155;  % 5 gradi più sotto

SecondoMinimoMignolo1 = find(provaMi - distanzeSmooth(iMin(4),1)> - distanza5);

SecondoMinimoMignolo = (SecondoMinimoMignolo1(end,1)) + indiciLL(5) ; % indice del primo minimo del mignolo

%%% coordinate x e y del Secondo punto valle Mignolo

XsecondoMignolo = VettoreElimina(SecondoMinimoMignolo,2);
YsecondoMignolo = VettoreElimina(SecondoMinimoMignolo,1);

%%% Calcolo del punto medio del Dito Mignolo

XMedioMignolo = (XprimoMignolo + XsecondoMignolo)/2;
YMedioMignolo = (YprimoMignolo + YsecondoMignolo)/2;

%%% Calcolo lunghezza Dito Mignolo

LunghezzaDitoMignolo = round(sqrt((XmassimoMignolo-XMedioMignolo).^2+(YmassimoMignolo-YMedioMignolo).^2)); 



% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %    Plot dei minimi sulle distanza smooth 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
figure,plot(distanzeSmooth)
 hold on 
 plot(SecondoMinimoMignolo,distanzeSmooth(SecondoMinimoMignolo,1),'og')
 plot(iMin(4),distanzeSmooth(iMin(4),1),'og')
 plot(indiciLL(5),distanzeSmooth(indiciLL(5),1),'or')
 plot(iMin(2),distanzeSmooth(iMin(2),1),'og')
 plot(indiciLL(4),distanzeSmooth(indiciLL(4),1),'or')
 plot(iMin(3),distanzeSmooth(iMin(3),1),'og')
 plot(indiciLL(3),distanzeSmooth(indiciLL(3),1),'or')
 plot(PrimoMinimoIndice,distanzeSmooth(PrimoMinimoIndice,1),'og')
 plot(indiciLL(2),distanzeSmooth(indiciLL(2),1),'or')
 plot(iMin(1),distanzeSmooth(iMin(1),1),'og')
 plot(PrimoMinimoPollice,distanzeSmooth(PrimoMinimoPollice,1),'og')
 plot(indiciLL(1),distanzeSmooth(indiciLL(1),1),'or')
 xlabel('Indice delle distanze')
 ylabel('Distanze')
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Rappresentazione grafica di tutti i minimi  e massimi sulla mano
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
figure,
imshow(~edgeBw2)
hold on
plot(XsecondoAnulare ,YsecondoAnulare,'.y','MarkerSize', 16)
plot(XprimoAnulare ,YprimoAnulare,'.y','MarkerSize', 16)
plot(XmassimoAnulare ,YmassimoAnulare,'.r','MarkerSize', 16)
plot(XsecondoMignolo ,YsecondoMignolo,'.g','MarkerSize', 16)
plot(XprimoMignolo ,YprimoMignolo,'.y','MarkerSize', 16)
plot(XmassimoMignolo ,YmassimoMignolo,'.r','MarkerSize', 16)
plot(XsecondoMedio ,YsecondoMedio,'.y','MarkerSize', 16)
plot(XprimoMedio ,YprimoMedio,'.y','MarkerSize', 16)
plot(XmassimoMedio ,YmassimoMedio,'.r','MarkerSize', 16)
plot(XsecondoIndice ,YsecondoIndice,'.y','MarkerSize', 16)
plot(XprimoIndice,YprimoIndice,'.g','MarkerSize', 16)
plot(XmassimoIndice ,YmassimoIndice,'.r','MarkerSize', 16)
plot(XsecondoPollice ,YsecondoPollice,'.y','MarkerSize', 16)
plot(XprimoPollice,YprimoPollice,'.g','MarkerSize', 16)
plot(XmassimoPollice ,YmassimoPollice,'.r','MarkerSize', 16)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %   Rappresentazione grafica di tutti massimi e punti medi della mano
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


plot(XMedioMignolo ,YMedioMignolo,'.b','MarkerSize', 16)
plot(XMedioAnulare ,YMedioAnulare,'.b','MarkerSize', 16)
plot(XpuntoMedio ,YpuntoMedio,'.b','MarkerSize', 16)
plot(XMedioIndice ,YMedioIndice,'.b','MarkerSize', 16)
plot(XMedioPollice ,YMedioPollice,'.b','MarkerSize', 16)


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%   Rappresentazione grafica lunghezze dita
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
 figure,
 imshow(aa)
 hold on
 A1 = [XmassimoMignolo XMedioMignolo];
 A2 = [YmassimoMignolo YMedioMignolo];
 A3 = [XmassimoAnulare XMedioAnulare];
 A4 = [YmassimoAnulare YMedioAnulare];
 A5 = [XmassimoMedio XpuntoMedio];
 A6 = [YmassimoMedio YpuntoMedio];
 A7 = [XmassimoIndice XMedioIndice];
 A8 = [YmassimoIndice YMedioIndice];
 A9 = [XmassimoPollice XMedioPollice];
 A10 = [YmassimoPollice YMedioPollice];
 plot(A1,A2);
 plot(A3,A4);
 plot(A5,A6);
 plot(A7,A8);
 plot(A9,A10);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % %       Larghezza  Finger 1/3 - 2/3 - larghezza base dito
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % Individuare Width Finger da 1/3 dal Max Mignolo
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzaunoterzoMi = (LunghezzaDitoMignolo * (1/3))/max(distanzaEuclidea);

indiceLaMi = 1;
for i = iMin(4) : indiciLL(5)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(5),1))>= lunghezzaunoterzoMi)
       inlargMi(indiceLaMi,1)= i;
       indiceLaMi = indiceLaMi +1;
    end
end

indiceLaMi2 = 1;
for i = indiciLL(5) : SecondoMinimoMignolo
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(5),1))>= lunghezzaunoterzoMi)
       inlargMi2(indiceLaMi2,1)= i;
       indiceLaMi2 = indiceLaMi2 +1;
    end
end

x13Mi = VettoreElimina(inlargMi(end),2);
y13Mi = VettoreElimina(inlargMi(end),1);

x13Mi2 = VettoreElimina(inlargMi2(1),2);
y13Mi2 = VettoreElimina(inlargMi2(1),1);

Larghezza13Mignolo = round(sqrt((x13Mi-x13Mi2).^2+(y13Mi-y13Mi2).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%% Individuare Width Finger da 2/3 dal Max Mignolo
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzadueterzoMi = (LunghezzaDitoMignolo * (2/3))/max(distanzaEuclidea);

indiceLaMi3 = 1;
for i =  iMin(4) : indiciLL(5)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(5),1))>= lunghezzadueterzoMi)
       inlargMi3(indiceLaMi3,1)= i;
       indiceLaMi3 = indiceLaMi3 +1;
    end
end

indiceLaMi4 = 1;
for i = indiciLL(5) : SecondoMinimoMignolo
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(5),1))>= lunghezzadueterzoMi)
       inlargMi4(indiceLaMi4,1)= i;
       indiceLaMi4 = indiceLaMi4 +1;
    end
end

x23Mi3 = VettoreElimina(inlargMi3(end),2);
y23Mi3 = VettoreElimina(inlargMi3(end),1);

x23Mi4 = VettoreElimina(inlargMi4(1),2);
y23Mi4 = VettoreElimina(inlargMi4(1),1);

Larghezza23Mignolo = round(sqrt((x23Mi3-x23Mi4).^2+(y23Mi3-y23Mi4).^2)); 


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% %%  Width Finger base dito Mignolo
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


Larghezza33Mignolo = round(sqrt((XprimoMignolo-XsecondoMignolo).^2+(YprimoMignolo-YsecondoMignolo).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % %  Individuare Width Finger da 1/3 dal Max Anulare
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzaunoterzoAn = (LunghezzaDitoAnulare * (1/3))/max(distanzaEuclidea);

indiceLaAn = 1;
for i =  iMin(3) : indiciLL(4)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(4),1))>= lunghezzaunoterzoAn)
       inlargAn(indiceLaAn,1)= i;
       indiceLaAn = indiceLaAn +1;
    end
end

indiceLaAn2 = 1;
for i = indiciLL(4) : iMin(4)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(4),1))>= lunghezzaunoterzoAn)
       inlargAn2(indiceLaAn2,1)= i;
       indiceLaAn2 = indiceLaAn2 +1;
    end
end

x13An = VettoreElimina(inlargAn(end),2);
y13An = VettoreElimina(inlargAn(end),1);

x13An2 = VettoreElimina(inlargAn2(1),2);
y13An2 = VettoreElimina(inlargAn2(1),1);

Larghezza13Anulare = round(sqrt((x13An-x13An2).^2+(y13An-y13An2).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % %  Individuare Width Finger da 2/3 dal Max Anulare                    %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzadueterzoAn = (LunghezzaDitoAnulare * (2/3))/max(distanzaEuclidea);

indiceLaAn3 = 1;
for i =  iMin(3) : indiciLL(4)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(4),1))>= lunghezzadueterzoAn)
       inlargAn3(indiceLaAn3,1)= i;
       indiceLaAn3 = indiceLaAn3 +1;
    end
end

indiceLaAn4 = 1;
for i = indiciLL(4) : iMin(4)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(4),1))>= lunghezzadueterzoAn)
       inlargAn4(indiceLaAn4,1)= i;
       indiceLaAn4 = indiceLaAn4 +1;
    end
end

x23An3 = VettoreElimina(inlargAn3(end),2);
y23An3 = VettoreElimina(inlargAn3(end),1);

x23An4 = VettoreElimina(inlargAn4(1),2);
y23An4 = VettoreElimina(inlargAn4(1),1);

Larghezza23Anulare = round(sqrt((x23An3-x23An4).^2+(y23An3-y23An4).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % %% Width Finger base dito Anulare                                  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

Larghezza33Anulare = round(sqrt((XprimoAnulare -XsecondoAnulare).^2+(YprimoAnulare-YsecondoAnulare).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % %%    Individuare Width Finger da 1/3 dal Max Medio
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzaunoterzoMe = (LunghezzaDitoMedio * (1/3))/max(distanzaEuclidea);

indiceLaMe = 1;
for i = iMin(2) : indiciLL(3)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(3),1))>= lunghezzaunoterzoMe)
       inlargMe(indiceLaMe,1)= i;
       indiceLaMe = indiceLaMe +1;
    end
end

indiceLaMe2 = 1;
for i = indiciLL(3) : iMin(3)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(3),1))>= lunghezzaunoterzoMe)
       inlargMe2(indiceLaMe2,1)= i;
       indiceLaMe2 = indiceLaMe2 +1;
    end
end

x13Me = VettoreElimina(inlargMe(end),2);
y13Me = VettoreElimina(inlargMe(end),1);

x13Me2 = VettoreElimina(inlargMe2(1),2);
y13Me2 = VettoreElimina(inlargMe2(1),1);

Larghezza13Medio = round(sqrt((x13Me-x13Me2).^2+(y13Me-y13Me2).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % Individuare Width Finger da 2/3 dal Max Medio
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


lunghezzadueterzoMe = (LunghezzaDitoMedio * (2/3))/max(distanzaEuclidea);

indiceLaMe3 = 1;
for i = iMin(2) : indiciLL(3)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(3),1))>= lunghezzadueterzoMe )
       inlargMe3(indiceLaMe3,1)= i;
       indiceLaMe3 = indiceLaMe3 +1;
    end
end

indiceLaMe4 = 1;
for i = indiciLL(3) : iMin(3)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(3),1))>= lunghezzadueterzoMe )
       inlargMe4(indiceLaMe4,1)= i;
       indiceLaMe4 = indiceLaMe4 +1;
    end
end

x23Me3 = VettoreElimina(inlargMe3(end),2);
y23Me3 = VettoreElimina(inlargMe3(end),1);

x23Me4 = VettoreElimina(inlargMe4(1),2);
y23Me4 = VettoreElimina(inlargMe4(1),1);

Larghezza23Medio = round(sqrt((x23Me3-x23Me4).^2+(y23Me3-y23Me4).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % Width Finger base dito Medio
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


Larghezza33Medio = round(sqrt((XprimoMedio-XsecondoMedio).^2+(YprimoMedio-YsecondoMedio).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %   Individuare Width Finger da 1/3 dal Max Indice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzaunoterzoIn = (LunghezzaDitoIndice * (1/3))/max(distanzaEuclidea);

indiceLaIn = 1;
for i = PrimoMinimoIndice : indiciLL(2)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(2),1))>= lunghezzaunoterzoIn)
       inlargIn(indiceLaIn,1)= i;
       indiceLaIn = indiceLaIn +1;
    end
end

indiceLaIn2 = 1;
for i = indiciLL(2) : iMin(2)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(2),1))>= lunghezzaunoterzoIn)
       inlargIn2(indiceLaIn2,1)= i;
       indiceLaIn2 =indiceLaIn2 +1;
    end
end

x13In = VettoreElimina(inlargIn(end),2);
y13In = VettoreElimina(inlargIn(end),1);

x13In2 = VettoreElimina(inlargIn2(1),2);
y13In2 = VettoreElimina(inlargIn2(1),1);

Larghezza13Indice = round(sqrt((x13In-x13In2).^2+(y13In-y13In2).^2)); 


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %  Individuare Width Finger da 2/3 dal Max Indice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzadueterzoIn = (LunghezzaDitoIndice * (2/3))/max(distanzaEuclidea);
 
indiceLaIn3 = 1;
for i = PrimoMinimoIndice : indiciLL(2)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(2),1))>= lunghezzadueterzoIn)
       inlargIn3(indiceLaIn3,1)= i;
       indiceLaIn3 = indiceLaIn3 +1;
    end
end

indiceLaIn4 = 1;
for i = indiciLL(2) : iMin(2)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(2),1))>= lunghezzadueterzoIn)
       inlargIn4(indiceLaIn4,1)= i;
       indiceLaIn4 =indiceLaIn4 +1;
    end
end

x23In3 = VettoreElimina(inlargIn3(end),2);
y23In3 = VettoreElimina(inlargIn3(end),1);

x23In4 = VettoreElimina(inlargIn4(1),2);
y23In4 = VettoreElimina(inlargIn4(1),1);

Larghezza23Indice = round(sqrt((x23In3-x23In4).^2+(y23In3-y23In4).^2)); 


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% %  Width Finger base dito Indice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

Larghezza33Indice = round(sqrt((XprimoIndice-XsecondoIndice).^2+(YprimoIndice-YsecondoIndice).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %% Individuare Width Finger da 1/3 dal Max Pollice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

lunghezzaunoterzoPo = (LunghezzaDitoPollice * (1/3))/max(distanzaEuclidea);

indiceLaPo = 1;
for i = PrimoMinimoPollice : indiciLL(1)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(1),1))>= lunghezzaunoterzoPo)
       inlargPo(indiceLaPo,1)= i;
       indiceLaPo = indiceLaPo +1;
    end
end

indiceLaPo2 = 1;
for i = indiciLL(1) : iMin(1)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(1),1))>= lunghezzaunoterzoPo)
       inlargPo2(indiceLaPo2,1)= i;
       indiceLaPo2 = indiceLaPo2 +1;
    end
end

x13Po = VettoreElimina(inlargPo(end),2);
y13Po = VettoreElimina(inlargPo(end),1);

x13Po2 = VettoreElimina(inlargPo2(1),2);
y13Po2 = VettoreElimina(inlargPo2(1),1);

Larghezza13Pollice = round(sqrt((x13Po-x13Po2).^2+(y13Po-y13Po2).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  
% % %% Individuare Width Finger da 2/3 dal Max Pollice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
 
lunghezzadueterzoPo = (LunghezzaDitoPollice * (2/3))/max(distanzaEuclidea);

indiceLaPo3 = 1;
for i = PrimoMinimoPollice : indiciLL(1)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(1),1))>= lunghezzadueterzoPo)
       inlargPo3(indiceLaPo3,1)= i;
       indiceLaPo3 = indiceLaPo3 +1;
    end
end
 
indiceLaPo4 = 1;
for i = indiciLL(1) : iMin(1)
    if(abs(distanzeSmooth(i,1)- distanzeSmooth(indiciLL(1),1))>= lunghezzadueterzoPo)
       inlargPo4(indiceLaPo4,1)= i;
       indiceLaPo4 = indiceLaPo4 +1;
    end
end

x23Po3 = VettoreElimina(inlargPo3(end),2);
y23Po3 = VettoreElimina(inlargPo3(end),1);

x23Po4 = VettoreElimina(inlargPo4(1),2);
y23Po4 = VettoreElimina(inlargPo4(1),1);

Larghezza23Pollice = round(sqrt((x23Po3-x23Po4).^2+(y23Po3-y23Po4).^2)); 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %%   Width Finger base dito Pollice
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

Larghezza33Pollice = round(sqrt((XprimoPollice-XsecondoPollice).^2+(YprimoPollice-YsecondoPollice).^2)); 


 figure,
 imshow(aa)
 hold on
 plot(x13Mi ,y13Mi,'og')
 plot(x13Mi2 ,y13Mi2,'og')
 plot(x23Mi3 ,y23Mi3,'og')
 plot(x23Mi4 ,y23Mi4,'og')
 plot(XprimoMignolo,YprimoMignolo,'og')
 plot(XsecondoMignolo,YsecondoMignolo,'og')
 plot(x13An ,y13An,'og')
 plot(x13An2 ,y13An2,'og')
 plot(x23An3 ,y23An3,'og')
 plot(x23An4 ,y23An4,'og')
 plot(XprimoAnulare,YprimoAnulare,'og')
 plot(XsecondoAnulare,YsecondoAnulare,'og')
 plot(x13Me ,y13Me,'og')
 plot(x13Me2 ,y13Me2,'og')
 plot(x23Me3 ,y23Me3,'og')
 plot(x23Me4 ,y23Me4,'og')
 plot(XprimoMedio,YprimoMedio,'og')
 plot(XsecondoMedio,YsecondoMedio,'og')
 plot(x13In ,y13In,'og')
 plot(x13In2 ,y13In2,'og')
 plot(x23In3 ,y23In3,'og')
 plot(x23In4 ,y23In4,'og')
 plot(XprimoIndice,YprimoIndice,'og')
 plot(XsecondoIndice,YsecondoIndice,'og')
 plot(x13Po,y13Po,'og')
 plot(x13Po2,y13Po2,'og')
 plot(x23Po3,y23Po3,'og')
 plot(x23Po4,y23Po4,'og')
 plot(XprimoPollice,YprimoPollice,'og')
 plot(XsecondoPollice,YsecondoPollice,'og')

 figure,plot(distanzeSmooth)
 hold on 
 plot(indiciLL(5),distanzeSmooth(indiciLL(5),1),'or')
 plot(inlargMi(end),distanzeSmooth(inlargMi(end),1),'og')
 plot(inlargMi2(1),distanzeSmooth(inlargMi2(1),1),'og')
 plot(inlargMi3(end),distanzeSmooth(inlargMi3(end),1),'og')
 plot(inlargMi4(1),distanzeSmooth(inlargMi4(1),1),'og')
 plot(indiciLL(4),distanzeSmooth(indiciLL(4),1),'or')
 plot(inlargAn(end),distanzeSmooth(inlargAn(end),1),'og')
 plot(inlargAn2(1),distanzeSmooth(inlargAn2(1),1),'og')
 plot(inlargAn3(end),distanzeSmooth(inlargAn3(end),1),'og')
 plot(inlargAn4(1),distanzeSmooth(inlargAn4(1),1),'og')
 plot(indiciLL(3),distanzeSmooth(indiciLL(3),1),'or')
 plot(inlargMe(end),distanzeSmooth(inlargMe(end),1),'og')
 plot(inlargMe2(1),distanzeSmooth(inlargMe2(1),1),'og')
 plot(inlargMe3(end),distanzeSmooth(inlargMe3(end),1),'og')
 plot(inlargMe4(1),distanzeSmooth(inlargMe4(1),1),'og')
 plot(indiciLL(2),distanzeSmooth(indiciLL(2),1),'or')
 plot(inlargIn(end),distanzeSmooth(inlargIn(end),1),'og')
 plot(inlargIn2(1),distanzeSmooth(inlargIn2(1),1),'og')
 plot(inlargIn3(end),distanzeSmooth(inlargIn3(end),1),'og')
 plot(inlargIn4(1),distanzeSmooth(inlargIn4(1),1),'og')
 plot(indiciLL(1),distanzeSmooth(indiciLL(1),1),'or')
 plot(inlargPo(end),distanzeSmooth(inlargPo(end),1),'og')
 plot(inlargPo2(1),distanzeSmooth(inlargPo2(1),1),'og')
 plot(inlargPo3(end),distanzeSmooth(inlargPo3(end),1),'og') 
 plot(inlargPo4(1),distanzeSmooth(inlargPo4(1),1),'og')
 xlabel('Indice delle distanze')
 ylabel('Distanze')
% 
% 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %       Rappresentazione grafica delle Width Finger 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
 figure,imshow(aa)
 hold on
 A11 = [x13Mi x13Mi2];
 A12 = [y13Mi y13Mi2];
 A13 = [x23Mi3 x23Mi4];
 A14 = [y23Mi3 y23Mi4];
 A15 = [XprimoMignolo XsecondoMignolo];
 A16 = [YprimoMignolo YsecondoMignolo];
 A17 = [x13An x13An2];
 A18 = [y13An y13An2];
 A19 = [x23An3 x23An4];
 A20 = [y23An3 y23An4];
 A21 = [XprimoAnulare XsecondoAnulare];
 A22 = [YprimoAnulare YsecondoAnulare];
 A23 = [x13Me x13Me2];
 A24 = [y13Me y13Me2];
 A25 = [x23Me3 x23Me4];
 A26 = [y23Me3 y23Me4];
 A27 = [XprimoMedio XsecondoMedio];
 A28 = [YprimoMedio YsecondoMedio];
 A29 = [x13In x13In2];
 A30 = [y13In y13In2];
 A31 = [x23In3 x23In4];
 A32 = [y23In3 y23In4];
 A33 = [XprimoIndice XsecondoIndice];
 A34 = [YprimoIndice YsecondoIndice];
 A35 = [x13Po x13Po2];
 A36 = [y13Po y13Po2];
 A37 = [x23Po3 x23Po4];
 A38 = [y23Po3 y23Po4];
 A39 = [XprimoPollice XsecondoPollice];
 A40 = [YprimoPollice YsecondoPollice];
 plot(A11,A12); 
 plot(A13,A14); 
 plot(A15,A16); 
 plot(A17,A18); 
 plot(A19,A20); 
 plot(A21,A22); 
 plot(A23,A24); 
 plot(A25,A26); 
 plot(A27,A28); 
 plot(A29,A30); 
 plot(A31,A32); 
 plot(A33,A34); 
 plot(A35,A36);
 plot(A37,A38);
 plot(A39,A40);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %           Individuare Punti per Larghezza Palmo messo alla fine in
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % individuazione secondo punto larghezza Palmo
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indiceD = 1;
for i = SecondoMinimoMignolo +1 : length(distanzeSmooth)
        provaD(indiceD,1) = distanzeSmooth(i,1);
        indiceD = indiceD +1;
end

indiceDistanze1 = [];
indiceDi = 1; % cambiare con if else end 
for i = 1 : length(provaD)
    if(provaD(i,1)>= distanzeSmooth(iMin(1),1))
        indiceDistanze1(indiceDi,1) = i ;
        indiceDi = indiceDi + 1;
    end
end


% indiceDistanze = (indiceDistanze1(end,1)) + SecondoMinimoMignolo ; % in
% molti casi bastava questo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nel caso il primo for restituisce un indicedistanze vuoto

indiceDi1 = 1;
if (isempty(indiceDistanze1))
    for i = 1 : length(provaD)
       if(provaD(i,1)<= distanzeSmooth(iMin(1),1))
         indiceDistanze2(indiceDi,1) = i ;
         indiceDi1 = indiceDi1 + 1;
       end
    end
end


if (isempty(indiceDistanze1)) % messo per problema distanze
    indiceDistanze = (indiceDistanze2(1,1)) + SecondoMinimoMignolo ;
else
    indiceDistanze = (indiceDistanze1(end,1)) + SecondoMinimoMignolo ;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Primo punto Larghezza Palmo

XsecondoDistanze = VettoreElimina(indiceDistanze ,2);
YsecondoDistanze = VettoreElimina(indiceDistanze ,1);


% %% Coordinate x e y del Primo punto Larghezza Palmo larghezza mano
%% corrisponde al secondo minimo Pollice trovato

XprimoDistanze = VettoreElimina(iMin(1) ,2); 
YprimoDistanze = VettoreElimina(iMin(1) ,1);
 
 figure,
 imshow(aa)
 plot(XprimoDistanze ,YprimoDistanze,'og')
plot(XsecondoDistanze ,YsecondoDistanze,'.g','MarkerSize', 16)
 title('Punti Mano')
 plot(XpuntoMedio ,YpuntoMedio,'og')
 plot(partenza(2) ,partenza(1),'or')
 plot(XmassimoMedio ,YmassimoMedio,'or')

figure,
imshow(edgeBw2)
title('Punti Linee')
hold on
plot(XsecondoAnulare ,YsecondoAnulare,'.y','MarkerSize', 16)
plot(XprimoAnulare ,YprimoAnulare,'.y','MarkerSize', 16)
plot(XmassimoAnulare ,YmassimoAnulare,'.r','MarkerSize', 16)
plot(XsecondoMignolo ,YsecondoMignolo,'.g','MarkerSize', 16)
plot(XprimoMignolo ,YprimoMignolo,'.y','MarkerSize', 16)
plot(XmassimoMignolo ,YmassimoMignolo,'.r','MarkerSize', 16)
plot(XprimoMedio ,YprimoMedio,'.y','MarkerSize', 16)
plot(XmassimoMedio ,YmassimoMedio,'.r','MarkerSize', 16)
plot(XsecondoIndice ,YsecondoIndice,'.y','MarkerSize', 16)
plot(XprimoIndice,YprimoIndice,'.g','MarkerSize', 16)
plot(XmassimoIndice ,YmassimoIndice,'.r','MarkerSize', 16)
plot(XsecondoPollice ,YsecondoPollice,'.b','MarkerSize', 16)
plot(XprimoPollice,YprimoPollice,'.g','MarkerSize', 16)
plot(XmassimoPollice ,YmassimoPollice,'.r','MarkerSize', 16)
plot(XMedioMignolo ,YMedioMignolo,'.b','MarkerSize', 16)
plot(XMedioAnulare ,YMedioAnulare,'.b','MarkerSize', 16)
plot(XMedioIndice ,YMedioIndice,'.b','MarkerSize', 16)
plot(XMedioPollice ,YMedioPollice,'.b','MarkerSize', 16)
 plot(XmassimoMedio ,YmassimoMedio,'.b','MarkerSize', 16)
 plot(partenza(2) ,partenza(1),'.c','MarkerSize', 16)

title('Punti ManoYUI')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


LarghezzaPalmoUp = round(sqrt((XprimoDistanze-XsecondoDistanze).^2+(YprimoDistanze-YsecondoDistanze).^2)); 


% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % Lenght Palm congiungendo il punto di partenza con il punto mediano del
% % % % % % dito
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lunghezzaPalmo = round(sqrt((XpuntoMedio-partenza(2)).^2+(YpuntoMedio-partenza(1)).^2)); 


% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % %       Rappresentazione grafica delle Length Finger and Width Palm
% % %  %%%%            ecc.
% % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure,imshow(aa)
hold on
A1 = [XmassimoMignolo XMedioMignolo];
A2 = [YmassimoMignolo YMedioMignolo];
A3 = [XmassimoAnulare XMedioAnulare];
A4 = [YmassimoAnulare YMedioAnulare];
A5 = [XmassimoMedio XpuntoMedio];
A6 = [YmassimoMedio YpuntoMedio];
A7 = [XmassimoIndice XMedioIndice];
A8 = [YmassimoIndice YMedioIndice];
A9 = [XmassimoPollice XMedioPollice];
A10 = [YmassimoPollice YMedioPollice];
A11 = [x13Mi x13Mi2];
A12 = [y13Mi y13Mi2];
A13 = [x23Mi3 x23Mi4];
A14 = [y23Mi3 y23Mi4];
A15 = [XprimoMignolo XsecondoMignolo];
A16 = [YprimoMignolo YsecondoMignolo];
A17 = [x13An x13An2];
A18 = [y13An y13An2];
A19 = [x23An3 x23An4];
A20 = [y23An3 y23An4];
A21 = [XprimoAnulare XsecondoAnulare];
A22 = [YprimoAnulare YsecondoAnulare];
A23 = [x13Me x13Me2];
A24 = [y13Me y13Me2];
A25 = [x23Me3 x23Me4];
A26 = [y23Me3 y23Me4];
A27 = [XprimoMedio XsecondoMedio];
A28 = [YprimoMedio YsecondoMedio];
A29 = [x13In x13In2];
A30 = [y13In y13In2];
A31 = [x23In3 x23In4];
A32 = [y23In3 y23In4];
A33 = [XprimoIndice XsecondoIndice];
A34 = [YprimoIndice YsecondoIndice];
A35 = [x13Po x13Po2];
A36 = [y13Po y13Po2];
A37 = [x23Po3 x23Po4];
A38 = [y23Po3 y23Po4];
A39 = [XprimoPollice XsecondoPollice];
A40 = [YprimoPollice YsecondoPollice];
A41 = [XmassimoMedio partenza(2)];
A42 = [YmassimoMedio partenza(1)];
%%%%Adriano Pepe
A43 = [XMedioMignolo XMedioIndice];
A44 = [YMedioMignolo YMedioIndice];
A45 = [XMedioIndice XMedioPollice];
A46 = [YMedioIndice YMedioPollice];
A47 = [XMedioMignolo XMedioPollice];
A48 = [YMedioMignolo YMedioPollice];

plot(A1,A2, 'r', 'LineWidth', 2); 
plot(A3,A4, 'r','LineWidth', 2); 
plot(A5,A6, 'r','LineWidth', 2); 
plot(A7,A8, 'r','LineWidth', 2); 
plot(A9,A10, 'r','LineWidth', 2); 
plot(A11,A12, 'r','LineWidth', 2); 
plot(A13,A14, 'r','LineWidth', 2); 
plot(A15,A16, 'r','LineWidth', 2);  
plot(A17,A18, 'r','LineWidth', 2);  
plot(A19,A20, 'r','LineWidth', 2); 
plot(A21,A22, 'r','LineWidth', 2); 
plot(A23,A24, 'r','LineWidth', 2); 
plot(A25,A26, 'r','LineWidth', 2);  
plot(A27,A28, 'r','LineWidth', 2);  
plot(A29,A30, 'r','LineWidth', 2); 
plot(A31,A32, 'r','LineWidth', 2);  
plot(A33,A34, 'r','LineWidth', 2); 
plot(A35,A36, 'r','LineWidth', 2); 
plot(A37,A38, 'r','LineWidth', 2); 
plot(A39,A40, 'r','LineWidth', 2); 
plot(A41,A42, 'y','LineWidth', 2); 
%%%Adriano
plot(A43,A44, 'b','LineWidth', 2); 
plot(A45,A46, 'b','LineWidth', 2); 
plot(A47,A48, 'b','LineWidth', 2); 

LunghezzaPolliceIndice = round(sqrt((XMedioPollice-XMedioIndice).^2+(YMedioPollice-YMedioIndice).^2));
LunghezzaIndiceMignolo = round(sqrt((XMedioIndice-XMedioMignolo).^2+(YMedioIndice-YMedioMignolo).^2));
LunghezzaMignoloPollice = round(sqrt((XMedioMignolo-XMedioPollice).^2+(YMedioMignolo-YMedioPollice).^2));


p2 = [XpuntoMedio partenza(2)];
p1 = [YpuntoMedio partenza(1)];
A91 = [XprimoDistanze XsecondoDistanze];
A101 = [YprimoDistanze YsecondoDistanze];
plot(p2,p1,'g','LineWidth', 2); 
plot(A91,A101, 'g','LineWidth', 2);

vettoreUtente = [LunghezzaDitoAnulare; LunghezzaDitoMignolo
                 LunghezzaDitoMedio; LunghezzaDitoIndice 
                 LunghezzaDitoPollice; LarghezzaPalmoUp
                 Larghezza13Mignolo; Larghezza23Mignolo
                 Larghezza33Mignolo; Larghezza13Anulare
                 Larghezza23Anulare; Larghezza33Anulare
                 Larghezza13Medio; Larghezza23Medio
                 Larghezza33Medio; Larghezza13Indice
                 Larghezza23Indice; Larghezza33Indice
                 Larghezza13Pollice; Larghezza23Pollice
                 Larghezza33Pollice; lunghezzaPalmo;
                 lunghezzaMano; LunghezzaPolliceIndice;
                 LunghezzaMignoloPollice; LunghezzaIndiceMignolo];

%                  


                 
                 
                 
%                  
%           
%plot(XprimoMignolo ,YprimoMignolo,'og');
% 
 LarghezzaRoiPalmo = round(sqrt((XprimoIndice-XprimoMignolo).^2+(YprimoIndice-YprimoMignolo).^2)); 
  t=134/LarghezzaRoiPalmo;
  XprimoPuntoRoiPalmo=XprimoMignolo;
  YprimoPuntoRoiPalmo=YprimoMignolo;
  XsecondoPuntoRoiPalmo=(1-t)*XprimoPuntoRoiPalmo+t*XprimoIndice;
  YsecondoPuntoRoiPalmo=(1-t)*YprimoPuntoRoiPalmo+t*YprimoIndice;
  %plot(XsecondoPuntoRoiPalmo,YsecondoPuntoRoiPalmo,'or'); 
% 
  vx = XsecondoPuntoRoiPalmo-XprimoPuntoRoiPalmo;
  vy = YsecondoPuntoRoiPalmo-YprimoPuntoRoiPalmo;
  len = sqrt( vx*vx + vy*vy );
  ux = -vy/len;
  uy = vx/len;
  XterzoPuntoRoiPalmo = XprimoPuntoRoiPalmo + (-134 * ux);
  YterzoPuntoRoiPalmo = YprimoPuntoRoiPalmo + (-134 * uy);
 % plot(XterzoPuntoRoiPalmo,YterzoPuntoRoiPalmo,'or'); 
% 
  XquartoPuntoRoiPalmo = XsecondoPuntoRoiPalmo - (134 * ux);
  YquartoPuntoRoiPalmo = YsecondoPuntoRoiPalmo - (134 * uy);
 % plot(XquartoPuntoRoiPalmo,YquartoPuntoRoiPalmo,'or'); 
%              
  A43 = [XprimoPuntoRoiPalmo XprimoIndice];
  A44 = [YprimoPuntoRoiPalmo YprimoIndice];
  A90=[XprimoPollice YprimoPollice];
  %plot(A43,A44,'r--','LineWidth', 2); 
% 
  A45 = [XsecondoPuntoRoiPalmo XquartoPuntoRoiPalmo];
  A46 = [YsecondoPuntoRoiPalmo YquartoPuntoRoiPalmo];
  %plot(A45,A46,'r','LineWidth', 2);
% 
  A47 = [XprimoPuntoRoiPalmo XterzoPuntoRoiPalmo];
  A48 = [YprimoPuntoRoiPalmo YterzoPuntoRoiPalmo];
  %plot(A47,A48,'r','LineWidth', 2);
% 
  A49 = [XterzoPuntoRoiPalmo XquartoPuntoRoiPalmo];
  A50 = [YterzoPuntoRoiPalmo YquartoPuntoRoiPalmo];
 %plot(A49,A50,'r', 'LineWidth', 2);
plot(XsecondoAnulare ,YsecondoAnulare,'.y','MarkerSize', 16)
plot(XprimoAnulare ,YprimoAnulare,'.y','MarkerSize', 16)
plot(XmassimoAnulare ,YmassimoAnulare,'.r','MarkerSize', 16)
plot(XsecondoMignolo ,YsecondoMignolo,'.g','MarkerSize', 16)
plot(XprimoMignolo ,YprimoMignolo,'.y','MarkerSize', 16)
plot(XmassimoMignolo ,YmassimoMignolo,'.r','MarkerSize', 16)
plot(XprimoMedio ,YprimoMedio,'.y','MarkerSize', 16)
plot(XmassimoMedio ,YmassimoMedio,'.r','MarkerSize', 16)
plot(XsecondoIndice ,YsecondoIndice,'.y','MarkerSize', 16)
plot(XprimoIndice,YprimoIndice,'.g','MarkerSize', 16)
plot(XmassimoIndice ,YmassimoIndice,'.r','MarkerSize', 16)
plot(XsecondoPollice ,YsecondoPollice,'.y','MarkerSize', 16)
plot(XprimoPollice,YprimoPollice,'.g','MarkerSize', 16)
plot(XmassimoPollice ,YmassimoPollice,'.r','MarkerSize', 16)
plot(XMedioMignolo ,YMedioMignolo,'.b','MarkerSize', 16)
plot(XMedioAnulare ,YMedioAnulare,'.b','MarkerSize', 16)
plot(XMedioIndice ,YMedioIndice,'.b','MarkerSize', 16)
plot(XMedioPollice ,YMedioPollice,'.b','MarkerSize', 16)
plot(XpuntoMedio ,YpuntoMedio,'.b','MarkerSize', 16)
plot(XmassimoMedio ,YmassimoMedio,'.r','MarkerSize', 16)
 plot(XsecondoDistanze ,YsecondoDistanze,'.m','MarkerSize', 16)
 plot(partenza(2) ,partenza(1),'.c','MarkerSize', 16)

