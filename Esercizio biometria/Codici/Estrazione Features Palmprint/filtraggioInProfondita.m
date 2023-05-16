function [ matriceOutput ] = filtraggioInProfondita(matriceZXY,sizeNeighboorhod)

    neighboorhod = strel('square',sizeNeighboorhod);  

    sizeTemplate = size(matriceZXY);
    
    matriceTemplate =  zeros(sizeTemplate);
    
    matriceTemplate(6,:,:) = imdilate(matriceZXY(6,:,:),neighboorhod);
    %matriceTemplate(1,:,:) = matriceZXY(1,:,:); %cancellare
    
    matriceTemp = matriceZXY;
    
    for(i=6:-1:2)
    
        currentMatrix = squeeze(matriceTemp(i,:,:));

        dilatateCurrentMatrix = imdilate(currentMatrix,neighboorhod); 

        nextDepthMatrix = squeeze(matriceTemp(i-1,:,:));
        
        
        FilteredNextDepthMatrix = bitand(dilatateCurrentMatrix,nextDepthMatrix);

        matriceTemp(i-1,:,:) = FilteredNextDepthMatrix;

        matriceTemplate(i-1,:,:) = imdilate(FilteredNextDepthMatrix,neighboorhod);
        
    end
    

    for(i=6:sizeTemplate(1)-1)
    
        currentMatrix = squeeze(matriceTemp(i,:,:));

        dilatateCurrentMatrix = imdilate(currentMatrix,neighboorhod); 

        nextDepthMatrix = squeeze(matriceTemp(i+1,:,:));
        
        
        FilteredNextDepthMatrix = bitand(dilatateCurrentMatrix,nextDepthMatrix);

        matriceTemp(i+1,:,:) = FilteredNextDepthMatrix;

        matriceTemplate(i+1,:,:) = imdilate(FilteredNextDepthMatrix,neighboorhod);
        
    end
    
    matriceOutput = matriceTemplate;
    
end