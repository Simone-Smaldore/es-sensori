clear; clc; close all;
addpath('../condivise'); 

inizializzaPiezo();

% 4b) *** Condizioni al contorno specifiche ***
% **********************************************************************
rho_titanio = 4.507 * 10^3; % Densità di massa del titanio [Kg/m^3]
v_titanio = 6100; % Velocità di propagazione nel titanio [m/s]

Z1 = z_aria * areaPiezo;
% **********************************************************************

% 5) *** Calcolo della dimensione a delle masse ***
% **********************************************************************
freq_lavoro = 130 * 10^3; % Frequenza di lavoro di 130 KHz

spessore_half = spessore/2; % valore di c visto che consideriamo metà del trasduttore nello studiO
a_m1 = calcolaDimensioneMasse(freq_lavoro, v_titanio, rho_titanio, v, rho, spessore_half);
a_m2 = a_m1; % visto che le due masse sono uguali
% **********************************************************************

% 6) *** Calcolo delle impedenze acustiche in ingresso alle masse(Zacu) ***
% **********************************************************************
N_Campioni = 10000;
f_low = 0.7 * freq_lavoro;
f_high = 1.3 * freq_lavoro;
freq_vector = linspace(f_low, f_high, N_Campioni);

%Y_titanio = v_titanio * v_titanio * rho_titanio; % Modulo di young del titanio
Zacu_m1 = calcolaZacu(freq_vector, v_titanio, a_m1, rho_titanio, areaPiezo, Z1);
Zacu_m2 = calcolaZacu(freq_vector, v_titanio, a_m2, rho_titanio, areaPiezo, Z1);
% **********************************************************************


% 7) *** Calcolo della Zin iniziale ***
% **********************************************************************
useSingleCeramic = true;
Zin = calcolaZinZVector(Z_0_D, freq_vector, v, spessore, h_33, C_0, Zacu_m1, Zacu_m2, useSingleCeramic);
% **********************************************************************

% 8) *** Modifica dello spessore delle masse per rispecchiare il criterio di progetto ***
% **********************************************************************
[a_m1_new, Zin_new, Zacu_m1_new, Zacu_m2_new] = calcolaSpessoreRealeMasse(a_m1, Zin, freq_lavoro, freq_vector, v_titanio, rho_titanio, areaPiezo, Z1, Z_0_D, v, spessore, h_33, C_0, useSingleCeramic);
a_m2_new = a_m1_new; % Sempre per simmetria si calcola solo uno dei valori
% **********************************************************************

% 9) *** Calcolo della FTT iniziale e con nuova massa ***
% **********************************************************************
FTT = calcolaFTTZVector(Z_0_D, freq_vector, v, spessore, h_33, C_0, Zacu_m1, Zacu_m2, useSingleCeramic);
FTT_i = FTT .* Zin; % FTT pilotata in corrente
FTT_new = calcolaFTTZVector(Z_0_D, freq_vector, v, spessore, h_33, C_0, Zacu_m1_new, Zacu_m2_new, useSingleCeramic);
FTT_i_new = FTT_new .* Zin_new; % FTT pilotata in corrente
% **********************************************************************

% 10) *** Stampa dei grafici ***
% **********************************************************************
stampaGraficiLangevin(Zin, Zin_new, FTT, FTT_new, FTT_i, FTT_i_new, freq_vector);
% **********************************************************************

% 11) *** Calcolo valori per due ceramiche ***
% **********************************************************************
C_0_half = areaPiezo / (beta_33_S * spessore_half);
a_m1_dc = calcolaDimensioneMasse(freq_lavoro, v_titanio, rho_titanio, v, rho, spessore_half);
a_m2_dc = a_m1_dc; % visto che le due masse sono uguali
Zacu_m1_dc = calcolaZacu(freq_vector, v_titanio, a_m1_dc, rho_titanio, areaPiezo, Z1);
Zacu_m2_dc = calcolaZacu(freq_vector, v_titanio, a_m2_dc, rho_titanio, areaPiezo, Z1);
useSingleCeramic = false;
Zin_dc = calcolaZinZVector(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Zacu_m1_dc, Zacu_m2_dc, useSingleCeramic);
[a_m1_dc_new, Zin_dc_new, Zacu_m1_dc_new, Zacu_m2_dc_new] = calcolaSpessoreRealeMasse(a_m1_dc, Zin_dc, freq_lavoro, freq_vector, v_titanio, rho_titanio, areaPiezo, Z1, Z_0_D, v, spessore_half, h_33, C_0_half, useSingleCeramic);
a_m2_dc_new = a_m1_dc_new; % Sempre per simmetria si calcola solo uno dei valori
FTT_dc = calcolaFTTZVector(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Zacu_m1_dc, Zacu_m2_dc, useSingleCeramic);
FTT_dc_new = calcolaFTTZVector(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Zacu_m1_dc_new, Zacu_m2_dc_new, useSingleCeramic);
FTT_dc_i = FTT_dc .* Zin_dc;
FTT_dc_i_new = FTT_dc_new .* Zin_dc_new;

stampaGraficiConfronto(Zin, Zin_new, Zin_dc, Zin_dc_new, freq_vector);
% **********************************************************************


