clear; clc; close all;
addpath('../condivise'); 

inizializzaPiezo();

% 4b) *** Condizioni al contorno specifiche ***
% **********************************************************************
perdite_meccaniche = 0.1e6; % perdite meccaniche per rispecchiare caso reale
z_acqua = z_acqua + perdite_meccaniche;
z_backing = z_backing + perdite_meccaniche;

rho_titanio = 4.507 * 10^3; % Densità di massa del titanio [Kg/m^3]
v_titanio = 6100; % Velocità di propagazione nel titanio [m/s]
z_titanio = rho_titanio * v_titanio;

Z1 = z_backing * areaPiezo;
Z2 = z_acqua * areaPiezo;
% **********************************************************************

% 5) *** Calcolo della frequenza di massimo spostamento ***
% **********************************************************************
N_Campioni = 10000;
f_low = 0.5 * f_r;
f_high = 1.5 * f_r;
freq_vector = linspace(f_low, f_high, N_Campioni);

Zin = calcolaZin(Z_0_D, freq_vector, v, spessore, h_33, C_0, Z1, Z2, true);
[Zmin, indexMin] = min(abs(Zin));
f0 = freq_vector(indexMin); % Trovo la frequenza di massimo spostamento del piezoelettrico
% **********************************************************************

% 6) *** Calcolo della Zin e della FTT del trasduttore con e senza backing ***
% **********************************************************************
bandaDb = 6;

intOffset = 0;
[Zintrasduttore,FTTtrasduttore, spessorePiastraIniziale] = simulaTrasduttoreBandaLarga(freq_vector, f0, areaPiezo, v, rho, z_acqua, rho_acqua, z_acqua, z_acqua, C_0, spessore, h_33, intOffset);
[Zintrasduttore_backing,FTTtrasduttore_backing, spessorePiastraInizialeBacking] = simulaTrasduttoreBandaLarga(freq_vector, f0, areaPiezo, v, rho, z_acqua, rho_acqua, z_backing, z_acqua, C_0, spessore, h_33, intOffset);

stampaGraficiConfronto(freq_vector, Zintrasduttore, FTTtrasduttore, Zintrasduttore_backing, FTTtrasduttore_backing, bandaDb);
% **********************************************************************


% 7) *** Calcolo delle informazioni sulla banda per le FTT ***
% **********************************************************************
disp(newline + "***** Banda FTT senza backing *****");
stampaInformazioniBanda(freq_vector, FTTtrasduttore, bandaDb, f0);
disp(newline + "***** Banda FTT con backing *****");
stampaInformazioniBanda(freq_vector, FTTtrasduttore_backing, bandaDb, f0);
% **********************************************************************

[banda_0, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,FTTtrasduttore_backing, bandaDb);

% 8) *** Calcolo dello spessore ottimale all'ampiezza di banda ***
% **********************************************************************
numOffset = 15;
linspaceArray = linspace(-numOffset, numOffset, numOffset*2 + 1);
analisiBacking = true;
if analisiBacking
    ZBack = z_backing;
else
    ZBack = z_acqua;
end

%figure;
bandaMax = -Inf;
for i = linspaceArray
    [Zintrasduttore,FTTtrasduttore, spessorePiastra] = simulaTrasduttoreBandaLarga(freq_vector, f0, areaPiezo, v, rho, z_acqua, rho_acqua, ZBack, z_acqua, C_0, spessore, h_33, i);
    [banda, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,FTTtrasduttore, bandaDb);
    if banda > bandaMax
        bandaMax = banda;
        maxOffset = i;
        spessoreMax = spessorePiastra;
    end
    %plot(freq_vector, mag2db(abs(FTTtrasduttore)));
    %hold on;
end
disp(newline + "La banda massima si raggiunge per offset " + maxOffset + " con spessore " + spessoreMax +  " metri ed è uguale a " +  bandaMax/1e6 + " MHz");
% **********************************************************************
