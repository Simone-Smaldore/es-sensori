function stampaInformazioniBanda(freq_vector,array,bandaDb, f0)
    freq_vector  = freq_vector./1e6;
    f0 = f0 ./1e6;
    [banda, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,array, bandaDb);
    bandaPercentuale = ((freq_vector(index1) - freq_vector(index0))/f0)*100;
    disp(newline + "Banda Passante: " + banda + "MHz");
    disp("f0: " + freq_vector(index0) + "MHz");
    disp("f1: " + freq_vector(index1) + "MHz");
    disp("freq centro banda: " + freqCentroBanda + "MHz");
    disp("banda percentuale: " + bandaPercentuale + "%");
end

