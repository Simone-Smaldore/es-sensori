function G = calcolaMatriceG(A, B)
    G_11 = A(1, 1) - A(1, 2)^2/(A(1, 1) + B(1, 1));
    G_12 = A(1, 2) * B(1, 2)/(A(1, 1) + B(1, 1));
    G_13 = A(1, 3) - A(1, 2)* A(1, 3)/(A(1, 1) + B(1,1)) + A(1, 2)* B(1, 3)/(A(1, 1) + B(1,1));
    G_21 = G_12;
    G_22 = B(1, 1) - B(1, 2)^2/(A(1, 1) + B(1, 1));
    G_23 = B(1, 3) - B(1, 2)* B(1, 3)/(A(1, 1) + B(1,1)) +  A(1, 3)*B(1, 2)/(A(1, 1) + B(1,1));
    G_31 = G_12/2;
    G_32 = G_13/2;
    % ?? Il /2 ci sta? 
    G_33 = A(3, 3) + B(3, 3) - B(1, 3)^2/(2*(A(1, 1) + B(1, 1))) - A(1, 3)^2/(2*(A(1, 1) + B(1, 1))) + A(1, 3) * B(1, 3)/(A(1, 1) + B(1, 1));
    G = [
        G_11 G_12 G_13;
        G_21 G_22 G_23;
        G_31 G_32 G_33;
    ];
    % ?? Devo dividere per 4 ?
    G = G/4;
end
