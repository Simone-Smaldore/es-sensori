    % carica il file .uob e genera i 250 BScan
clear all
clc

addpath 'ULA_OP_TEST';
cercaFileUob; %carica il file con estensione .uob
pathnameBS = [pwd '\BSCAN' '\'];
DataObj=DataUlaopBaseBand(fileUOB); 
eliminaResidui;
convert2bmp;