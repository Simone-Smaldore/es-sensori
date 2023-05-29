function [ matrice ] = profonditaTratti2( matrice, matFile )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    matriceProfondita =  zeros(size(matrice,2),size(matrice,3));
    
    for (i=1:size(matrice,1))    
        
        matriceProfondita = matriceProfondita + squeeze(matrice(i,:,:));
        
    end
    
    matriceOutput = matrice;
    
    istante = str2num(matFile(end));

    if(istante==0)

        save(strcat(pwd,'/Template3D/istante000/',matFile,'.dat'),'matrice');
    end

    if(istante==1)

        save(strcat(pwd,'/Template3D/istante001/',matFile,'.dat'),'matrice');

    end

    if(istante==2)

        save(strcat(pwd,'/Template3D/istante002/',matFile,'.dat'),'matrice');

    end
     if(istante==3)

        save(strcat(pwd,'/Template3D/istante003/',matFile,'.dat'),'matrice');
     end
         if(istante==4)

        save(strcat(pwd,'/Template3D/istante004/',matFile,'.dat'),'matrice');
         end
     if(istante==5)

        save(strcat(pwd,'/Template3D/istante005/',matFile,'.dat'),'matrice');
     end
      if(istante==6)

        save(strcat(pwd,'/Template3D/istante006/',matFile,'.dat'),'matrice');
      end
       if(istante==7)

        save(strcat(pwd,'/Template3D/istante007/',matFile,'.dat'),'matrice');
       end
          if(istante==8)

        save(strcat(pwd,'/Template3D/istante008/',matFile,'.dat'),'matrice');
          end
          if(istante==9)

        save(strcat(pwd,'/Template3D/istante009/',matFile,'.dat'),'matrice');
          end
        
    
    imagesc(matrice);
    normalized_matrix = matrice * (18);

    %colormap(jet);
    %colorbar;
    %set(gca, 'CLim', [0 13], 'FontName', 'TimesNewRoman');

    rgb_image = ind2rgb(normalized_matrix, jet);

    imshow(rgb_image);
  
    percorso = [pwd '/Template3D/istante00' num2str(istante) '/' matFile '.jpg'];
    imwrite(rgb_image,percorso);

    %saveas(figure1, percorso);
    close;

