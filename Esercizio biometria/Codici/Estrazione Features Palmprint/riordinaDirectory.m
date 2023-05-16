clear
clc
folderSaveName = 'TemplateGeneratiW1';
elencaSottocartelle;

%stringa percorso salvataggio nella cartella superiore a directory attuale
parts = strsplit(directory, '\');
DirPart = parts{end-1};
saveDir = strjoin(parts(1:end-1),'\'); 

%controlla se esiste la cartella con il nome, altrimenti la crea
if ~exist(folderSaveName, 'dir') 
    mkdir(saveDir, folderSaveName); 
end


profondita1 = [directory '\' '100mm' '\'];
profondita2 = [directory '\' '150mm' '\'];
profondita3 = [directory '\' '200mm' '\'];
profondita4 = [directory '\' '250mm' '\'];
profondita5 = [directory '\' '300mm' '\'];
profondita6 = [directory '\' '350mm' '\'];
profondita7 = [directory '\' '400mm' '\'];
profondita8 = [directory '\' '450mm' '\'];
profondita9 = [directory '\' '500mm' '\'];
profondita10 = [directory '\' '550mm' '\'];
profondita11 = [directory '\' '600mm' '\'];
profondita12 = [directory '\' '650mm' '\'];
profondita13 = [directory '\' '700mm' '\'];
profondita14 = [directory '\' '750mm' '\'];


files = dir(fullfile(profondita1));

mkdir(pwd, 'Fusione12_New');
p = [pwd '\' 'Fusione12_New'];

for k=3:length(files)
    error=0;
      % fullPathName1=[profondita1 files(k).name  '\' 'render_0.1.jpg'];
      % fullPathName2=[profondita2 files(k).name  '\' 'render_0.2.jpg'];
      % [im12]=merge12(fullPathName1, fullPathName2);

     try
        im1 = imread([profondita1 files(k).name  '\' 'render_100.jpg']);
        im2 = imread([profondita2 files(k).name  '\' 'render_150.jpg']);
        im3 = imread([profondita3 files(k).name  '\' 'render_200.jpg']);
		im4 = imread([profondita4 files(k).name  '\' 'render_250.jpg']);
        im5 = imread([profondita5 files(k).name  '\' 'render_300.jpg']);
        im6 = imread([profondita6 files(k).name  '\' 'render_350.jpg']);
        im7 = imread([profondita7 files(k).name  '\' 'render_400.jpg']);
		im8 = imread([profondita8 files(k).name  '\' 'render_450.jpg']);
		im9 = imread([profondita9 files(k).name  '\' 'render_500.jpg']);
		im10 = imread([profondita10 files(k).name  '\' 'render_550.jpg']);
		im11 = imread([profondita11 files(k).name  '\' 'render_600.jpg']);
		im12 = imread([profondita12 files(k).name  '\' 'render_650.jpg']);
		im13 = imread([profondita13 files(k).name  '\' 'render_700.jpg']);
		im14 = imread([profondita14 files(k).name  '\' 'render_750.jpg']);
		
        catch
            
             messaggio = strcat('Problema nella generazione del template');   
			 error=1;
	end
       % im1 = imresize(im1,  [542 814], 'bicubic');
        %im2 = imresize(im2,  [542 814], 'bicubic');
        %im3 = imresize(im3,  [542 814], 'bicubic');
        %im4 = imresize(im4,  [542 814], 'bicubic');
        %im5 = imresize(im5,  [542 814], 'bicubic');
        %im6 = imresize(im6,  [542 814], 'bicubic');
        
        %FILTRO PRESO DA CREATE_PALM_COLOR TOGLIENDO DOPPIA IMMAGINE MA
        %LASCIANDO IL FILTRO
       % w1 = fspecial('average', [9,9]);   %9 migliore
        
        %im1 = imfilter(im1,w1);
        %im2 = imfilter(im2,w1);
        %im3 = imfilter(im3,w1);
        %im4 = imfilter(im4,w1);
        %im5 = imfilter(im5,w1);
        %im6 = imfilter(im6,w1);     
      if error==0
        e = num2str(files(k).name);
        
        mkdir(p, e(1:2));
        
        mkdir([p '\' e(1:2)], files(k).name);
        
    %   imwrite(im12, [p '\' e(1:2) '\' files(k).name '\' 'immagine_12.jpg']);
        imwrite(im1,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_1.jpg']);
        imwrite(im2,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_2.jpg']);
        imwrite(im3,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_3.jpg']);
        imwrite(im4,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_4.jpg']);
        imwrite(im5,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_5.jpg']);
        imwrite(im6,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_6.jpg']);
        imwrite(im7,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_7.jpg']);
		imwrite(im8,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_8.jpg']);
		imwrite(im9,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_9.jpg']);
		imwrite(im10,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_10.jpg']);
		imwrite(im11,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_11.jpg']);
	    imwrite(im12,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_12.jpg']);
	    imwrite(im13,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_13.jpg']);
		imwrite(im14,  [p '\' e(1:2) '\' files(k).name '\' 'immagine_14.jpg']);
			  
       end 
       
end