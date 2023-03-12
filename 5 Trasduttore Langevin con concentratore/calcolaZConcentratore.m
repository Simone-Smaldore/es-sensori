function [Z_concentratore] = calcolaZConcentratore(v_materiale, rho_materiale, N, areaPiezo, w_exp, Z_t, freq_vector)
    beta = log(N) / w_exp;
    Z_concentratore = zeros(1, numel(freq_vector));
    Y = v_materiale * v_materiale * rho_materiale; % Modulo di Young
    for i = 1 : numel(freq_vector)
        f = freq_vector(i);
        omega = 2 * pi * f;
        k_c = omega / v_materiale;

        T11 = 1i * ((areaPiezo * Y) / omega) * (beta - (k_c / tan(k_c * w_exp)));
        T12 = (areaPiezo * Y * k_c * exp(-beta * w_exp)) / (1i * omega * sin(k_c * w_exp));
        T22 = 1i * ((areaPiezo * Y) / omega) * (beta + (k_c / tan(k_c * w_exp)));
        T21 = (areaPiezo * Y * k_c * exp(beta * w_exp)) / (1i * omega * sin(k_c * w_exp));   

        Z_concentratore(1, i) = T11 - ((T12 * T21)/(Z_t(i) + T22));
    end
end

