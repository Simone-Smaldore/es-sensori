function stampaGraficiConfronto(freq_vector, Zintrasduttore, FTTtrasduttore, Zintrasduttore_backing, FTTtrasduttore_backing)
    % PLOT CONFRONTO TRASDUTTORE BANDA LARGA CON E SENZA BACKING
    lineWidth = 1.5;

    freq_vector = freq_vector ./ 1e6;
    figure
    set(gcf,'WindowState','maximized')

    subplot(1,2,1)
    plot(freq_vector, Zintrasduttore, 'LineWidth',lineWidth);
    hold on;
    plot(freq_vector, Zintrasduttore_backing, 'LineWidth',lineWidth);
    hold off
    grid on;
    xlabel('Frequenza [MHz]')
    ylabel(' |Zin| [Ohm] ')
    legend('Senza backing','Con backing');
    
    subplot(1,2,2)
    plot(freq_vector,FTTtrasduttore,'LineWidth',lineWidth);
    hold on;
    plot(freq_vector,FTTtrasduttore_backing, 'LineWidth',lineWidth);
    hold off
    grid on;
    xlabel('Frequenza [MHz]')
    ylabel(' |FTT| [dB]')
    legend('Senza backing','Con backing');
end

