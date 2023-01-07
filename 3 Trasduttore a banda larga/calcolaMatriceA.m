function A = calcolaMatriceA(Z_0_D, f, v, l, h_33, C_0)
    omega = 2 * pi * f;
    k =  omega / v;
    A_11 = Z_0_D/(1i * tan(k*l));
    A_12 = Z_0_D/(1i * sin(k*l));
    A_13 = h_33/(1i * omega);
    A_21 = Z_0_D/(1i * sin(k*l));
    A_22 = Z_0_D/(1i * tan(k*l));
    A_23 = h_33/(1i * omega);
    A_31 = h_33/(1i * omega);
    A_32 = h_33/(1i * omega);
    A_33 = 1/(1i * omega * C_0);
    A = [
        A_11 A_12 A_13;
        A_21 A_22 A_23;
        A_31 A_32 A_33;
    ];
end