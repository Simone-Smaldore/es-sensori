%La funzione renderEdge.m, data un render 2D in input, permette di estrarne 
%il contorno

function [output] = renderEdge()
    %L'utente seleziona l'immagine
    [FileName, PathName] = uigetfile('*.jpg', 'Seleziona il render 2D');
    percorso = strcat(PathName, FileName);
    
    %im2double ridemensione l'intervallo dei valori da [0 255] a [0 1]
    matrice = im2double(imread(percorso));
    
    %Imadjust aumenta il contrasto nell'immagine, selezionando solo i pixel
    %compresi nell'intervallo scelto 
    output = imadjust(matrice, [0.02 1], []);
    
    %Portiamo a 1 tutti i valori maggiori di 0.05 in questo modo si ottiene
    %un immagine con sfondo nero e mano interamente bianca
    output = (output > 0.05);

    %Applichiamo un filtro mediano per migliorare la definizione della mano
    output = medfilt2(output, [8,8]);
    output = imfill(output,'holes');
    imshow(output);
    
    %Procediamo all'estrazione dei contorni 
    output = edge(output);
    
    %Invertiamo la matrice per avere contorno nero su sfondo bianco
    bw2 = ~output;
    
    %imshow(bw2);
end

