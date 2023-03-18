function stampaGraficiLangevinConcentratore(Zin_finale, FTT_finale, freq_vector)
    freq_vector = freq_vector./1e3;

    fh2 = figure;
    fh2.WindowState = 'maximized';
    plot(freq_vector, mag2db(abs(Zin_finale)), 'LineWidth', 2)
    grid on
    title('Impedenza elettrica Langevin con concentratore')
    xlabel('freq [KHz]')
    ylabel('Zin')
    set(gca,'xtick',[0:10:1000])
    %set(gca,'ytick',linspace(0,1000,10))

    
    fh2 = figure;
    fh2.WindowState = 'maximized';
    plot(freq_vector, mag2db(abs(FTT_finale)), 'LineWidth', 2)
    grid on
    title('Funzione di trasferimento in trasmissione Langevin con concentratore')
    xlabel('freq [KHz]')
    ylabel('FTT [dB]')
    set(gca,'xtick',[0:10:1000])
end

