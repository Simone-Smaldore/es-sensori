function [a_new, Zin_new, Zacu_m1_new, Zacu_m2_new] = calcolaSpessoreRealeMasse(a, Zin, freq_lavoro, freq_vector, v_massa, rho_massa, areaPiezo, Z1, Z_0_D, v_ceramica, spessore_ceramica, h_33, C_0, useSingleCeramic)
    a_new = a;
    [~, indexMax] = min(abs(Zin));
    f_max = freq_vector(indexMax);
    dim_offset = a / 10;
    while abs(f_max - freq_lavoro) > 10
        if f_max > freq_lavoro
            a_new = a_new + dim_offset;
        else
            a_new = a_new - dim_offset;
        end
        Zacu_m1_new = calcolaZacu(freq_vector, v_massa, a_new, rho_massa, areaPiezo, Z1);
        Zacu_m2_new = calcolaZacu(freq_vector, v_massa, a_new, rho_massa, areaPiezo, Z1);
        Zin_new = calcolaZinZVector(Z_0_D, freq_vector, v_ceramica, spessore_ceramica, h_33, C_0, Zacu_m1_new, Zacu_m2_new, useSingleCeramic);

        [~, indexMax] = min(abs(Zin_new));
        f_max = freq_vector(indexMax);
        dim_offset = 0.8 * dim_offset;
    end
end

