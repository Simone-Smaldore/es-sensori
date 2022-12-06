clear; clc; close all;

% 1) *** Tipo di materiale ***
% **********************************************************************
% Scelgo di utilizzare il materiale Pz26 
c_33_D = 1.58E+11; % Costante elastica
h_33 = 2.37E+9; % Costante h(serve per il set di equazioni scelto nel modello thickness)
e_33 = 14.7; % Costante piezoelettrica
rho = 7.70E+3; % Densità di massa
% **********************************************************************


% 2) *** Geometria della piastra ***
% **********************************************************************
% Lunghezza e largezza in metri 
L = 0.05; % Lunghezza in metri
w = 0.05; % Larghezza in metri
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

% ?? Quale materiale considero ??
z_acqua = rho_acqua * v_acqua; % impedenza acustica nell'acqua
z_aria = rho_aria * v_aria; % impedenza acustica nell'aria

%Z1 = areaPiezo * z_acqua; % Mezzo z1 acqua
%Z2 = areaPiezo * z_acqua; % Mezzo z2 acqua
Z1 = areaPiezo * z_aria; % Mezzo z1 aria
Z2 = areaPiezo * z_aria; % Mezzo z2 aria
% **********************************************************************

% 5) *** Calcolo dei valori di interesse singola ceramica ***
% **********************************************************************
N_Campioni = 1000;
f_low = 0.7 * f_r;
f_high = 1.2 * f_r;
freq_vector = linspace(f_low, f_high, N_Campioni);

useSingleCeramic = true;

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
FTT = calcolaFTT(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
% ?? Da dove prendo Zel ??
% ?? Perchè più è alto e più si avvicina alla frequenza di risonanza ??
FTR = calcolaFTR(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, 10000, useSingleCeramic);
% **********************************************************************

% 6) *** Calcolo dei valori di interesse per due ceramiche e plot dei grafici ***
% *******************************************************************************
useDoubleCeramic = false;
spessore_half = spessore/2;
C_0_half = areaPiezo / (beta_33_S * spessore_half);

Zin_DC = calcolaZin(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, Z2, useDoubleCeramic);
FTT_DC = calcolaFTT(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, Z2, useDoubleCeramic);
FTR_DC = calcolaFTR(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z1, 10000, useDoubleCeramic);

stampaGraficiDC(freq_vector, Zin, FTT, FTR, Zin_DC, FTT_DC, FTR_DC);
% *******************************************************************************

