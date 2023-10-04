function [output, f_max] = SoundToNote(signal,Fs)

% output = SoundToNote(signal,fs,IS)
% Wiener filter based on tracking a priori SNR usingDecision-Directed
% method, proposed by Scalart et al 96. In this method it is assumed that
% SNRpost

%get main frequency
s =spectrogram(signal, window(@hann, 1000), 500, 1024, Fs,'yaxis');
s_amp = abs (s);
[intensity, f_max] = max(s_amp);
% plot(f_max);
[M_s, N_s] = size(s_amp);
M_s = M_s*2; %
f2= Fs/M_s* (0:round (M_s/2)-1);
for i=1:N_s
    if intensity(i)<2.3
        f_max(i) = 1;
    else
        f_max(i) = f_max(i);
    end
end
f_max = f2(f_max);
% figure
% plot(f_max);

% map the frequency to note
output =round(12*log2(f_max/440)+49);
% figure
% plot(output-12);
end
