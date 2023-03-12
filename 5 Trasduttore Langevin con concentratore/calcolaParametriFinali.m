function [Zin, FTT] = calcolaParametriFinali(Z_0_D, freq_vector, v, l, h_33, C_0, z1, zacu, z_carico, M11, M12, singleCeramic)
    Zin = zeros(size(freq_vector));
    FTT = zeros(size(freq_vector));
    for i = 1:length(freq_vector)
        ZL2 = z_carico;
        Z1 = z1(i);
        Zacu = zacu(i);
        if singleCeramic
            A = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
            B_11 = A(2, 2) - (A(1, 2)^2 / (Z1 + A(1, 1)));
            B_12 = A(1, 3) - (A(1, 2) * A(1, 3)) / (Z1 + A(1, 1));
            B_22 = A(3, 3) - (A(1, 3)^2 / (Z1 + A(1, 1)));
        else
            A_1 = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
            A_2 = A_1; %Perchè consideriamo il caso con due ceramiche uguali
            G = calcolaMatriceG(A_1, A_2);
            B_11 = G(2, 2) - (G(1, 2)^2 / (Z1 + G(1, 1)));
            B_12 = G(1, 3) - (G(1, 2) * G(1, 3)) / (Z1 + G(1, 1));
            B_22 = G(3, 3) - (G(1, 3)^2 / (Z1 + G(1, 1)));
        end

        Z4 = (M11(i) - ((M12(i)^2)/(ZL2 + M11(i))));
        Zin(i) = (B_22 - (B_12^2/(Zacu + B_11))) * (B_12/Z4);
        FTT(i) = (B_12 / ((B_22 * (B_11 + Zacu)) - B_12^2)) * (M12(i)/(ZL2 + M11(i)));
    end
end

