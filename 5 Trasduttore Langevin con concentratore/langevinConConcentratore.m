clear; clc; close all;
addpath('../condivise'); 
addpath('../4 Trasduttore Langevin'); 

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

spessore_half = spessore/2; % valore di c visto che consideriamo metà del trasduttore nello studio
C_0_half = areaPiezo / (beta_33_S * spessore_half);
a_m1 = calcolaDimensioneMasse(freq_lavoro, v_titanio, rho_titanio, v, rho, spessore_half);
a_m2 = a_m1; % visto che le due masse sono uguali
% **********************************************************************

% 6) *** Calcolo delle impedenze acustiche in ingresso alle masse(Zacu) ***
% **********************************************************************
N_Campioni = 10000;
f_low = 0.3 * freq_lavoro;
f_high = 1.8 * freq_lavoro;
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
%stampaGraficiLangevin(Zin, Zin_new, FTT, FTT_new, FTT_i, FTT_i_new, freq_vector);
% **********************************************************************

% 11) *** Calcolo e setting dei valori necessari alla modellazione ***
% **********************************************************************
v_massa = v_titanio;
rho_massa = rho_titanio;
lambda = v_massa / freq_lavoro;
l_4 = lambda / 4; % criterio di progetto ottimale
l_3 = l_4;
w_exp = 0.0001; % lunghezza dell'esponenziale(Molto piccolo per simulare il gradino)
N = 2; % rapporto tra i raggi delle masse
% **********************************************************************

% 12) *** Calcolo Zacu ai capi delle masse ***
% **********************************************************************

Z_massa4 = calcolaZacu(freq_vector, v_massa, l_4, rho_massa, areaPiezo, Z1);
Z_concentratore = calcolaZConcentratore(v_massa, rho_massa, N, areaPiezo, w_exp, Z_massa4, freq_vector);

[Z_massa3, M11, M12] = calcolaZacuVector(freq_vector, v_massa, l_4, rho_massa, areaPiezo, Z_concentratore);
[Z_massa1] = calcolaZacu(freq_vector, v_massa, a_m1_new, rho_massa, areaPiezo, Z1);

[Zin_finale, FTT_finale] = calcolaParametriFinali(Z_0_D, freq_vector, v, spessore_half, h_33, C_0_half, Z_massa1, Z_massa3, Z1, M11, M12, true);
% **********************************************************************

% 13) *** Calcolo Keff ***
% **********************************************************************
keff = calcolaKeff(Zin_finale, freq_vector);
disp("Il keff è uguale a " + keff);
% **********************************************************************

% 14) *** Stampa grafici ***
% **********************************************************************
stampaGraficiLangevinConcentratore(Zin_finale, FTT_finale,freq_vector);
% **********************************************************************
   
