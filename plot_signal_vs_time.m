function [] = plot_signal_vs_time(t, x, title_str)
figure;
plot(t,x)
xlabel("t [sec]")
ylabel("Amplitude")
grid on
title(title_str)

end

