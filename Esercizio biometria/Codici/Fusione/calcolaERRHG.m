function [eer_y_ML]= statics3DnewHG(string)

load(string);

matchT=size(T3);
for i=1:matchT(1)
    Ut1=char(T3.Utente1(i));
    nomeUt1=Ut1(1:(length(Ut1)-4));
    cifreUt1=str2num(Ut1((length(Ut1)-2):end));

    Ut2=char(T3.Utente2(i));
    nomeUt2=Ut2(1:(length(Ut2)-4));
    cifreUt2=str2num(Ut2((length(Ut2)-2):end));
        
        if(strcmp(nomeUt1,nomeUt2)==1) %specificare l'uguaglianza tra stringhe
            T3.Genuino(i)=1; 
        else
        T3.Genuino(i)=0;        
        end
end

% save('punteggiProva_finale.mat','T');

genuino=0;
impostore=0;

tabellaGenuinoML=cell(1,3);
tabellaImpostoreML=cell(1,3);

match=size(T3);
for i=1:match(1)

    pri=T3{i,4};
    if (pri==1)
        genuino=genuino+1;
        tabellaGenuinoML(genuino,1)={T3.Utente1(i)};
        tabellaGenuinoML(genuino,2)={T3.Utente2(i)};
        scoml=(T3{i,3});
        if(scoml<1||scoml==1)
            sml=round((scoml)*100);
            tabellaGenuinoML(genuino,3)={sml};
        else
            tabellaGenuinoML(genuino,3)={'100'};
        end
    else
        
        impostore=impostore+1;
        tabellaImpostoreML(impostore,1)={T3.Utente1(i)};
        tabellaImpostoreML(impostore,2)={T3.Utente2(i)};
        scomci=(T3{i,3});
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



   
 



% save('vec_gen.mat','vec_gen');
% save('vec_imp.mat','vec_imp');
% 
% load vec_gen6.mat;
% load vec_imp.mat;

% normalizziamo le curve
max_genuino=max(vec_gen);
vett_norm_genuino=vec_gen/max_genuino;
max_impostore=max(vec_imp);
vett_norm_impostore=vec_imp/max_impostore;
approssimazione= 0.01;
intervalli= 1/approssimazione;


%calcoliamo il FAR
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
save('vettore_far3D3.mat','vettore_FAR');
%calcoliamo il FRR
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

save('vettore_frr3D3.mat','vettore_FRR');
%raffigriamo FAR e FRR insieme INTERPOLATI
far_interp=interp1(1:intervalli+1,vettore_FAR,1:.1:intervalli+1,'cubic'); %0.1 sarebbe dividere per 10 un tratto = 9 punti in più per ogni 2 punti del vettore... (12-1)*9 + 12
frr_interp=interp1(1:intervalli+1,vettore_FRR,1:.1:intervalli+1,'cubic'); %0.1 sarebbe dividere per 10 un tratto = 9 punti in più per ogni 2 punti del vettore... (12-1)*9 + 12




%cerchiamo il valore di intersezione tra FAR e FRR
dimensione=size(far_interp); % CALCOLO RIGA E COLONNE MATRICE
dimensionecolonne=dimensione(2);

for i=1:dimensionecolonne
    EER_Y(1,i)=abs((far_interp(1,i)-frr_interp(1,i)))/2;
    EER_X(1,i)=i*0.001;
end

[eer_y_3D eer_x2]=min(EER_Y);
eer_x_ML=(eer_x2-1)*0.001;  %soglia
eer_y_ML=far_interp(eer_x2);%probabilità di errore
disp(eer_y_ML);
save('EER_ML.mat','eer_x_ML','eer_y_ML');


vettore_far_ml=vettore_FAR.*100;

