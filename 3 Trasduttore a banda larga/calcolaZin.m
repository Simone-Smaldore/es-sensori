function Zin = calcolaZin(Z_0_D, freq_vector, v, l, h_33, C_0, Z1, Z2)
    Zin = zeros(size(freq_vector));
    for i = 1:length(freq_vector)
        A = calcolaMatriceA(Z_0_D, freq_vector(i), v, l, h_33, C_0);
        B = calcolaMatriceB(A, Z1);
        Zin(i) = B(2, 2) - B(1, 2)^2/(Z2 + B(1, 1));
    end
end

