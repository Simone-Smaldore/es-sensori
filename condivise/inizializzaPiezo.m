% 1) *** Tipo di materiale ***
% **********************************************************************
% Scelgo di utilizzare il materiale Pz21 
c_33_D = 1.42E+11; % Costante elastica
h_33 = 1.34E+9; % Costante h(serve per il set di equazioni scelto nel modello thickness)
e_33 = 23.4; % Costante piezoelettrica
rho = 7.78E+3; % Densità di massa
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

% 4a) *** Condizioni al contorno generali ***
% **********************************************************************
rho_acqua = 997; % densità dell'acqua in [kg/m_3]
v_acqua = 1484; % velocità di propagazione dell'onda nell'acqua [m/s]

rho_aria = 1.225; % densità dell'aria in [kg/m_3]
v_aria = 343; % velocità di propagazione dell'onda nell'aria [m/s]

z_acqua = rho_acqua * v_acqua; % impedenza acustica specifica nell'acqua
z_aria = rho_aria * v_aria; % impedenza acustica specifica nell'aria
z_backing = 7e6;
% **********************************************************************