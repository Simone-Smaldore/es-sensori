function stampaGraficiConfronto(Zin, Zin_new, Zin_dc, Zin_dc_new, freq_vector)
figure;
set(gcf,'WindowState','maximized')
plot(freq_vector, mag2db(abs(Zin)));
hold on;
plot(freq_vector, mag2db(abs(Zin_dc)));
hold on;
plot(freq_vector, mag2db(abs(Zin_new)));
hold on;
plot(freq_vector, mag2db(abs(Zin_dc_new)));
grid on;
title('Confronto valori una ceramica e due ceramiche')
xlabel('frequenza [KHz]')
ylabel('Zin [Ohm]')
legend('Progetto Langevin Una Ceramica', 'Progetto Langevin Due Ceramiche','Nuovo criterio ottimizzato per generatore di tensione Una Ceramica', 'Nuovo criterio ottimizzato per generatore di tensione Due Ceramiche')
end

