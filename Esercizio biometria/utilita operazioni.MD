OPERAZIONI SENSORI: 

1) Utilizzo lo script "Estrazione Render 2D e  TemplateHG-ROIPalmprint/carica_data.m" Andando a fornire in input la cartella "dati" all'interno del database delle acquisizioni. Questo script genera, sempre all'interno di questa cartella dati, le immagini 2D a profondità crescenti (100mm, 150mm, 200mm, ... , 800mm) a partire dal file .mat contenente le informazioni sull'acquisizione 3D ad ultrasuoni. 

--- Immagine Palmo ---

2) Utilizzo lo script "Estrazione Render 2D e  TemplateHG-ROIPalmprint/selezionaDBtemplate.m" per andare a generare, a partire dalla cartella dati del database, le ROI del palmo. Il risultato di questo script è quello di generare nella cartella "Estrazione Render 2D e  TemplateHG-ROIPalmprint" due cartelle:

	- DATABASE_RENDER_PALMOX: Contiene le immagini .jpg della ROI suddivise per profondità e per acquisizione
	- DATABASE_TEMPLATE_HandGeometryP: Contiene i file .dat 3D delle ROI suddivise per acquisizione 

--- Immagine ROI ---

3) (Probabilmente da non descrivere nella relazione) Utilizzo lo script "Estrazione Features Palmprint/riordinaDirectory.m" per riordinare le immagini appena generate ed ottenere la cartella "Fusione12_New" in modo da ottenere le immagini di varie profondità differenziate per acquisizione

4) Utilizzo lo script "Estrazione Features Palmprint/generaTemplate_LopreteSpera.m" per la generazione dei template associati alla specifica ROI del palmo. Ogni passo si divide in più sotto-passi:

	- Per prima cosa viene applicato un filtro gaussiano per l'eliminazione dello speckle
	- Effettuata una binarizzazione per ottenere valori bianchi e neri
	- Prendo i contorni lungo le 4 direzioni
	- Calcolo la matrice somma
	- Operazioni di chiusura(closing)
	- Operazioni di thinning 
	- Eliminazione tratti corti e isolati


TODO: Generare score per le tre configurazioni diverse analizzate e andare a valutare gli errori andando anche a graficare nella relazione

TODO: Commentare break per generazione template per analisi 3D