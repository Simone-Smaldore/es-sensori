function stampaGraficiConfronto(freq_vector, Zintrasduttore, FTTtrasduttore, Zintrasduttore_backing, FTTtrasduttore_backing, bandaDb)
    % PLOT CONFRONTO TRASDUTTORE BANDA LARGA CON E SENZA BACKING
    Zintrasduttore_plot = mag2db(abs(Zintrasduttore));
    FTTtrasduttore_plot = mag2db(abs(FTTtrasduttore));
    Zintrasduttore_backing_plot = mag2db(abs(Zintrasduttore_backing));
    FTTtrasduttore_backing_plot = mag2db(abs(FTTtrasduttore_backing));
    lineWidth = 1.5;

    freq_vector = freq_vector ./ 1e6;
    figure
    set(gcf,'WindowState','maximized')

    subplot(1,2,1)
    plot(freq_vector, Zintrasduttore_plot, 'LineWidth',lineWidth);
    hold on;
    plot(freq_vector, Zintrasduttore_backing_plot, 'LineWidth',lineWidth);
    
    
    hold off
    grid on;
    xlabel('Frequenza [MHz]')
    ylabel(' |Zin| [Ohm] ')
    legend('Senza backing','Con backing');
    
    subplot(1,2,2)
    plot(freq_vector,FTTtrasduttore_plot,'LineWidth',lineWidth);
    hold on;
    plot(freq_vector,FTTtrasduttore_backing_plot, 'LineWidth',lineWidth);

    [banda, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,FTTtrasduttore, bandaDb);
    plot(freq_vector(index0),FTTtrasduttore_plot(index0),'*r');
    plot(freq_vector(index1),FTTtrasduttore_plot(index1),'*r');
    txt_show = ['Banda' bandaDb 'Db senza backing: ' num2str(banda), ' MHz'];
    text(freq_vector(index0) + 0.04 , FTTtrasduttore_plot(index0) ,txt_show)
        
    [banda, index0, index1, freqCentroBanda] = calcolaBanda(freq_vector,FTTtrasduttore_backing, bandaDb);
    plot(freq_vector(index0),FTTtrasduttore_backing_plot(index0),'*r');
    plot(freq_vector(index1),FTTtrasduttore_backing_plot(index1),'*r');
    txt_show = ['Banda' bandaDb 'Db con backing: ' num2str(banda), ' MHz'];
    text(freq_vector(index0) + 0.04 , FTTtrasduttore_backing_plot(index0) ,txt_show)

    hold off
    grid on;
    xlabel('Frequenza [MHz]')
    ylabel(' |FTT| [dB]')
    legend('Senza backing','Con backing');
end

