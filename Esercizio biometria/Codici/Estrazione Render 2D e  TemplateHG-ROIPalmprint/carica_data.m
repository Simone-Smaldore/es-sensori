%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SELEZIONE DELLA DIRECTORY %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Il seguente script prende in input il database delle acquisizioni in formato .mat e a partire 
%da questi va a generare i file .jpg relativi alle sei profondità. Le immagini generate vengono 
%salvate nella stessa directory in cui sono contenuti i .mat

directory = uigetdir(pwd,'Seleziona la directory contenente i file .mat') ;
error=0;
elencaSottocartelle;
%_____________________

for kk=0:sizeSubFolders-1 	%scandisce le sottocartelle (una per ogni utente)
    directory2 = [directory '\' subFolders(kk+1).name]
    [m, n] = size(dir(directory2));
   
    
    for g = 1 :  m-2           %scandisce le sottocartelle (una per ogni acquisizione)
        
     
        pathNameSubDirectory=[directory '\' subFolders(kk+1).name '\' num2str(g)];
        filenameData = strcat(pathNameSubDirectory,'\',subFolders(kk+1).name,'_',num2str(g));
        load(filenameData);

        %PARAMETRI
        tresh=32;   % Intensity treshold for surface detection (0 - 255)
        filter_siz=10;  % Averaging filter
     
        %Interpolation? % introdotto per linee mano
   
         [Z , M] = interp1k ( Z , M , (Z(1):0.05:Z(length(Z))+0.01)' , 3 ); 
         DataFolderSave=[directory, '\',subFolders(kk+1).name, '\', num2str(g), '\' ];
       %  mkdir(DataFolderSave);
         
		 
		 
		 %SETTAGGIO DEI PARAMETRI PER L'ESTRAZIONE DEI RENDER 2D
         %---------------------------
        
       %  depthname = [0.2 1 2];
       depthname = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8];
         %---------------------------
         
        
      
        for i=1:16
            depth=depthname(i);
            surface_detection;
            FileName=strcat( 'Immagine_', num2str((i)),'.jpg' );
            Name = fullfile(DataFolderSave, FileName);
            %Name = fullfile(PathName, FileName);
            imwrite(FFF, Name, 'jpg');
            FF1=FFF; 
           % FFFF(:,:,i)=FFF;
        end
     
    end   
end