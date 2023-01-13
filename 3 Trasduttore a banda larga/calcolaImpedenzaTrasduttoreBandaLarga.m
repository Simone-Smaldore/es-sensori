function [Zin, FTT] = calcolaImpedenzaTrasduttoreBandaLarga(freq, areaPiezo, z_ceramica, v_materiale, C_0, z1, z2, spessore, h_33, M11, M12)
    Z_0_D = z_ceramica * areaPiezo;
    Z1 = z1 * areaPiezo;
    Z2 = z2 * areaPiezo;

    M = [M11 M12 0; 0 0 0; 0 0 0];
    % Matrice T (Simile a matrice G 2 ceramiche però accoppia ceramica e massa)
    A = calcolaMatriceA(Z_0_D, freq, v_materiale, spessore, h_33, C_0);
    T = calcolaMatriceG(A, M);
    B = calcolaMatriceB(T, Z1);

    Zin = abs((B(2,2) - ((B(1,2)^2)/(Z2+B(1,1)))));
    FTT = abs(Z2*B(1,2))/((B(2,2)*(B(1,1)+Z2)) - (B(2,1)*B(1,2)));

end

