function [log_freq_ps, t, f, notes] = create_log_frequency_spectrogram(x, fs, pitch_rng, chroma, stft_params)
% helper lambda functions
f_pitch = @(p) 48.9994 * 2 ^ ((p - 31) / 12);
f_range = @(p, f) (f >= f_pitch(p - .5)) & (f <= f_pitch(p + .5));

[s, f, t] = spectrogram(x, ...
                        stft_params.win, ...
                        stft_params.n_overlap, ...
                        stft_params.N, ...
                        fs);
ps = abs(s).^2;

log_freq_ps = zeros(numel(pitch_rng), numel(t)); % pre-allocate log freq spectrogram
notes = string(zeros(length(pitch_rng),1));

for k=1:length(pitch_rng)
    frequency_mask = f_range(pitch_rng(k),f);
    log_freq_ps(k,:) = sum(ps(frequency_mask,:),1);
    chroma_ind = mod(pitch_rng(k) - 31,12) + 1;
    notes(k) = strcat(chroma(chroma_ind),num2str(floor(pitch_rng(k)/12) - 1));
end

end

