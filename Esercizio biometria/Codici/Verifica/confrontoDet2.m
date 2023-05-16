%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Questa funzione genera il grafico con diverse DET sovrapposte. 
% La funzione chiede di selezionare una cartella che deve contenere esclusivamente le strutture .mat
% ottenute dalle operazioni di matching che vogliamo rappresentare.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear
clc

directory = uigetdir('Seleziona la directory contenente i file .mat') ;

files = dir(directory);

figure3=figure;
axes1 = axes('Parent',figure3,'FontSize',32,'FontName','Times New Roman');
ylim(axes1,[0 5]);
xlim(axes1,[0 5]);
box(axes1,'on');
hold(axes1,'all');

lunghezza = (length(files)-2);
nomi = {};
for x = 3:length(files)
    % % DET Curve
    
    file = strcat(directory,'\',files(x).name);
    nomeFile = (files(x).name);
    
    nomeFile = strcat(nomeFile(1: end-5),{''},nomeFile(end-4: end-4));
    disp(nomeFile);
    load (file);

    %static 3d mio HG
    
    matchT=size(T);
    for i=1:matchT(1)
        if strcmp(nomeFile, '3D HG GF')
     %      disp('x');
           Ut1=char(T.Utente1(i));
        nomeUt1=Ut1(1:(length(Ut1)-4));
        cifreUt1=str2num(Ut1((length(Ut1)-2):end));

        Ut2=char(T.Utente2(i));
        nomeUt2=Ut2(1:(length(Ut2)-4));
        cifreUt2=str2num(Ut2((length(Ut2)-2):end));
       else
        
        Ut1=char(T.Utente1(i));
       nomeUt1=Ut1(1:(length(Ut1)-6));
        cifreUt1=str2num(Ut1((length(Ut1)-4):end));

       Ut2=char(T.Utente2(i));
       nomeUt2=Ut2(1:(length(Ut2)-6));
       cifreUt2=str2num(Ut2((length(Ut2)-4):end));
      end
           if((strcmp(nomeUt1,nomeUt2)==1)) %specificare l'uguaglianza tra stringhe
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
    
    % Aumentiamo il munero di punti di far ed frr
    
    
    
    % raffiguriamo FAR e FRR insieme INTERPOLATI
     far_interp=interp1(1:intervalli+1,vettore_FAR,1:.1:intervalli+1,'cubic'); %0.01 sarebbe dividere per 10 un tratto = 9 punti in più per ogni 2 punti del vettore... (12-1)*9 + 12
     frr_interp=interp1(1:intervalli+1,vettore_FRR,1:.1:intervalli+1,'cubic'); %0.01 sarebbe dividere per 10 un tratto = 9 punti in più per ogni 2 punti del vettore... (12-1)*9 + 12

    th= 1:intervalli+1;
    thq= 1:.01:intervalli+1;
     
    far_pippo=interp1(th,vettore_FAR,thq,'CUBIC'); 
    frr_pippo=interp1(th,vettore_FRR,thq,'CUBIC'); 

%    plot1=plot(th,vettore_FAR,'o',thq,far_interp,':.');
%    plot2=plot(th,vettore_FRR,'o',thq,frr_interp,':.');
     
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
    disp(eer_y_ML);
    EER_x=eer_y_ML*100;
    EER_y=eer_y_ML*100;
     
    save('EER_ML.mat','eer_x_ML','eer_y_ML');

    % % DET Curve

%    vettore_far_ml=vettore_FAR.*100;
%    vettore_frr_ml=vettore_FRR.*100;
    
    vettore_far_ml=far_interp.*100;
    vettore_frr_ml=frr_interp.*100;
    
    %c = polyfit(vettore_far_ml, vettore_frr_ml, 2);
    %vettore_frr_ml_approx = polyval(c, vettore_far_ml);
    if x==5
        disp('xxx');
        vettore_frr_ml_approx = smooth(vettore_far_ml, vettore_frr_ml, 0.02);
    else
    vettore_frr_ml_approx = smooth(vettore_far_ml, vettore_frr_ml, 0.02);
    end
    plot1=plot(vettore_far_ml,vettore_frr_ml_approx,'Parent',axes1,'LineWidth',1.5);
    
%    plot6=plot(vettore_far_ml,vettore_frr_ml,'Parent',axes1,'LineWidth',1.5);
    
    hold on;
    
    nomi = [nomi nomeFile];
    
    clear file;
end


x=[0 5];
y=[0 5];
plot7=plot(x,y,'k','LineWidth',0.1);

nomi = [nomi 'FAR = FRR'];
legend(nomi);

xlabel('False Acceptance Rate (%)','FontSize',32,'FontName','Times New Roman');
ylabel('False Rejection Rate (%)','FontSize',32,'FontName','Times New Roman');

x0=15;
y0=15;
width=960;
height=755;
set(gcf,'position',[x0,y0,width,height])
