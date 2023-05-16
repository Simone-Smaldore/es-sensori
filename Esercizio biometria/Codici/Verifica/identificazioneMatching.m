clear all;
clc;

%Questo è lo script che si occupa del matching, l'unico parametro che va modificato in questa
%function è il numero di iterazioni indicato nel secondo ciclo for (riga 29). Questo numero deve 
%essere uguale al numero usato nella function matching2new e deve essere pari al numero di caratteristiche 
%che si desidera utilizzare

cartellaTemplate = uigetdir(pwd,'Seleziona la directory contenente i template:') ;
%cartellaTemplate=strcat(pwd,'\template\lines_template','\');
% cartellaTemplate=strcat(pwd,'\Sarli','\');
cartellaTemplate = strcat(cartellaTemplate,'\');
dirs=dir(fullfile(cartellaTemplate));

sp=1;
tabellaFinale=cell(sp,3);
[nomestructmat, pathstructmat]=uiputfile('.mat','Save struct .mat');
numeroCartella=3;       
numeroRisultato=1;
t=1;
tic;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = numeroCartella:length(dirs)
   cartella=strcat(cartellaTemplate,dirs(i).name,'\');
   files=dir(fullfile(cartella,'*.dat'));
   Template(:,i-2) = importdata(strcat(cartella,files(1).name));
end

for i = 1:26
    varianze(i,1) = var(Template(i,:));
end

%TempVar = [Template, varianze];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=numeroCartella:length(dirs) 
   cartella=strcat(cartellaTemplate,dirs(i).name,'\');
   files=dir(fullfile(cartella,'*.dat'));
   elementi=size(files,1);
   numeroFile=0;
   for contatore=1:elementi
     numeroFile=numeroFile+1;
     corrente=files(contatore).name(1:length(files(contatore).name)-4);
     primoTemplate=importdata(strcat(cartella,files(contatore).name));
     template1 = [primoTemplate(1:6); primoTemplate(20:23)];
     cartellaDaTestare=cartellaTemplate;            
     
     dirsDaTestare=dir(fullfile(cartellaDaTestare));
     for j=numeroCartella:length(dirsDaTestare)
        sottocartelleDaTestare=strcat(cartellaDaTestare,dirsDaTestare(j).name,'\');
        if(strcmp(cartella,sottocartelleDaTestare)==1)
            filesDaTestare=dir(fullfile(sottocartelleDaTestare,'*.dat'));
            elementiDaTestare=size(filesDaTestare,1);
            if(numeroFile<elementiDaTestare)
                for contatoreDaTestare=(numeroFile+1):elementiDaTestare
                    correnteFileDaTestare=files(contatoreDaTestare).name(1:length(files(contatoreDaTestare).name)-4);
                    secondoTemplate=importdata(strcat(sottocartelleDaTestare,files(contatoreDaTestare).name));
                    template2 = [secondoTemplate(1:6); secondoTemplate(20:23)];
                    [score] = matching2New(primoTemplate,secondoTemplate);
%                   [score] = matching2New(template1,template2);
%  
                    strcat(corrente, '-', correnteFileDaTestare, ' : ', num2str(score(1)))
                    
                    tabellaFinale(sp,1)={corrente};
                    tabellaFinale(sp,2)={correnteFileDaTestare};
                    tabellaFinale(sp,3)={score(1)};
                    sp=sp+1;
                    numeroRisultato=numeroRisultato+1;
                    
                    if sp==(t*20000)+1
                       T=cell2table(tabellaFinale, 'VariableNames',{'Utente1' 'Utente2' 'ScoreML'});
                       sp1=num2str(sp);
                       nomestructmat1=nomestructmat(1:length(nomestructmat)-4);
                       nomestructmat1=strcat(nomestructmat1,sp1,'.mat');
                       save([pathstructmat nomestructmat1],'T');
                       t=t+1;
                    end
                end
            end
        else

            filesDaTestare=dir(fullfile(sottocartelleDaTestare,'*.dat'));
            elementiDaTestare=size(filesDaTestare,1);
            for contDaTestare=1:elementiDaTestare
                corrFileDaTestare=filesDaTestare(contDaTestare).name(1:length(filesDaTestare(contDaTestare).name)-4);
                secondoTemplate=importdata(strcat(sottocartelleDaTestare,filesDaTestare(contDaTestare).name));
                
%                 [score] = matching2New(primoTemplate,secondoTemplate);
                [score] = matching2New(primoTemplate,secondoTemplate);
                template2 = [secondoTemplate(1:6); secondoTemplate(20:23)];
%                 [score] = matching2New(template1,template2);
                strcat(corrente, '-', corrFileDaTestare, ' : ', num2str(score(1)));
                
                tabellaFinale(sp,1)={corrente};
                tabellaFinale(sp,2)={corrFileDaTestare};
                tabellaFinale(sp,3)={score(1)};
                sp=sp+1;
                numeroRisultato=numeroRisultato+1;
                
                if sp==(t*20000)+1
                   T=cell2table(tabellaFinale, 'VariableNames',{'Utente1' 'Utente2' 'ScoreML'});
                   sp1=num2str(sp);
                   nomestructmat1=nomestructmat(1:length(nomestructmat)-4);
                   nomestructmat1=strcat(nomestructmat1,sp1,'.mat');
                   save([pathstructmat nomestructmat1],'T');
                   t=t+1;
                end
            end 
        end
     end
   end
   numeroCartella=numeroCartella+1;
   
end

tempoMatch = toc;

T = cell2table(tabellaFinale, 'VariableNames',{'Utente1' 'Utente2' 'ScoreML'});
tuttivalori = T.ScoreML;
tempo = tempoMatch/length(tuttivalori);
maxscore = max(tuttivalori);
T.ScoreML(:) = 1 - T.ScoreML(:)/maxscore;
    
%                   NORMALIZZAZIONE (non decommentare)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1 : size(T)
%    tuttivalori(i) = T.ScoreML(i); 
% end
% maxscore = max(tuttivalori);
% 
% for i = 1 : size(T)
% %    T.ScoreML(i) = T.ScoreML(i)/maxscore;
% T.ScoreML(i) = 1 - T.ScoreML(i)/maxscore;
%     
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save([pathstructmat nomestructmat],'T');