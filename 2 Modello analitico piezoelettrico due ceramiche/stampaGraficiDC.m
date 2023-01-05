function stampaGraficiDC(freq_vector, Zin, FTT, FTR, Zin_DC, FTT_DC, FTR_DC)
    freq_vector = freq_vector./1e6;
    figure;
    set(gcf,'WindowState','maximized')

    subplot(3,1,1)
    semilogy(freq_vector, abs(Zin))
    hold on
    semilogy(freq_vector, abs(Zin_DC))
    hold off
    grid on;
    title('Impedenza')
    xlabel('frequenza [MHz]')
    ylabel('Zin [Ohm]')
    legend('Una ceramica da 2mm','Due ceramiche da 1mm')

    subplot(3,1,2)
    plot(freq_vector, mag2db(abs(FTT)))
    hold on
    plot(freq_vector, mag2db(abs(FTT_DC)))
    hold off
    grid on
    title('Funzione di trasferimento trasmissione')
    xlabel('frequenza [MHz]')
    ylabel('FTT[dB]')
    legend('Una ceramica da 2mm','Due ceramiche da 1mm')
    
    subplot(3,1,3)
    plot(freq_vector, mag2db(abs(FTR)))
    hold on
    plot(freq_vector, mag2db(abs(FTR_DC)))
    hold off
    grid on
    title('Funzione di trasferimento ricezione')
    xlabel('frequenza [MHz]')
    ylabel('FTR[dB]')
    legend('Una ceramica da 2mm','Due ceramiche da 1mm')

end

