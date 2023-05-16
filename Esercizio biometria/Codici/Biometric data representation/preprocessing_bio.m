%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BioMetric Data Representation   %
% April 2010 - Alessandro Savoia  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%PREPROCESSING MODULE%%%%%%%%
%clear all
%close all
%clc

clear M

init_bio
probes_bio
depths_bio
data_bio
crop_bio  %da commentare se non si vuole selezionare la ROI 
interp_bio

save file.mat M X Y Z 

eliminaBS;