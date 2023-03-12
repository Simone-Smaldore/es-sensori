function stampaGraficiLangevin(Zin,Zin_new, FTT, FTT_new, FTT_i, FTT_i_new, freq_vector)
    freq_vector = freq_vector./1e3;
    figure;
    set(gcf,'WindowState','maximized')
    
    subplot(3,1,1)
    plot(freq_vector, mag2db(abs(Zin)));
    hold on;
    plot(freq_vector, mag2db(abs(Zin_new)));
    grid on;
    title('Impedenza')
    xlabel('frequenza [KHz]')
    ylabel('Zin [Ohm]')
    legend('Progetto Langevin','Nuovo criterio ottimizzato per generatore di tensione')
    
    subplot(3,1,2)
    plot(freq_vector, mag2db(abs(FTT)));
    hold on;
    plot(freq_vector, mag2db(abs(FTT_new)));
    grid on;
    title('Funzione di trasferimento trasmissione pilotata in tensione')
    xlabel('frequenza [KHz]')
    ylabel('FTT[db] [V]')
    legend('Progetto Langevin','Nuovo criterio ottimizzato per generatore di tensione')

    subplot(3,1,3)
    plot(freq_vector, mag2db(abs(FTT_i)));
    hold on;
    plot(freq_vector, mag2db(abs(FTT_i_new)));
    grid on;
    title('Funzione di trasferimento trasmissione pilotata in corrente')
    xlabel('frequenza [KHz]')
    ylabel('FTT[db] [I]')
    legend('Progetto Langevin','Nuovo criterio ottimizzato per generatore di tensione')

end

