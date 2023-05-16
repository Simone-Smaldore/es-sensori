cartellaTemplate = strcat(cartellaTemplate,'\');
dirs=dir(fullfile(cartellaTemplate));

sp=1;
tabellaFinale=cell(sp,3);

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
                    [score] = matching2New(primoTemplate,secondoTemplate, varianze);
 
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

                [score] = matching2New(primoTemplate,secondoTemplate);
                template2 = [secondoTemplate(1:6); secondoTemplate(20:23)];
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

matchT=size(T);
for i=1:matchT(1)
    Ut1=char(T.Utente1(i));
    nomeUt1=Ut1(1:(length(Ut1)-4));
    cifreUt1=str2num(Ut1((length(Ut1)-2):end));

    Ut2=char(T.Utente2(i));
    nomeUt2=Ut2(1:(length(Ut2)-4));
    cifreUt2=str2num(Ut2((length(Ut2)-2):end));
        
        if(strcmp(nomeUt1,nomeUt2)==1) %specificare l'uguaglianza tra stringhe
            T.Genuino(i)=1; 
        else
        T.Genuino(i)=0;        
        end
end

genuino=0;
impostore=0;

tabellaGenuinoML=cell(1,3);
tabellaImpostoreML=cell(1,3);

match=size(T);
for i=1:match(1)

    pri=T{i,4};
    if (pri==1)
        genuino=genuino+1;
        tabellaGenuinoML(genuino,1)={T.Utente1(i)};
        tabellaGenuinoML(genuino,2)={T.Utente2(i)};
        scoml=(T{i,3});
        if(scoml<1||scoml==1)
            sml=round((scoml)*100);
            tabellaGenuinoML(genuino,3)={sml};
        else
            tabellaGenuinoML(genuino,3)={'100'};
        end
    else
        
        impostore=impostore+1;
        tabellaImpostoreML(impostore,1)={T.Utente1(i)};
        tabellaImpostoreML(impostore,2)={T.Utente2(i)};
        scomci=(T{i,3});
        if(scomci<1 || scomci==1)
            smci=round((scomci)*100);
            tabellaImpostoreML(impostore,3)={smci};
        else
            tabellaImpostoreML(impostore,3)={'100'};
        end
    end
end
% 
% GRAFICI PER ML
TabGenML = cell2table(tabellaGenuinoML, 'VariableNames',{'Utente1' 'Utente2' 'Score'});
TabImpML = cell2table(tabellaImpostoreML, 'VariableNames',{'Utente1' 'Utente2' 'Score'});

vec_gen=zeros(1,100);
vec_imp=zeros(1,100);

dime=size(TabGenML);
for i=1:dime(1)
   valore=TabGenML.Score(i);
  
 %  valore=valore(1,1);
    
 if(valore==0)
       vec_gen(1,valore+1)=vec_gen(1,valore+1)+1;
 else 
       vec_gen(1,valore)=vec_gen(1,valore)+1;
 end

%   vec_gen(1,valore)=vec_gen(1,valore)+1; ho aggiunto if else end
end

% save('vec_gen.mat','vec_gen');
% load vec_gen_Puliti.mat;

dime=size(TabImpML);
for i=1:dime(1)
   valore=TabImpML.Score(i);
  %  valore=valore(1,1);
   if(valore==0)
       vec_imp(1,valore+1)=vec_imp(1,valore+1)+1;
   else
        vec_imp(1,valore)=vec_imp(1,valore)+1;
   end

%    vec_imp(1,valore)=vec_imp(1,valore)+1; ho aggiunto if else end
end

% normalizziamo le curve
max_genuino=max(vec_gen);
vett_norm_genuino=vec_gen/max_genuino;
max_impostore=max(vec_imp);
vett_norm_impostore=vec_imp/max_impostore;
approssimazione= 0.01;
intervalli= 1/approssimazione;

% calcoliamo il FAR
indice=0;
for soglia=0:approssimazione:1
    indice=indice+1;
    if(soglia>0) %il vettore 'vettore_ricorrenze_impostori' ha come prima posizione il valore di precisione_approssimazione e non parte da 0
        somma=0;
        for i=1:(soglia/approssimazione)
            if(vec_imp(1,i)>0)
                somma=somma+vec_imp(1,i);
            end
        end
        vettore_FAR(1,indice)=(sum(vec_imp)-somma)/sum(vec_imp);
    else
        vettore_FAR(1,indice)=1;
    end
end

% calcoliamo il FRR
indice=0;
for soglia=0:approssimazione:1
    indice=indice+1;
    if(soglia>0) %il vettore 'vettore_ricorrenze_impostori' ha come prima posizione il valore di precisione_approssimazione e non parte da 0
        somma=0;
        for i=1:(soglia/approssimazione)
            if(vec_gen(1,i)>0)
                somma=somma+vec_gen(1,i);
            end
        end
        vettore_FRR(1,indice)=somma/sum(vec_gen);
    else
        vettore_FRR(1,indice)=0;
    end
end

far_interp=interp1(1:intervalli+1,vettore_FAR,1:.1:intervalli+1,'cubic');
frr_interp=interp1(1:intervalli+1,vettore_FRR,1:.1:intervalli+1,'cubic');

% cerchiamo il valore di intersezione tra FAR e FRR
dimensione=size(far_interp); % CALCOLO RIGA E COLONNE MATRICE
dimensionecolonne=dimensione(2);

for i=1:dimensionecolonne
    EER_Y(1,i)=abs((far_interp(1,i)-frr_interp(1,i)))/2;
    EER_X(1,i)=i*0.001;
end

[eer_y_3D eer_x2]=min(EER_Y);
eer_x_ML=(eer_x2-1)*0.001;  %soglia
eer_y_ML=far_interp(eer_x2);%probabilità di errore

save('EER_ML.mat','eer_x_ML','eer_y_ML');

EER_x=eer_y_ML*100;
EER_y=eer_y_ML*100;