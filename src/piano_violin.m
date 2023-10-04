% File: piano_violin.m
% Test file for timbre polishing and comparison 
% between the simulated piano sound and violin sound.

% Envelope
L = 1;
y = [0, 1, 0.9, 0.15,0.02, 0.005, 0]; 
x = [0, 0.3, 0.7, 0.8,0.9, 0.95, 1];
fs = 44100; Ts = 1 / fs;
t = 0:Ts:L;

% Uncomment the corresponding env definition below
% for violin or piano sound

% Envelope function for violin.
% env = spline(x*L, y, t);

% Envelope function for piano.
env = exp(-5*t);

figure(1);
plot(t, env);
xlabel("Time (s)", "FontSize", 20); 
ylabel("Envelope", "FontSize", 20);
% title("Violin", "FontSize", 20);
title("Piano", "FontSize", 20);

fc = [523.3, 587.3, 659.3]; % Hz
sig = env.*SigHar(fc(1), Ts, L);
sig = [sig, env.*SigHar(fc(2), Ts, L), env.*SigHar(fc(3), Ts, L)];

N0 = 4000;  % Initial silence
sig0 = zeros(1, N0);
t_0 = 0:Ts:(N0-1)*Ts;
sig = [sig0, sig];
sig = sig/max(abs(sig));    % Normalize the amplitude

t_s = N0*Ts;
t_whole = [t_0, t+t_s, t+t_s+1, t+t_s+2];
figure(2);
plot(t_whole, sig);
xlim([0, 3.2]);
xlabel("Time (s)", "FontSize", 20); 
ylabel("Signal amplitude", "FontSize", 20);
% title("Violin sound", "FontSize", 20);
title("Piano sound", "FontSize", 20);
soundsc(sig, fs);

function rslt = SigHar(fc, Ts, L)
    t = 0:Ts:L;
    % Without harmonics
%     a = [1, 0, 0];
%     phi = [0, 0, 0];
    % With harmonics
    a = [1, 0.4, 0.15];
    phi = [0, 2*pi/3, 4*pi/3];
    rslt = a(1) * cos(2*pi*fc*t + phi(1))...
        +a(2) * cos(2*pi*2*fc*t + phi(2))...
        +a(3) * cos(2*pi*3*fc*t + phi(3));
end
