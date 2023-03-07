function [a] = calcolaDimensioneMasse(f_ris, vl, rho_l, vc, rho_c, c)
    % Formula presa a pag 138 nel progetto del trasduttore
    a = (vl/(2 * pi * f_ris)) * atan(((rho_c * vc)/(rho_l * vl)) * (1/tan((2*pi*f_ris*c)/vc)));
end

