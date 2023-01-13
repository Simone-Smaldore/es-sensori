function [M11,M12] = calcolaMassaPrecarico(freq,v_materiale,rho_materiale,l_adatt,areaPiezo)
    Y = v_materiale^2 * rho_materiale; %Modulo di Young
    k = (2*pi*freq)/v_materiale;
    M11 = (k * areaPiezo * Y)/ (1i*2*pi*freq * tan(k * l_adatt));
    M12 = (k * areaPiezo * Y)/ (1i*2*pi*freq * sin(k * l_adatt));
end

