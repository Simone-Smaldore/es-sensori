
usaMac = true;
if usaMac
    slash = '/';
else 
    slash = '\';
end

elencaSottocartelle;

cartellaDestinazione = 'templateGenerati'
   
for kk=0:sizeSubFolders-1
    
   director = strcat(directory, slash, subFolders(kk+1).name);
    mkdir([pwd  slash cartellaDestinazione], subFolders(kk+1).name);
    struttura = dir(fullfile(director));
    
    for r=3:size(struttura,1)
        
        director2 = strcat(director, slash, struttura(r).name);
        mkdir([pwd slash cartellaDestinazione slash subFolders(kk+1).name], struttura(r).name);
        struttura2 = dir(fullfile(director2));
        
        for h=3:size(struttura2,1)
           % struttura2(h).name=strcat(struttura2(h).name(1:8),'_',num2str(h-2));
            file = strcat(director2,slash, strcat(struttura2(h).name(1:8),'_',num2str(h-2),'.jpg'));
            disp(file);
            im11 = imread(file);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % SETTAGGIO PARAMETRI IMMAGINE ULTRASONICHE %
            sigmaGauss = 0.5;                          
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % LE IMMAGINI SONO A BASSA RISOLUZIONE 72 DPI

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % SOGLIE IN SCALA DI GRIGIO USATE PER FILTRARE %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            sogliaMedia3x3 = 175;
            sogliaMedia7x7 = 160;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % RIDIMENSIONO LA GRANDEZZA DELL'IMMAGINE %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            y=(133)/4;
            x=(133)/4;
            im1=imresize(im11, [y x], 'bicubic'); % imposto la grandezza dell'immagine
            %   app = size(im2);
            %   col = app(2);
            %   resize = 349.44/col;
            %   resize = 200/col; MIGLIORE
            %   resize = 200/col;
            im1=imresize(im1, [266 266],'bicubic'); % la scala della dimensione ricercata ovvero 349 colonne
            
             imwrite( im1,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_RESIZE' num2str(h-2) '.jpg']);
            
             
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % TRASFORMO L'IMMAGINE IN SCALA DI GRIGI AD 8 BIT %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            immagine2 = im2uint8(im1);
            if(ndims(immagine2)>2) %significa che l'immagine è RGB
                matGraySporco = rgb2gray(immagine2);
            else
                matGraySporco = immagine2;
            end
         
           
           matGraySporco=imadjust(matGraySporco, stretchlim(matGraySporco),[]);

           imwrite( matGraySporco,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_BIANCO_NERA' num2str(h-2) '.jpg']);
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % EFFETTUO VARI FILTRAGGI PER REALIZZARE LE LINEE %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            num=3;
            mat3=template_difference(matGraySporco,num,sigmaGauss);
            
          
           
            
            num=5;
            mat5=template_difference(matGraySporco,num,sigmaGauss);
          
           
           
            num=7;
            mat7=template_difference(matGraySporco,num,sigmaGauss);
           
            num=9;
            mat9=template_difference(matGraySporco,num,sigmaGauss);
           
            num=11;
            mat11=template_difference(matGraySporco,num,sigmaGauss);
           
            
           imwrite( mat3,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MAT_3_' num2str(h-2) '.jpg']);  
          

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % VISIONO I PUNTI DI TUTTE LE MATRICI CALCOLATE %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            dimensione=size(mat3);
            dimensionerighe=dimensione(1);
            dimensionecolonne=dimensione(2);
            mat3_17=zeros(dimensionerighe,dimensionecolonne);
            k=1; %grandezza della matrice di scansionamento -- k=1 --> 3x3
            for i=1+k:dimensionerighe-k
                for j=1+k:dimensionecolonne-k
                    somma_pixel=0;
                    for i1=i-k:i+k
                        for j1=j-k:j+k
                              somma_pixel=somma_pixel+mat9(i1,j1)+mat11(i1,j1)+mat7(i1,j1)+mat5(i1,j1); %dal 5 al 15
                        end
                    end
                    mat3_17(i,j)=somma_pixel;
                end
            end

            imwrite( matGraySporco,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_SOMMA_GAUSS' num2str(h-2) '.jpg']);  
            
            %bisogna provare a fare gli score e smanettare su quali matrici usare e la
            %soglia

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % FILTRO LA MATRICE APPENA CALCOLATA %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            soglia_filtro=6; %era 5
            mat3_17_filtrata=mat3_17;
             
            for i=1+k:dimensionerighe-k
                for j=1+k:dimensionecolonne-k
                    if(mat3_17(i,j)<=soglia_filtro)
                        mat3_17_filtrata(i,j)=0;
                    end
                end
            end

            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % ELIMINIAMO IL CONTORNO DELLA MATRICE %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
            matGrayXY_binary1=mat3_17_filtrata([8:dimensionerighe-7],[8:dimensionecolonne-7]); %ne eliminiamo 7
            imwrite( matGrayXY_binary1,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_NO_CONTORNO_BINARY_1' num2str(h-2) '.jpg']);  
            
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % CANCELLO I PIXEL DAL CONTORNO %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            mat3_17_filtrata2=mat3_17_filtrata;
            
            for i=1:dimensionerighe
                for j=1:dimensionecolonne
                    if(i<=7 || i>=dimensionerighe-7)
                        mat3_17_filtrata2(i,j)=0;
                    end
                    if(j<=7 || j>=dimensionecolonne-7)
                        mat3_17_filtrata2(i,j)=0;
                    end
                end
            end
            
            matGraySporco2=matGraySporco([8:dimensionerighe-7],[8:dimensionecolonne-7]);

            imwrite( matGraySporco2,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_NO_CONTORNO_IMMAGINE' num2str(h-2) '.jpg']);  

            % %senza contorni
            matGrayXY_binary3 = bwmorph(matGrayXY_binary1,'close');
            imwrite( matGrayXY_binary3,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_NO_CONTORNO_BINARY_3' num2str(h-2) '.jpg']);  
         
            matGrayXY_binary4 = bwmorph(matGrayXY_binary3,'thin',Inf);

            imwrite( matGrayXY_binary4,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_NO_CONTORNO_BINARY_4' num2str(h-2) '.jpg']);  

            %%%%%%%%%%%%%%%%%%%%%%%%
            % RICOSTRUIAMO I BORDI %
            %%%%%%%%%%%%%%%%%%%%%%%%


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % ELIMINO I TRATTI PIU CORTI %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            matriceXY_delete1=delete_small_lines(matGrayXY_binary4);

            imwrite( matriceXY_delete1,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_TRATTI_CORTI' num2str(h-2) '.jpg']);  
 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % ELIMINO I TRATTI ISOLATI %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            matriceXY_delete = bwmorph(matriceXY_delete1,'clean',Inf);

            imwrite( matriceXY_delete,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'MATRICE_TRATTI_ISOLATI' num2str(h-2) '.jpg']);  
            
            
            rgbImage = cat(3, matGraySporco2, matGraySporco2, matGraySporco2);

%SOVRAPPOSIZIONE %%WARNING:RIMETTERE COME PRIMA
            [m n1]= size(im1);
    for i=1 : 252
              for j=1 : 252
                 if  matriceXY_delete(i,j)==1
        %inputImage(i,j)=255;
            rgbImage(i,j,1)=255;
            rgbImage(i,j,2)=255;
            rgbImage(i,j,3)=255;
                 end 
              end 
    end  

            
            
            
            save([pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'TEMPLATE' num2str(h-2) '.dat'], 'matriceXY_delete');
             imwrite( matriceXY_delete,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'TEMPLATE' num2str(h-2) '.jpg']);
            imwrite(  rgbImage,[pwd slash cartellaDestinazione slash subFolders(kk+1).name slash struttura(r).name slash 'TEMPLATEM' num2str(h-2) '.jpg']);

            break
        end
    end
end