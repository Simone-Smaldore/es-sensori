function [ matriceOutput ] = generaMatriceContenenteTemplate(path)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
         
    %path = 'codice/palmprint_tesi/template/lines_template/provaProfondita/';    
    
    
    
    %ricommentare template1
    %template1 = importdata(strcat(path,'TEMPLATE1.dat'));
    disp(strcat(path,'TEMPLATE1.dat'))
    template2 = importdata(strcat(path,'TEMPLATE1.dat'));
    template3 = importdata(strcat(path,'TEMPLATE2.dat'));
    template4 = importdata(strcat(path,'TEMPLATE3.dat'));
    template5 = importdata(strcat(path,'TEMPLATE4.dat'));
    template6 = importdata(strcat(path,'TEMPLATE5.dat'));
	template7 = importdata(strcat(path,'TEMPLATE6.dat'));
    template8 = importdata(strcat(path,'TEMPLATE7.dat'));
    template9 = importdata(strcat(path,'TEMPLATE8.dat'));
    template10 = importdata(strcat(path,'TEMPLATE9.dat'));
    template11 = importdata(strcat(path,'TEMPLATE10.dat'));
    template12 = importdata(strcat(path,'TEMPLATE11.dat'));
    template13 = importdata(strcat(path,'TEMPLATE12.dat'));
    template14 = importdata(strcat(path,'TEMPLATE13.dat'));
    template15 = importdata(strcat(path,'TEMPLATE14.dat'));

    sizeTemplate = size(template2);
    
    matriceTemplate =  zeros(sizeTemplate(1),sizeTemplate(2),14);
    
    for (i=2:15)    
        
        index = i;
        
        index = int2str(index);
        
        name = strcat('template',index);
        
        currentTemplate = eval(name);
        
        matriceTemplate(:,:,i-1) = currentTemplate;
        
        %figure;imshow(currentTemplate);
        
    end
    
    matriceTemplate = shiftdim(matriceTemplate,2);
      
    matriceOutput = matriceTemplate;
    
end
