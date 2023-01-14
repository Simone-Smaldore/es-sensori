clear; clc; close all;

addpath('../condivise');

useSingleCeramic = true;

inizializzaPiezo();

% 4) *** Condizioni al contorno ***
% **********************************************************************
rho_acqua = 997; % densità dell'acqua in [kg/m_3]
v_acqua = 1484; % velocità di propagazione dell'onda nell'acqua [m/s]

rho_aria = 1.225; % densità dell'aria in [kg/m_3]
v_aria = 343; % velocità di propagazione dell'onda nell'aria [m/s]

z_acqua = rho_acqua * v_acqua; % impedenza acustica specifica nell'acqua
z_aria = rho_aria * v_aria; % impedenza acustica specifica nell'aria
z_backing = 7e6;

perdite_meccaniche = 0.1e6; % perdite meccaniche per rispecchiare caso reale
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

% 5) *** Calcolo dei valori di interesse e plot dei grafici ***
% **********************************************************************
N_Campioni = 1000;
f_low = 0.5 * f_r;
f_high = 1.5 * f_r;
freq_vector = linspace(f_low, f_high, N_Campioni);
Zel = 1e7;

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
FTT = calcolaFTT(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, useSingleCeramic);
FTR = calcolaFTR(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Zel, useSingleCeramic);
FTT_i = FTT .* Zin; % FTT pilotata in corrente

max_to_plot = 1;
min_to_plot = 1;
stampaGrafici(freq_vector, Zin, FTT, FTR, min_to_plot, max_to_plot);
% *******************************************************************************

% 6) *** Confronto tra due diverse configurazioni ***
% **********************************************************************
Zin_conf_1 = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_aria, Z2_aria, useSingleCeramic);
FTT_conf_1 = calcolaFTT(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_aria, Z2_aria, useSingleCeramic);
FTR_conf_1 = calcolaFTR(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_aria, Zel, useSingleCeramic);
FTT_i_conf_1 = FTT_conf_1 .* Zin_conf_1; % FTT pilotata in corrente
% 
Zin_conf_2 = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_acqua, Z2_acqua, useSingleCeramic);
FTT_conf_2 = calcolaFTT(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_acqua, Z2_acqua, useSingleCeramic);
FTR_conf_2 = calcolaFTR(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1_acqua, Zel, useSingleCeramic);
FTT_i_conf_2 = FTT_conf_2 .* Zin_conf_2; % FTT pilotata in corrente

stampaSoloImpedenza = false;
stampaGraficiConfronto(freq_vector, Zin_conf_1, Zin_conf_2, FTT_conf_1, FTT_conf_2, FTR_conf_1, FTR_conf_2, stampaSoloImpedenza);
% *******************************************************************************
