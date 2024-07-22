%% define hyper parameters
fs = 44.1e3;                % sample rate Hz
N = 2^12;                   % DFT size in samples
n_overlap = ceil(0.9*N);    % number of samples to overlap
win = blackman(N);          % window function for STFT
T = 2;                      % seconds
pitch_rng = 31:102;         % G1-F#7
decimation_factor = 8;      % downsample for better frequency resolution in the lower range
chroma = ["G", "G#", "A ", "A#", "B ", "C ", "C#", "D ", "D#", "E ", "F ", "F#"];

%% define input signals
n = linspace(0, T, T*fs);
x_C2 = sin(2*pi*65.4.*n);
x_C2 = decimate(x_C2,decimation_factor);
fs = fs/decimation_factor;

