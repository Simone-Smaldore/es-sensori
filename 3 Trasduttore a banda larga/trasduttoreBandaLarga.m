clear; clc; close all;
addpath('../condivise'); 

inizializzaPiezo();

% 4) *** Condizioni al contorno ***
% **********************************************************************
rho_acqua = 997; % densità dell'acqua in [kg/m_3]
v_acqua = 1484; % velocità di propagazione dell'onda nell'acqua [m/s]

z_acqua = rho_acqua * v_acqua; % impedenza acustica specifica nell'acqua
z_backing = 7e6;

perdite_meccaniche = 0.1e6; % perdite meccaniche per rispecchiare caso reale
z_acqua = z_acqua + perdite_meccaniche;
z_backing = z_backing + perdite_meccaniche;

Z1 = z_acqua * areaPiezo;
% **********************************************************************

% 5) *** Calcolo della frequenza di massimo spostamento ***
% **********************************************************************
N_Campioni = 10000;
f_low = 0.5 * f_r;
f_high = 1.5 * f_r;
freq_vector = linspace(f_low, f_high, N_Campioni);

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z1, true);
[Zmin, indexMin] = min(abs(Zin));
f0 = freq_vector(indexMin); % Trovo la frequenza di massimo spostamento del piezoelettrico
% **********************************************************************

% 6) *** Calcolo della Zin e della FTT del trasduttore con e senza backing ***
% **********************************************************************
[Zintrasduttore,FTTtrasduttore] = simulaTrasduttoreBandaLarga(freq_vector, f0, areaPiezo, v, rho, z_acqua, rho_acqua, z_acqua, z_acqua, C_0, spessore, h_33);
[Zintrasduttore_backing,FTTtrasduttore_backing] = simulaTrasduttoreBandaLarga(freq_vector, f0, areaPiezo, v, rho, z_acqua, rho_acqua, z_backing, z_acqua, C_0, spessore, h_33);
stampaGraficiConfronto(freq_vector, Zintrasduttore, FTTtrasduttore, Zintrasduttore_backing, FTTtrasduttore_backing);
% **********************************************************************


% 7) *** Calcolo delle informazioni sulla banda per le FTT ***
% **********************************************************************
bandaDb = 6;
disp(newline + "***** Banda FTT senza backing *****");
stampaInformazioniBanda(freq_vector, FTTtrasduttore, bandaDb, f0);
disp(newline + "***** Banda FTT con backing *****");
stampaInformazioniBanda(freq_vector, FTTtrasduttore_backing, bandaDb, f0);
% **********************************************************************
