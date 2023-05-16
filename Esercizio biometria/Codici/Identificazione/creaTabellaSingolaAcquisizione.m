close all;
% clear all;
%clc;

[fileRisultati, path] = uigetfile('*.mat','Seleziona il file .mat dei risultati');
% load Risultati3DCodiceMarino.mat;
pathCompleto = [path fileRisultati];
% load(fileRisultati);
load(pathCompleto);
load tabellaStringhe.mat


matchT=height(T);%size(T);



for i=1:425
   sp=1;
    k=0;
   Ut1=(T9.Utente1(i));
   Ut1X=char(Ut1);
   disp(Ut1X);
   T8=cell(sp,3);
   T20=cell2table(T8,'VariableNames',{'Utente1','Utente2','score'});
    for j=1:89253
      
       
       if isequal(Ut1,T.Utente1(j))||isequal( Ut1,T.Utente2(j))
           T20.(1)(j)=T.Utente1(j);
           T20.(2)(j)=T.Utente2(j);
           score=(T{j,3});
           T20.(3)(j)={score};
           
            k=k+1;
             
           if k==423
               disp(k);
           
               return;
           end
          
       end
    end
   
   save(strcat('tabellaYYYYYYYYY',Ut1X,'.mat'),'T20');  
end