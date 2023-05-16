clear all;

clc; 
close all;

cartella=uigetdir(pwd, 'Seleziona la cartella file.dat');
directory_name=pwd;
cartella=strcat(cartella,'\');
dirs=dir(fullfile(cartella));
mkdir('Template3D');
mkdir('Template3D\istante000');
mkdir('Template3D\istante001');
mkdir('Template3D\istante002');
mkdir('Template3D\istante003');
mkdir('Template3D\istante004');
mkdir('Template3D\istante005');
mkdir('Template3D\istante006');
mkdir('Template3D\istante007');
mkdir('Template3D\istante008');
mkdir('Template3D\istante009');

k=1;
for i=3:length(dirs)
    acquisizioni = dir(fullfile([cartella, dirs(i).name, '\']));
    for c = 3:length(acquisizioni)
        a = generaMatriceContenenteTemplate(acquisizioni(c).name);
        b = filtraggioInProfondita(a, 4);
        profonditaTratti1(b,acquisizioni(c).name);
    end
end	