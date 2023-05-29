clear all;

clc; 
close all;


usaMac = true;
if usaMac
    slash = '/';
else 
    slash = '\';
end

cartella=uigetdir(pwd, 'Seleziona la cartella file.dat');
directory_name=pwd;
cartella=strcat(cartella, slash);
dirs=dir(fullfile(cartella));
mkdir('Template3D');
mkdir(['Template3D' slash 'istante000']);
mkdir(['Template3D' slash 'istante001']);
mkdir(['Template3D' slash 'istante002']);
mkdir(['Template3D' slash 'istante003']);
mkdir(['Template3D' slash 'istante004']);
mkdir(['Template3D' slash 'istante005']);
mkdir(['Template3D' slash 'istante006']);
mkdir(['Template3D' slash 'istante007']);
mkdir(['Template3D' slash 'istante008']);
mkdir(['Template3D' slash 'istante009']);

k=1;
for i=3:length(dirs)
    acquisizioni = dir(fullfile([cartella, dirs(i).name, slash]));
    for c = 3:length(acquisizioni)  

        if(acquisizioni(c).name == ".DS_Store")
            continue
        end

        path = [cartella, dirs(i).name, slash, acquisizioni(c).name, slash];
        a = generaMatriceContenenteTemplate(path);
        b = filtraggioInProfondita(a, 4);
        pixel_counts = sum(b, 1);
        pixel_counts = permute(pixel_counts, [2,3,1]);
        pixel_counts = squeeze(pixel_counts);
        

        %profonditaTratti2(b,acquisizioni(c).name);
        profonditaTratti2(pixel_counts,acquisizioni(c).name);
    end
end	