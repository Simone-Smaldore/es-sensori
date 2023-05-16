load 'Concatenati.mat';
load 'Tabella111__350_alfa=6_dil5_nuova4.mat';

[EER_HG]= calcolaEERHG('Concatena..mat');
[EER_Palm]= calcolaEERPalm('Tabella111__350_alfa=4_dil5_nuova4');


pesoPalm= (1/EER_Palm)/((1/EER_Palm)+(1/EER_HG))

pesoHG= (1/EER_HG)/((1/EER_Palm)+(1/EER_HG))
matchT=size(T) ;
%for i=1:matchT(1)
   %  disp(i);
    %Utente1=char(T.Utente1(i));
    
    %Ut1=strrep(Utente1,'_1','');
    %Utente2=char(T.Utente2(i));
    %Ut2=strrep(Utente2,'_1','');
    %for j=1:matchT(1)
       % Utente12=char(T3.Utente1(j));
        %Ut12=strrep(Utente12,'_1','');
        %Utente22=char(T3.Utente2(j));
       %Ut22=strrep(Utente22,'_1','');
          %T3.Utente2(i)= T.Utente2(i);
          %T3.Utente1(i)= T.Utente1(i);
     %if (strcmp(Ut2,Ut22)==1 && strcmp(Ut1,Ut12)==1)||(strcmp(Ut1,Ut22)==1 && strcmp(Ut2,Ut12)==1)
       %  disp(Ut22);
         %T3{j,3}=T{i,3};

        %T3{j,3}=scoml
        %disp( T3{j,3});
     %end
    %end       
%end  
    
      %||(strcmp(Ut1,Ut22)==1 && strcmp(Ut2,Ut12)==1)
            %disp(Ut12);
            
            
     
 
    
       



for i=1:matchT(1)
     
  scom1=(T{i,3});
  scom2=(T3{i,3});
    
  scom3=pesoPalm*scom2+pesoHG*scom1;
  T{i,3}=scom3;
    
end  
save('WeightedFusion.mat', 'T');