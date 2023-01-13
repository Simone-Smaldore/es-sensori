function [banda, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,array, banda)
    absArray = abs(array);
    [maxVal, indexMax] = max(absArray); %Prende la frequenza massima
    index1 = indexMax;
    index0 = indexMax;
    while true
        if(index1 == size(array, 2))
            break; % Per non eccedere gli indici
        end
        index1 = index1 + 1;
        if(mag2db(maxVal) - mag2db(absArray(index1)) > banda)
            break; % Raggiungo il limite di banda superiore
        end
    end 
    while true
        if(index0 == 1)
            break; % Per non eccedere gli indici
        end
        index0 = index0 - 1;
        if(mag2db(maxVal) - mag2db(absArray(index0)) > banda)
            break; % Raggiungo il limite di banda inferiore
        end
    end 
    banda = freq_vector(index1) - freq_vector(index0);
    freqCentroBanda = (freq_vector(index0) + freq_vector(index1)) / 2;
end

