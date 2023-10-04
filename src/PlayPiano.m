% Function of piano sound translation (stage 2).

function melody = PlayPiano(keys, fs, tempos)
    % Implemetation of stage 2.
    % The function takes input of sequence of keys and the tempos.
    % If the parameter tempos is not specified, then each note will
    % take a unit sound duration.
    
    if nargin == 2
        tempos = 1;    % second
    elseif nargin < 2
        error("User should at least specify value for the first two inputs.");
    end
    N = length(keys);
    N0 = length(tempos);
%     disp(N0 == 1);
    if (N0 ~= 1) && (N0 ~= N)
        error("The input variable (tempos) has length of " + string(N0) ...
            + ", which does not match with the length of keys (" ...
            + string(N) + ").");
    end
    
    % Melody synthesis
    % Initial silence
    t_SI = 0.5;
    melody = zeros(1, int32(t_SI*fs));
    for i = 1:N
        if isscalar(tempos)
            current_note = NoteSim(keys(i), fs, tempos);
        else
            current_note = NoteSim(keys(i), fs, tempos(i));
        end
        melody = [melody, current_note];
    end
end

function note_sound = NoteSim(key, fs, tempo)
    % Simulate the sound of piano for a certain note 
    % with given tempo (key duration).
    Ts = 1 / fs;
    t = 0:Ts:tempo;
    env = exp(-5*t);
    f_A4 = 440;    % Hz
    fc = 2^((key-49)/12) * f_A4;
    note_sound = env.* GenerateHarmonics(fc, fs, tempo);
%     figure();
%     plot(t, note_sound);
end

function harmonic_sig = GenerateHarmonics(fc, fs, tempo)
    Ts = 1/fs;
    t = 0:Ts:tempo;
    % Amplitude and phase of the fundamental frequency component and 
    % the high order harmonics.
    a = [1, 0.4, 0.15];
    phi = [0, 2*pi/3, 4*pi/3];
    harmonic_sig = a(1) * cos(2*pi*fc*t + phi(1))...
        +a(2) * cos(2*pi*2*fc*t + phi(2))...
        +a(3) * cos(2*pi*3*fc*t + phi(3));
%     disp("mean");
%     disp(mean(harmonic_sig));
%     figure();
%     plot(t, harmonic_sig);
%     disp("Harmonic");
%     disp(harmonic_sig);
end
