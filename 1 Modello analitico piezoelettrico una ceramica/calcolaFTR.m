function FTR = calcolaFTR(Z_0_D, freq_vector, v, l, h_33, C_0, Z1, Zel)
    FTR = zeros(size(freq_vector));
    for i = 1:length(freq_vector)
        A = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
        B = calcolaMatriceB(A, Z1);
        FTR(i) = Zel * B(1, 2) / (B(1, 1) * (B(2, 2) + Zel) - B(1, 2)^2);
    end
end
