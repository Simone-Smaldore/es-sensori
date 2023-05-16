close all;
% clear all;
%clc;

[fileRisultati, path] = uigetfile('*.mat','Seleziona il file .mat dei risultati');
% load Risultati3DCodiceMarino.mat;
pathCompleto = [path fileRisultati];
% load(fileRisultati);
load(pathCompleto);
vettoreDifferenza=[];
sp=1;
T10=cell(sp,2);
T11=cell2table(T10,'VariableNames',{'Utente1','DiffNormalizzata2'});
for y=1:423
    
 Ut1=char(T9.Utente1(y));
 load (strcat('tabella423alfa3', Ut1,'.mat'));
 disp(Ut1);
vettoreImpostori=[];
vettoreGenuini=[];
T11.(1)(y)=T9.Utente1(y);

matchT=height(T20);%size(T);
   k=0;
for i=1:matchT(1)
   disp(y)
    if(strcmp(T20.Utente1(i),T9.Utente1(y))|strcmp(T20.Utente2(i),T9.Utente1(y)))
    k=k+1;
    
    disp(T20.Utente1(i));
    Ut1=char(T20.Utente1(i));
    Ut1=strrep(Ut1,'.dat','');
    nomeUt1=Ut1(1:(length(Ut1)-4));
    cifreUt1=str2num(Ut1((length(Ut1)-2):end));

    Ut2=char(T20.Utente2(i));
    Ut2=strrep(Ut2,'.dat','');
    nomeUt2=Ut2(1:(length(Ut2)-4));
    cifreUt2=str2num(Ut2((length(Ut2)-2):end));
        
        if(strcmp(nomeUt1,nomeUt2)==1) %specificare l'uguaglianza tra stringhe
            score=(T20{i,3});
           % genuini1=genuini1+1;
           % mediaGenuini=mediaGenuini+score;
            %T.Genuino(i)=1; 
            score2=cell2mat(score);
            vettoreGenuini(i)=score2;
        else
            score=(T20{i,3});
            %impostori1=impostori1+1;
           % mediaImpostori=mediaImpostori+score;
           score2=cell2mat(score);j
            vettoreImpostori(i)=score2;
       % T.Genuino(i)=0;
        end
        
    else
    disp('error');
    end

end


vettoreGenuini(vettoreGenuini==0)=[];
vettoreImpostori(vettoreImpostori==0)=[];
disp(126);
minimoGenuino=min(vettoreGenuini);
massimoImpostore=max(vettoreImpostori);
%disp(minimoGenuino);
%disp(massimoImpostore);
differenzaNormalizzata=(minimoGenuino-massimoImpostore)/minimoGenuino;
T11.(2)(y)={differenzaNormalizzata};
vettoreDifferenza(y)=differenzaNormalizzata;
disp(vettoreDifferenza(y));
end

vettoreDifferenza(vettoreDifferenza==0)=[];
save(strcat('vettoreDiffMinGenuino4232D','.mat'),'vettoreDifferenza'); 
save(strcat('tabellaDiffNormalizzataMinGenuino2','.mat'),'T11');  