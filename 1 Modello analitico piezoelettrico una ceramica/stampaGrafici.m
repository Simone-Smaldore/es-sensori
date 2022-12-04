function stampaGrafici(freq_vector, Zin, FTT, FTR, min_to_plot, max_to_plot)

    freq_vector = freq_vector./1e6;
    figure;
    set(gcf,'WindowState','maximized')
    Zin_abs = abs(Zin);

    subplot(4,1,1)
    semilogy(freq_vector, Zin_abs)

    hold on;
     
    [val_min,index_min_arr] = mink(Zin_abs, min_to_plot);
    for i = 1:min_to_plot        
        index_min = index_min_arr(i);
        semilogy(freq_vector(index_min),Zin_abs(index_min),'*r');
        txt_min = ['Freq Min Zin: ' num2str(freq_vector(index_min)), ' MHz'];
        text(freq_vector(index_min) + 0.01, 1 ,txt_min)
    end

    [val_max,index_max_arr] = maxk(Zin_abs, length(Zin_abs));
    max_cont = 0;
    i = 1;
    while max_cont < max_to_plot && i < length(Zin_abs) 
        index_max = index_max_arr(i);
        if(Zin_abs(index_max - 1) < Zin_abs(index_max) && Zin_abs(index_max + 1) < Zin_abs(index_max))
            semilogy(freq_vector(index_max),Zin_abs(index_max),'*r');    
            txt_max = ['Freq Max Zin: ' num2str(freq_vector(index_max)), ' MHz'];
            text(freq_vector(index_max) + 0.01, Zin_abs(index_max)/2,txt_max)
            max_cont = max_cont + 1;
        end
        i = i + 1;
    end
    
    hold off;

    grid on
    title('Impedenza')
    xlabel('frequenza [MHz]')
    ylabel('Zin [Ohm]')

    subplot(4,1,2)
    plot(freq_vector, mag2db(abs(FTT)))
    grid on
    title('Funzione di trasferimento trasmissione')
    xlabel('frequenza [MHz]')
    ylabel('FTT[dB]')
    
    subplot(4,1,3)
    plot(freq_vector, mag2db(abs(FTR)))
    grid on
    title('Funzione di trasferimento ricezione')
    xlabel('frequenza [MHz]')
    ylabel('FTR[dB]')

    subplot(4,1,4)
    plot(freq_vector, angle(Zin))
    grid on
    title('Fase impedenza')
    xlabel('frequenza [MHz]')
    ylabel('Fase Zin [Rad]')
end

