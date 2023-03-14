function [Keff] = calcolaKeff(Zin, freq_vector)
    [val_min,index_min] = min(abs(Zin));
    [val_max,index_max] = max(abs(Zin));
    f_s = freq_vector(index_min);
    f_p = freq_vector(index_max);
    Keff2 = (f_p^2 - f_s^2)/ f_p^2;
    Keff = sqrt(Keff2);
end

