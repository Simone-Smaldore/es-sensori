function stampaGraficiLangevin(Zin,Zin_new, FTT, FTT_new, freq_vector)
    freq_vector = freq_vector./1e3;
    figure;
    set(gcf,'WindowState','maximized')
    
    plot(freq_vector, mag2db(abs(Zin)));
    hold on;
    plot(freq_vector, mag2db(abs(Zin_new)));
    grid on;
    title('Impedenza')
    xlabel('frequenza [KHz]')
    ylabel('Zin [Ohm]')
    legend('Progetto Langevin','Nuovo criterio ottimizzato per generatore di tensione')
    
    figure;
    set(gcf,'WindowState','maximized')
    plot(freq_vector, mag2db(abs(FTT)));
    hold on;
    plot(freq_vector, mag2db(abs(FTT_new)));
    grid on;
    title('Funzione di trasferimento trasmissione')
    xlabel('frequenza [KHz]')
    ylabel('FTT[db]')
    legend('Progetto Langevin','Nuovo criterio ottimizzato per generatore di tensione')

end

