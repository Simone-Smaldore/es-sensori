%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          Trasformazione in binario Immagine originale                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Questo script permette di convertire il jpg della mano in un nuovo jpg binarizzato
%In pratica genera un immagine della mano completamente bianca su uno sfondo nero



%Conversione immagine da 24 a 8 bit
if numel(size(aa)) > 2 
    aa = rgb2gray(aa);
end

%Applichiamo un filtro mediano 7x7 e aumentiamo il contrasto tra la mano e lo sfondo 
mediano = medfilt2(aa, [7,7]);
I2 = imadjust(mediano, stretchlim(mediano), []);

%Applichiamo la procedura di binarizzazione utilizzando la soglia 0.15 
level = 0.15; 
bw1 = im2bw(I2,level);

%Grafichiamo l'immagine binarizzata
%figure,imshow(bw1);
%title('Immagine binarizzata');

%%% Rimuoviamo il nero presente sul polso e grafichiamo
aaa = bw1(:,1);

indiceBordo = 1;
for j = 1 : length(aaa) -20
    if(aaa(j,1) == 1) 
        prova1(indiceBordo,1) = j;
        indiceBordo = indiceBordo +1;
    end
     
end

prova2 = prova1(1);
prova3 = prova1(end);

bw1(prova2:prova3,1) = 1;

bw2 = imfill(bw1,'holes');

%Genera grafico con il solo bordo
edgeBw2 = edge(bw2);
%figure,imshow(~edgeBw2)
%title('Contorno mano');
%hold off