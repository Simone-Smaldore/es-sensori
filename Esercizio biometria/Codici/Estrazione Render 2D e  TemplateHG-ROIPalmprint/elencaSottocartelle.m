%il seguente script viene chiamato da altri script e permette, una volta selezionata la directory
%richiesta dallo script da cui è chiamato, di estrapolare tutte le informazioni utili, in particolare
%una struttura subFolders (che contiene i dati relativi alla struttura delle sottocartelle) e 
%sizeSubFolders contenente il numero di subFolders.

% Get a list of all files and folders in this folder.
files = dir(directory);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

% Remove first and second element . & .. that refers to the current
% directiory and the previous one
subFolders(1:2) = [];

sizeSubFolders=size(subFolders,1);
clear files;
clear dirFlags;