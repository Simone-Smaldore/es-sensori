function stampaGraficiConfronto(freq_vector, Zin_aria, Zin_acqua, FTT_aria, FTT_acqua, FTR_aria, FTR_acqua, stampaSoloImpedenza)
    freq_vector = freq_vector./1e6;

    figure;
    set(gcf,'WindowState','maximized')

    if stampaSoloImpedenza
        subplot(1,1,1)
        semilogy(freq_vector, abs(Zin_aria))
       
        hold on
        semilogy(freq_vector, abs(Zin_acqua))
        grid on
        title('Impedenza')
        xlabel('frequenza [MHz]')
        ylabel('Zin [Ohm]')
    else
        subplot(3,1,1)
        semilogy(freq_vector, abs(Zin_aria))
       
        hold on
        semilogy(freq_vector, abs(Zin_acqua))
        grid on
        title('Impedenza')
        xlabel('frequenza [MHz]')
        ylabel('Zin [Ohm]')
    
        subplot(3,1,2)
        plot(freq_vector, mag2db(abs(FTT_aria)))
        hold on
        plot(freq_vector, mag2db(abs(FTT_acqua)))
        grid on
        title('Funzione di trasferimento trasmissione')
        xlabel('frequenza [MHz]')
        ylabel('FTT[dB]')
        
        subplot(3,1,3)
        plot(freq_vector, mag2db(abs(FTR_aria)))
        hold on
        plot(freq_vector, mag2db(abs(FTR_acqua)))
        grid on
        title('Funzione di trasferimento ricezione')
        xlabel('frequenza [MHz]')
        ylabel('FTR[dB]')
    end
end

