%dai b-scan alla matrice .mat
clear M
init_bio
probes_bio
depths_bio
data_bio
crop_fisso
%interp_bio
save(saveName,'M','X','Y','Z');
% eliminaBS;
