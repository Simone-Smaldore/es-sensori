function FTT = calcolaFTTZVector(Z_0_D, freq_vector, v, l, h_33, C_0, Z1, Z2, singleCeramic)
    FTT = zeros(size(freq_vector));
    for i = 1:length(freq_vector)
        if singleCeramic
            A = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
            B = calcolaMatriceB(A, Z1(i));
        else
            A_1 = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
            A_2 = A_1; %Perchè consideriamo il caso con due ceramiche uguali
            G = calcolaMatriceG(A_1, A_2);
            B = calcolaMatriceB(G, Z1(i));
        end
        FTT(i) = Z2(i) * B(1, 2) / (B(2, 2) * (B(1, 1) + Z2(i)) - B(1, 2)^2);
    end
end
