function [] = convertiUob( fileUOB, saveName)    

    addpath 'ULA_OP_TEST';
    pathnameBS = [pwd '\BSCAN' '\'];
    DataObj=DataUlaopBaseBand(fileUOB); 
    eliminaResidui;
    convert2bmp;
    preprocessing_crop_fisso;
end

