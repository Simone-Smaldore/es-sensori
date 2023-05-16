filelist=cell(250,1);
cartella='Bscan'; %qui inserisci il path dei bscan generati

for i=1:250
 if i<10
       indice=['00' num2str(i)];
    else
        if i<100
            indice=['0' num2str(i)];
        else
            indice=num2str(i);
        end
 end
 filelist{i}=[cartella '\'  indice '.bmp'];
end

%% alcuni parametri settati in automatico, decommentarli se si desidera
probeselection=3;
depthselection=1;
stepsize=0.2;
