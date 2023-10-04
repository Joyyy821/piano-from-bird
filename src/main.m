% EIE3510 Digital Signal Processing: Course Project
% Authors: Yang JIAO @118010121, Jifei ZHAO @118010437
% Composition and Instrumental Music Generation from Bird Songs

cla, clf; close all;
%% Stage 1 (a): Bird sound pre-processing
%read the audio
Fs = 44100;
samples = [1,3*Fs];
[x,Fs]=audioread('XC689075_Systellura_longirostris.mp3',samples);
x = x';
N = length(x); %number of samples
t = (0:N-1)/Fs; %time
y = fft(x);
f = Fs/N*(0:round(N/2)-1); %half of frequency points, T * Fs = N = Fs/fs 

% Plot original signal's waveform and spectrum
figure
subplot(311);
plot(t,x,'g');
xlabel('Time/s');ylabel('Amplitude');
title('waveform');
grid;
subplot(312);
plot(f,abs(y(1:round(N/2))));
xlabel('Frequency/Hz');ylabel('Amplitude');
title('spectrum');
%soundsc(x,Fs)

% Denoising
x_f = WienerScalart96(x, Fs, 1);
y_f = fft(x_f);
subplot(313);
plot(f,abs(y_f(1:round(N/2))));
xlabel('Frequency/Hz');ylabel('Amplitude');
title('spectrum');
%soundsc(x,Fs)

%% Stage 1 (b): Note matching
[n, ~] = SoundToNote(x_f,Fs);
index=find(n>0);
n=n(index);%only keep the sounds part
[keys,beats]=CreateBeats(n);

%% Stage 2: Tone adjustment and melody synthesis
tempos = beats * 0.07;
sig = PlayPiano(keys, Fs, tempos);
N = length(sig);
t = 0:1/Fs:(N-1)/Fs;
plot(t, sig);
xlabel("Time (s)");
ylabel("Signal amplitude");
title("Piano sound");
soundsc(sig, Fs);
