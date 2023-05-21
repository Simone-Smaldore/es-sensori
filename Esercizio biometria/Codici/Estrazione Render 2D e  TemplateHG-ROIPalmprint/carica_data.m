%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SELEZIONE DELLA DIRECTORY %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Il seguente script prende in input il database delle acquisizioni in formato .mat e a partire 
%da questi va a generare i file .jpg relativi alle sei profondità. Le immagini generate vengono 
%salvate nella stessa directory in cui sono contenuti i .mat

usaMac = true;
if usaMac
    slash = '/';
else 
    slash = '\';
end

directory = uigetdir(pwd,'Seleziona la directory contenente i file .mat') ;
error=0;
elencaSottocartelle;
%_____________________

for indiceSoggetto=0:sizeSubFolders-1 	%scandisce le sottocartelle (una per ogni utente)

    disp([newline 'Rimangono ' num2str(sizeSubFolders - indiceSoggetto) ' utenti per cui generare immagini'])

    soggettoAnalisi = subFolders(indiceSoggetto+1).name;

    directory2 = [directory slash soggettoAnalisi];

    all_files = dir(directory2);
    numAcquisizioni = nnz(~ismember({all_files.name},{'.','..'})&[all_files.isdir]);
    
    disp(['Ci sono '  num2str(numAcquisizioni) ' acquisizioni per il soggetto ' soggettoAnalisi]);
    
    for g = 1 : numAcquisizioni        %scandisce le sottocartelle (una per ogni acquisizione)

        cartellaAcquisizione = num2str(g);
        disp(['Generando le immagini per acquisizione numero ' cartellaAcquisizione  ' del soggetto ' soggettoAnalisi]);
        
        pathNameSubDirectory=[directory slash soggettoAnalisi slash cartellaAcquisizione];
        filenameData = strcat(pathNameSubDirectory,slash,soggettoAnalisi,'_', cartellaAcquisizione);
        load(filenameData);

        %PARAMETRI
        tresh=32;   % Intensity treshold for surface detection (0 - 255)
        filter_siz=10;  % Averaging filter
     
        %Interpolation? % introdotto per linee mano
   
         [Z , M] = interp1k ( Z , M , (Z(1):0.05:Z(length(Z))+0.01)' , 3 ); 
         DataFolderSave=[directory, slash,soggettoAnalisi, slash, cartellaAcquisizione , slash ];
       %  mkdir(DataFolderSave);
         
		 
		 
		 %SETTAGGIO DEI PARAMETRI PER L'ESTRAZIONE DEI RENDER 2D
         %---------------------------
        
       %  depthname = [0.2 1 2];
       depthname = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8];
         %---------------------------
         
        
      
        for i=1:16
            depth=depthname(i);
            surface_detection;
            FileName=strcat( 'Immagine_', num2str((i)) ,'.jpg');
            Name = fullfile(DataFolderSave, FileName);
            %Name = fullfile(PathName, FileName);
            imwrite(FFF, Name, 'jpg');
            FF1=FFF; 
           % FFFF(:,:,i)=FFF;
        end
     
    end   
end
disp(newline)
disp('******************************')
disp('* Genera immagini completato *')
disp('******************************')