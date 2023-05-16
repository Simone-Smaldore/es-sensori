
%questa procedura 'pulisce' l'acqua dagli eventuali spot luminosi 
%che si manifestano nei B-scan 
%in uscita produce una matrice logica 3D S che separa il palmo dall'acqua
DataObj=DataUlaopBaseBand(fileUOB);

h=ones(9);
h(1,[1:3 7:9])=0;
h(9,[1:3 7:9])=0;
h([1:3 7:9],9)=0;
h([1:3 7:9],1)=0;
% dimZ=512;
% dimY=128;
% dimX=160; 
dimZ=256;
dimX=192; 
dimY=250;

S=ones(dimZ,dimX,dimY)>0;
K=zeros(dimX,dimY);
for i=1:dimY
    Read(DataObj,'firstPri',dimX*(i-1)+1,'npri',dimX);
    x=DataObj.LastReadData;
    x=abs(x);
    x=20*log10(x/max(max(x)));
    x(x<-50)=-50; %-50 si potrebbe modificare
    m=medfilt2(x,[3 2]);
    e=imerode(m,h);
    d=imdilate(e,h);
    for j=1:dimX
        k=(find(d(:,j)>-45,1));
        if isempty(k)
            k=dimZ;
        end
        S(1:k,j,i)=(1==0);
        K(j,i)=dimZ-k;
    end
end



