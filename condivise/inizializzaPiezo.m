% 1) *** Tipo di materiale ***
% **********************************************************************
% Scelgo di utilizzare il materiale Pz21 
c_33_D = 1.58E+11; % Costante elastica
h_33 = 2.37E+9; % Costante h(serve per il set di equazioni scelto nel modello thickness)
e_33 = 14.7; % Costante piezoelettrica
rho = 7.70E+3; % Densità di massa
% **********************************************************************

% 2) *** Geometria della piastra ***
% **********************************************************************
% Lunghezza e largezza in metri 
L = 0.01; % Lunghezza in metri
w = 0.01; % Larghezza in metri
% Per il modello thickness deve essere molto minore a L e w
spessore = 0.002;% Spessore in metri
% **********************************************************************

% 3) *** Calcolo valori caratteristici data geometria e materiale ***
% **********************************************************************
beta_33_S = h_33 / e_33; % Si ottiene dalle relazioni tra le varie costanti 
areaPiezo = L*w; % Area della ceramica
C_0 = areaPiezo / (beta_33_S * spessore); % Capacità statica del piezoelettrico
v = sqrt(c_33_D/rho); % Velocità di propagazione delle onde elastiche
z_ceramica = v * rho; % Impedenza acustica specifica di questa tipologia di ceramica
Z_0_D = w * L * z_ceramica; % Impedenza acustica dell'elemento in direzione z
f_r = v / (2 * spessore); % Frequenza di risonanza 
% **********************************************************************