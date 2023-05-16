load vettoreDiffMinGenuino4232D.mat;

w=0;
for i=1:423
    
if(vettoreDifferenza(i)<0.2 &&vettoreDifferenza(i)>0.0)
    
    disp(vettoreDifferenza(i));
    w=w+1;
end

end
disp(w);