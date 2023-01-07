function [Zin, FTT] = calcolaImpedenzaTrasduttoreBandaLarga(freq, areaPiezo, z_ceramica, v_materiale, C_0, z1, z2, spessore, h_33, M11, M12)
    Z_0_D = z_ceramica * areaPiezo;
    Z1 = z1 * areaPiezo;
    Z2 = z2 * areaPiezo;

    A = calcolaMatriceA(Z_0_D, freq, v_materiale, spessore, h_33, C_0);
    T = zeros(3 ,3);
    B = zeros(2, 2);

    % Matrice T (Simile a matrice A 2 ceramiche)
    T(1,1) = A(1,1)-((A(1,2)^2/(A(1,1)+M11)));
    T(1,2) = A(1,2)*M12/(A(1,1)+M11);
    T(1,3) = A(1,3)-A(1,2)*A(1,3)/(A(1,1)+M11);
    T(2,1) = M12*A(1,2)/(A(1,1)+M11);
    T(2,2) = M11-(M12^2/(A(1,1)+M11));
    T(2,3) = A(1,3)*M12/(A(1,1)+M11);
    T(3,1) = A(1,3)-(A(1,3)*A(1,2))/(A(1,1)+M11);
    T(3,2) = A(1,3)*M12/(A(1,1)+M11);
    T(3,3) = A(3,3)-(A(1,3)^2)/(A(1,1)+M11);
        
    % Matrice B dalla matrice A (Simile a due ceramiche)
    B(1,1)=  T(2,2) -(T(2,1)*T(1,2))/(T(1,1)+Z1);
    B(1,2) = T(2,3)-(T(2,1)*T(1,3))/(T(1,1)+Z1);
    B(2,1) = T(3,2)-(T(3,1)*T(1,2))/(T(1,1)+Z1);
    B(2,2) = T(3,3)-(T(3,1)*T(1,3))/(T(1,1)+Z1);

    Zin = abs((B(2,2) - ((B(1,2)^2)/(Z2+B(1,1)))));
    FTT = abs(Z2*B(1,2))/((B(2,2)*(B(1,1)+Z2)) - (B(2,1)*B(1,2)));

end

