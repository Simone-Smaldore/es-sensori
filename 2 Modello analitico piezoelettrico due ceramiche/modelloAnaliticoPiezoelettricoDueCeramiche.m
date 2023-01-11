clear; clc; close all;

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
Z_0_D = w * L * v * rho; % Impedenza acustica dell'elemento in direzione z
f_r = v / (2 * spessore); % Frequenza di risonanza 
% **********************************************************************

% 4) *** Condizioni al contorno ***
% **********************************************************************
rho_acqua = 997; % densità dell'acqua in [kg/m_3]
v_acqua = 1484; % velocità di propagazione dell'onda nell'acqua [m/s]

rho_aria = 1.225; % densità dell'aria in [kg/m_3]
v_aria = 343; % velocità di propagazione dell'onda nell'aria [m/s]

z_acqua = rho_acqua * v_acqua; % impedenza acustica specifica nell'acqua
z_aria = rho_aria * v_aria; % impedenza acustica specifica nell'aria
z_backing = 7e6;

perdite_meccaniche = 0.1; % perdite meccaniche per rispecchiare caso reale
z_acqua = z_acqua + perdite_meccaniche;
z_aria = z_aria + perdite_meccaniche;
z_backing = z_backing + perdite_meccaniche;

Z1_acqua = areaPiezo * z_acqua; % Mezzo z1 acqua
Z2_acqua = areaPiezo * z_acqua; % Mezzo z2 acqua
Z1_aria = areaPiezo * z_aria; % Mezzo z1 aria
Z2_aria = areaPiezo * z_aria; % Mezzo z2 aria
Z1_backing = areaPiezo * z_backing; % Mezzo z1 backing
Z2_backing = areaPiezo * z_backing; % Mezzo z2 backing

Z1 = areaPiezo * z_aria; % Mezzo z1 considerato
Z2 = areaPiezo * z_aria; % Mezzo z2 considerato

% **********************************************************************

% 5) *** Calcolo dei valori di interesse singola ceramica ***
% **********************************************************************
N_Campioni = 10000;
f_low = 0.5 * f_r;
f_high = 1.5 * f_r;
freq_vector = linspace(f_low, f_high, N_Campioni);
Zel = 1e7;

useSingleCeramic = true;

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
FTT = calcolaFTT(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
FTR = calcolaFTR(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Zel, useSingleCeramic);
% **********************************************************************

% 6) *** Calcolo dei valori di interesse per due ceramiche e plot dei grafici ***
% *******************************************************************************
useSingleCeramic = false;
spessore_half = spessore/2;
C_0_half = areaPiezo / (beta_33_S * spessore_half);

Zin_DC = calcolaZin(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, Z2, useSingleCeramic);
FTT_DC = calcolaFTT(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, Z2, useSingleCeramic);
FTR_DC = calcolaFTR(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, Zel, useSingleCeramic);

stampaGraficiDC(freq_vector, Zin, FTT, FTR, Zin_DC, FTT_DC, FTR_DC);
% *******************************************************************************

