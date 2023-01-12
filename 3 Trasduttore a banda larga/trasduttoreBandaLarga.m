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
z_ceramica = v * rho; % Impedenza acustica specifica di questa tipologia di ceramica
Z_0_D = w * L * z_ceramica; % Impedenza acustica dell'elemento in direzione z
f_r = v / (2 * spessore); % Frequenza di risonanza 
% **********************************************************************

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

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z1);
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
