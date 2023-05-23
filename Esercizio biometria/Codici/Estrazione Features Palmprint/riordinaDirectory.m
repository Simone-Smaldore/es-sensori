clear
clc

usaMac = true;
if usaMac
    slash = '/';
else 
    slash = '\';
end

folderSaveName = 'TemplateGeneratiW1';
elencaSottocartelle;

%stringa percorso salvataggio nella cartella superiore a directory attuale
parts = strsplit(directory, slash);
DirPart = parts{end-1};
saveDir = strjoin(parts(1:end-1),slash); 

%controlla se esiste la cartella con il nome, altrimenti la crea
if ~exist(folderSaveName, 'dir') 
    mkdir(saveDir, folderSaveName); 
end


profondita1 = [directory slash '100mm' slash];
profondita2 = [directory slash '150mm' slash];
profondita3 = [directory slash '200mm' slash];
profondita4 = [directory slash '250mm' slash];
profondita5 = [directory slash '300mm' slash];
profondita6 = [directory slash '350mm' slash];
profondita7 = [directory slash '400mm' slash];
profondita8 = [directory slash '450mm' slash];
profondita9 = [directory slash '500mm' slash];
profondita10 = [directory slash '550mm' slash];
profondita11 = [directory slash '600mm' slash];
profondita12 = [directory slash '650mm' slash];
profondita13 = [directory slash '700mm' slash];
profondita14 = [directory slash '750mm' slash];


files = dir(fullfile(profondita1));

mkdir(pwd, 'Fusione12_New');
p = [pwd slash 'Fusione12_New'];

for k=3:length(files)
    error=0;
      % fullPathName1=[profondita1 files(k).name  slash 'render_0.1.jpg'];
      % fullPathName2=[profondita2 files(k).name  slash 'render_0.2.jpg'];
      % [im12]=merge12(fullPathName1, fullPathName2);

     try
        im1 = imread([profondita1 files(k).name  slash 'render_100.jpg']);
        im2 = imread([profondita2 files(k).name  slash 'render_150.jpg']);
        im3 = imread([profondita3 files(k).name  slash 'render_200.jpg']);
		im4 = imread([profondita4 files(k).name  slash 'render_250.jpg']);
        im5 = imread([profondita5 files(k).name  slash 'render_300.jpg']);
        im6 = imread([profondita6 files(k).name  slash 'render_350.jpg']);
        im7 = imread([profondita7 files(k).name  slash 'render_400.jpg']);
		im8 = imread([profondita8 files(k).name  slash 'render_450.jpg']);
		im9 = imread([profondita9 files(k).name  slash 'render_500.jpg']);
		im10 = imread([profondita10 files(k).name  slash 'render_550.jpg']);
		im11 = imread([profondita11 files(k).name  slash 'render_600.jpg']);
		im12 = imread([profondita12 files(k).name  slash 'render_650.jpg']);
		im13 = imread([profondita13 files(k).name  slash 'render_700.jpg']);
		im14 = imread([profondita14 files(k).name  slash 'render_750.jpg']);
		
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
        
        mkdir([p slash e(1:2)], files(k).name);
        
    %   imwrite(im12, [p slash e(1:2) slash files(k).name slash 'immagine_12.jpg']);
        imwrite(im1,  [p slash e(1:2) slash files(k).name slash 'immagine_1.jpg']);
        imwrite(im2,  [p slash e(1:2) slash files(k).name slash 'immagine_2.jpg']);
        imwrite(im3,  [p slash e(1:2) slash files(k).name slash 'immagine_3.jpg']);
        imwrite(im4,  [p slash e(1:2) slash files(k).name slash 'immagine_4.jpg']);
        imwrite(im5,  [p slash e(1:2) slash files(k).name slash 'immagine_5.jpg']);
        imwrite(im6,  [p slash e(1:2) slash files(k).name slash 'immagine_6.jpg']);
        imwrite(im7,  [p slash e(1:2) slash files(k).name slash 'immagine_7.jpg']);
		imwrite(im8,  [p slash e(1:2) slash files(k).name slash 'immagine_8.jpg']);
		imwrite(im9,  [p slash e(1:2) slash files(k).name slash 'immagine_9.jpg']);
		imwrite(im10,  [p slash e(1:2) slash files(k).name slash 'immagine_10.jpg']);
		imwrite(im11,  [p slash e(1:2) slash files(k).name slash 'immagine_11.jpg']);
	    imwrite(im12,  [p slash e(1:2) slash files(k).name slash 'immagine_12.jpg']);
	    imwrite(im13,  [p slash e(1:2) slash files(k).name slash 'immagine_13.jpg']);
		imwrite(im14,  [p slash e(1:2) slash files(k).name slash 'immagine_14.jpg']);
			  
       end 
       
end