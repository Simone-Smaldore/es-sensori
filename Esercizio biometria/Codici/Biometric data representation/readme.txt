



1. eseguire passaggio_UOB_BSCAN.m per ottenere i BSCAN, partendo dal nome del file .uob di cui si vogliono generare i BSCAN.
I BSCAN verrano salvati in una cartella che chiameremo BSCAN,

2. partendo dai BSCAN, eseguire preprocessing_crop_fisso.m o preprocessing_bio.m che chiama init_bio.m, probes_bio.m, depths_bio.m, data_bio.m, crop_fisso.m(crop_bio se si esegue preprocessing_bio.m):
-in init_bio vengono settati i pararametri: probeselection=3,depthselection=1 e stepsize=0.2 che corrispondono al tipo di sonda, alla profonditàe alla dimensione dello step;
	
-in probes_bio vengono settati dei parametri in base al tipo di sonda: in questo caso phys_pitch=0.2 e repr_pitch=0.2, poichè
probeselection=3 che corrisponde alla sonda ESAOTE LA424;
	
-in depths_bio viene definità la profondità di scansione in base al tipo di sonda: in questo caso abbiamo pixel_length=0.0924 che corrisponde alla profondità di scansione pari a 41 mm;
	
-in data_bio.m vengono memorizzati i BSCAN in una matrice 3D e definiamo le direzioni laterali di scansione elettronica e meccanica X e Y elettronica e la direzione assiale z;
	
-in crop_fisso.m eseguiamo il crop fisso della regione di interesse(ROI), selezionando la regione da prendere in considerazione per le analisi. In crop.bio a differenza dell'altra procedura, eseguiamo manualmente il crop della regione di interesse. 
  
In output alla procedura preprocessing_crop_fisso.m otteniamo il file.mat che corrisponde alla matrice tridimensionale relativa alla regione di interesse.
  
  
3. eseguire render3d_bio.m partendo dal file .mat ottenuto in precedenza e ottenendo l'immagine in 3D della ROI.
  
   





