clearvars; close all; clc
%% define hyper parameters
fs_orig = 44.1e3;                                        % sample rate Hz
stft_params.N = 2^12;                               % DFT size in samples
stft_params.n_overlap = ceil(0.9*stft_params.N);    % number of samples to overlap
stft_params.win = blackman(stft_params.N);          % window function for STFT
T = 2;                                              % seconds
pitch_rng = 31:102;                                 % G1-F#7
decimation_factor = 6;                              % downsample for better frequency resolution in the lower range
chroma = ["G", "G#", "A ", "A#", "B ", "C ", "C#", "D ", "D#", "E ", "F ", "F#"];
f_pitch = @(p) 48.9994 * 2 ^ ((p - 31) / 12);
%% part 1 - three notes
pure_notes = [f_pitch(43), f_pitch(42), f_pitch(36)];
note_names = ["G2", "F#1", "C2"];
n = linspace(0, T, T*fs_orig);
for i=1:numel(pure_notes)    
    x = sin(2*pi*pure_notes(i).*n);
    x = decimate(x,decimation_factor);
    fs = fs_orig/decimation_factor;
    t = linspace(0,T,T*fs);
    plot_signal_vs_time(t, x, strcat(note_names(i)," - ",num2str(pure_notes(i)),"Hz"))
    figure; 
    spectrogram(x, stft_params.win, stft_params.n_overlap, stft_params.N, fs,'yaxis')
    title(strcat("Spectrogram ", note_names(i)))
    [log_freq_ps, t, f, notes] = create_log_frequency_spectrogram(x, fs, pitch_rng, chroma, stft_params);
    plot_images(log_freq_ps, "log", strcat("Pitch Energy ", note_names(i)),notes, 100);
    [chromagram, chroma_notes] = create_chromagram(log_freq_ps, t, pitch_rng, chroma);
    plot_images(chromagram, "log", strcat("Chromagram ", note_names(i)),chroma_notes, 100);
    if i == 3
        plot_images(chromagram, "linear", strcat("Chromagram ", note_names(i)),chroma_notes, 1);
        plot_images(chromagram, "nroot", strcat("Chromagram ", note_names(i)),chroma_notes, 5);
    end
end

