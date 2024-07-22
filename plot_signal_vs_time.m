function [] = plot_signal_vs_time(t, x, title)
figure;
plot(t,x)
xlabel("t [sec]")
ylabel("Amplitude")
grid on
title(title)

end

