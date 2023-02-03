clear; clc; close all;
addpath('../condivise');

inizializzaPiezo();

% 4b) *** Condizioni al contorno specifiche ***
% **********************************************************************
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

