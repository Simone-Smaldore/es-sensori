function [ZinAbs, FTTAbs] = simulaTrasduttoreBandaLarga(freq_vector, f0,areaPiezo, v_materiale,rho_materiale, z_carico, rho_p, Z1, Z2, C_0, spessore, h_33)
    z_ceramica = v_materiale * rho_materiale;
    %Impendenza specifica di adattamento per la massimizzazione della banda passante
    z_p = (2*(z_carico^2)*z_ceramica)^(1/3); 
    v_p = z_p/rho_p; % Velocita' di propagazione
    lambda_adatt = v_p/f0;
    l_adatt = lambda_adatt/4; % Spessore finale piastra di adattamento

    n_freq = numel(freq_vector);
    ZinAbs = zeros(n_freq);
    FTTAbs = zeros(n_freq);
    for i = 1:n_freq
        [M11,M12] = calcolaMassaPrecarico(freq_vector(i),v_p,rho_p,l_adatt,areaPiezo);      
        [ZinAbs(i), FTTAbs(i)] = calcolaImpedenzaTrasduttoreBandaLarga(freq_vector(i), areaPiezo, z_ceramica, v_materiale, C_0, Z1, Z2, spessore, h_33, M11, M12);
    end
    ZinAbs = mag2db(abs(ZinAbs));
    FTTAbs = mag2db(abs(FTTAbs));
end

