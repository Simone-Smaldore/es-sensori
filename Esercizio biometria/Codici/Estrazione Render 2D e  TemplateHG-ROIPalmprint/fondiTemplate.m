%--------------------------------------------------------------------------
%Questa function ci permette di generare i database dei medi, dei medi pesati e dei concatenati
%In particolare bisogna indicare nel vettore profonditiaNaming le profondità che si desidera utilizzare 
%per creare i nuovi database. In base al numero di profondità scelte è necessario commentare i codici 
%presenti nel for.

%Selezioniamo le profonditÃ  (decommentare il vettore profonditaNaming in base al numero di profonditÃ )
%profonditaNaming = [0.1 0.2];                  % 2 profonditÃ 
%profonditaNaming = [0.2 0.1 0.4];              %3 profonditÃ 
%profonditaNaming = [0.2 0.1 0.4 0.6];          %3 profonditÃ 
profonditaNaming = [ 150 200 250 300 350 400 450 500 550 600 650 700 750];      %5 profonditÃ 
%profonditaNaming = [0.2 0.1 0.4 0.6 0.5 0.3];  %6 profonditÃ


%Seleziona la directory con i template
directory = uigetdir(pwd,'Seleziona la directory contenente i Template:');

%Seleziona le directory per i salvataggi
directorySaveConcatenati  = uigetdir(pwd,'Seleziona la directory dove salvare i risultati concatenati:');
directorySaveMedi  = uigetdir(pwd,'Seleziona la directory dove salvare i risultati media:');
directorySaveMediPesati  = uigetdir(pwd,'Seleziona la directory dove salvare i risultati medi pesati:');

%Inizializziamo il vettore per il salataggio degli erroir
errori = [];

%Andiamo a calcorare gli errori
for i = 1:length(profonditaNaming)
    cartellaTemplate = [directory,'\',num2str(profonditaNaming(i)),'mm'];
    idMatch;
    errori = [errori EER_y];
    clear EER_y;
end

%Calcoliamo i pesi
pesi = sum(errori) ./ errori;
pesiNormalizzati = pesi ./ sum(pesi);

for g = 0 : 55
    for gg = 1 : 9
       try
%Le strutture che devono essere decommentate devono essere in numero pari a quello delle profondità
%indicate nel vettore profonditaNaming (esempio: se ho indicato tre profondità nel vettore vado a 
%commentare il codice relativo alle strutture DataFolder4/DataFolder5/DataFolder6)
            DataFolder1=[directory,'\',num2str(profonditaNaming(1)),'mm','\', num2str(g), '.', num2str(gg)];
            fileName1 = strcat(DataFolder1,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            A = importdata(fileName1);

            DataFolder2=[directory,'\',num2str(profonditaNaming(2)),'mm','\', num2str(g), '.', num2str(gg)];
            fileName2 = strcat(DataFolder2,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            B = importdata (fileName2);
            
            DataFolder3=[directory,'\',num2str(profonditaNaming(3)),'mm','\', num2str(g), '.', num2str(gg)];
            fileName3 = strcat(DataFolder3,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            C = importdata (fileName3);
            
            DataFolder4=[directory,'\',num2str(profonditaNaming(4)),'mm','\', num2str(g), '.', num2str(gg)]
            fileName4 = strcat(DataFolder4,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            D = importdata (fileName4);
            
            DataFolder5=[directory,'\',num2str(profonditaNaming(5)),'mm','\', num2str(g), '.', num2str(gg)];
            fileName5 = strcat(DataFolder5,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            E = importdata (fileName5);
             
			DataFolder6=[directory,'\',num2str(profonditaNaming(6)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName6 = strcat(DataFolder6,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			F = importdata (fileName6);
            
            DataFolder7=[directory,'\',num2str(profonditaNaming(7)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName7 = strcat(DataFolder7,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			G = importdata (fileName7);
            
            DataFolder8=[directory,'\',num2str(profonditaNaming(8)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName8 = strcat(DataFolder8,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			S = importdata (fileName8);
            
            DataFolder9=[directory,'\',num2str(profonditaNaming(9)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName9 = strcat(DataFolder9,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			I = importdata (fileName9);
            
            DataFolder10=[directory,'\',num2str(profonditaNaming(10)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName10 = strcat(DataFolder10,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			L = importdata (fileName10);
            
            DataFolder11=[directory,'\',num2str(profonditaNaming(11)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName11 = strcat(DataFolder11,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			M = importdata (fileName11);
            
            DataFolder12=[directory,'\',num2str(profonditaNaming(12)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName12 = strcat(DataFolder12,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			N = importdata (fileName12);
            
             DataFolder13=[directory,'\',num2str(profonditaNaming(13)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName13 = strcat(DataFolder13,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			O = importdata (fileName13);
            
             DataFolder14=[directory,'\',num2str(profonditaNaming(14)),'mm','\', num2str(g), '.', num2str(gg)];
			fileName14 = strcat(DataFolder14,'\',num2str(g),'.',num2str(gg),'_1','.dat');
			P = importdata (fileName14);
           
         
             
            
%Come per le strutture sopra è necessario decommentare i vettori Conc, H e MediPesati in base al numero
%di profondità indicate sopra

            %Genera i concatenati (decommentare il vettore Conc in base al numero di profonditÃ )
            %Conc = [A',B']';                   %per 2 profonditÃ 
            %Conc = [A',B',C']';                %per 3 profonditÃ 
            %Conc = [A',B',C', D']';            %per 4 profonditÃ 
            Conc = [B',C',D',E',F',G',S',I',L' M',N',O',P']';        %per 5 profonditÃ
            %Conc = [A',B',C', D', E', F']';    %per 6 profonditÃ 

            %Genera i medi (decommentare il vettore H in base al numero di profonditÃ )
            %H = [A, B];                        %per 2 profonditÃ 
            %H = [A, B, C];                     %per 3 profonditÃ 
            %H = [A, B, C,D];                   %per 4 profonditÃ 
            H = [B,C,D,E,F,G,S,I,L,M,N,O,P];               %per 5 profonditÃ 
            %H = [A, B, C, D, E, F];             %per 6 profonditÃ 
            Medi = mean(H,2);

            %Genera i medi pesati (decommentare il vettore MediPesati in base al numero di profonditÃ )
            %MediPesati = [A, B] * pesiNormalizzati';           %per 2 profonditÃ
            %MediPesati = [A, B, C] * pesiNormalizzati';        %per 3 profonditÃ 
            %MediPesati = [A, B, C, D] * pesiNormalizzati';     %per 4 profonditÃ
            MediPesati = [B,C,D,E,F,G,S,I,L, M,N,O,P] * pesiNormalizzati';  %per 5 profonditÃ
            %MediPesati = [A, B, C, D, E, F] * pesiNormalizzati';  %per 6 profonditÃ 
               
            disp(pesiNormalizzati');
            %Salva le nuove strutture
            DataFolder24 = [directorySaveConcatenati,'\',num2str(g),'.',num2str(gg)];
            mkdir(DataFolder24);
            fileNameSave24 = strcat(DataFolder24,'\',num2str(g),'.',num2str(gg),'_1','.dat');
            save(fileNameSave24,'Conc'); 

             DataFolder27 = [directorySaveMedi,'\',num2str(g),'.',num2str(gg)];
             mkdir(DataFolder27);
             fileNameSave27 = strcat(DataFolder27,'\',num2str(g),'.',num2str(gg),'_1','.dat');
             save(fileNameSave27,'Medi'); 
             
             DataFolder33 = [directorySaveMediPesati,'\',num2str(g),'.',num2str(gg)];
             mkdir(DataFolder33);
             fileNameSave33 = strcat(DataFolder33,'\',num2str(g),'.',num2str(gg),'_1','.dat');
             save(fileNameSave33,'MediPesati'); 
       catch
       end
        end
   
end