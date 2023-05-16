close all;
% clear all;
%clc;

[fileRisultati, path] = uigetfile('*.mat','Seleziona il file .mat dei risultati');
% load Risultati3DCodiceMarino.mat;
pathCompleto = [path fileRisultati];
% load(fileRisultati);
load(pathCompleto);

timeStr = strrep(datestr(now),':','-');
k = strfind(fileRisultati,'.mat');
sourceStr = fileRisultati(1:k-1);
sName = ['Statistiche\', sourceStr, '\', timeStr];
mkdir(sName);
genuini1=0;
impostori1=0;
mediaGenuini=0;
mediaImpostori=0;
deviazioneGenuini=0;
deviazioneImpostori=0;
sp=1;
 T8=cell(sp,3);
 T9=cell2table(T8,'VariableNames',{'Utente1','Utente2','score'});
 k=0;
 
for i=1:41328
    Ut1=(T.Utente1(i));
    disp(T.Utente1(i));
    k=k+1;
     if i==1
         T9.(1)(i)=T.Utente1(i);  
     else   
      T9.(1)(i)=T.Utente2(i);
     end
      if k==425
          save('tabellaStringhei3D','T9'); 
          return;
      end   
end
 