clear; clc; close all;
addpath('../condivise'); 

inizializzaPiezo();

% 4) *** Condizioni al contorno ***
% **********************************************************************
rho_acqua = 997; % densità dell'acqua in [kg/m_3]
v_acqua = 1484; % velocità di propagazione dell'onda nell'acqua [m/s]

rho_aria = 1.225; % densità dell'aria in [kg/m_3]
v_aria = 343; % velocità di propagazione  dell'onda nell'aria [m/s]

rho_titanio = 4.507 * 10^3; % Densità di massa del titanio [Kg/m^3]
v_titanio = 6100; % Velocità di propagazione nel titanio [m/s]

z_acqua = rho_acqua * v_acqua; % impedenza acustica specifica nell'acqua
z_aria = rho_aria * v_aria; % impedenza acustica specifica nell'aria
z_titanio = rho_titanio * v_titanio; % impedenza acustica specifica nel titanio


perdite_meccaniche = 0.1e6; % perdite meccaniche per rispecchiare caso reale
z_acqua = z_acqua + perdite_meccaniche;
z_aria = z_aria + perdite_meccaniche;

%TODO Eliminare
z_aria = 400;

Z1 = z_aria * areaPiezo;
Z0_massa_1 = z_titanio * areaPiezo; % Massa 1 in titanio
Z0_massa_2 = z_titanio * areaPiezo; % Visto che considereremo le masse uguali
% **********************************************************************

% 5) *** Calcolo della dimensione a delle masse ***
% **********************************************************************
freq_lavoro = 130 * 10^3; % Frequenza di lavoro di 130 KHz

%TODO Eliminare
freq_lavoro = 40 * 10^3; % [40 KHz]

spessore_half = spessore/2; % valore di c visto che consideriamo metà del trasduttore nello studio
a_m1 = calcolaDimensioneMasse(freq_lavoro, v_titanio, rho_titanio, v, rho, spessore);
a_m2 = a_m1; % visto che le due masse sono uguali
% **********************************************************************

% 6) *** Calcolo delle impedenze acustiche in ingresso alle masse(Zacu) ***
% **********************************************************************
N_Campioni = 1000;
f_low = 0.5 * freq_lavoro;
f_high = 1.5 * freq_lavoro;
freq_vector = linspace(f_low, f_high, N_Campioni);

%TODO Eliminare
freq_vector = [freq_lavoro - 20e3 : 1e1 : freq_lavoro + 20e3];

Y_titanio = v_titanio * v_titanio * rho_titanio; % Modulo di young del titanio
Zacu_m1 = calcolaZacu(freq_vector, v_titanio, a_m1, rho_titanio, areaPiezo, Z1);
Zacu_m2 = calcolaZacu(freq_vector, v_titanio, a_m2, rho_titanio, areaPiezo, Z1);
% **********************************************************************


% 7) *** Calcolo della Zin iniziale e modifica successiva ***
% **********************************************************************
useSingleCeramic = true;
Zin = calcolaZinZVector(Z_0_D, freq_vector, v, spessore, h_33, C_0, Zacu_m1, Zacu_m2, useSingleCeramic);
% **********************************************************************

plot(freq_vector, mag2db(abs(Zin)));