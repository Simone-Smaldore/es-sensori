function [Zacu] = calcolaZacu(freq_vector, v_materiale, l, rho_materiale, areaPiezo, Z_L)
% Formula trovata a pag 123
    Zacu = zeros(1, numel(freq_vector));
    for i=1:numel(freq_vector)
        [M11, M12] = calcolaMassaPrecarico(freq_vector(i), v_materiale, rho_materiale,l ,areaPiezo);
        Zacu(i) = M11 - ((M12)^2 / (Z_L + M11));
    end
end