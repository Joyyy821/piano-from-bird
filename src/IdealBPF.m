function [sig_desired, xf, spec] = IdealBPF(sig, fc1, fc2, Fs)
% An ideal bandpass filter with cut-off frequency 
% specified as fc1 and fc2.
% Time complexity O(nlogn) since FFT is required.
    N = length(sig);
    spec = fftshift(fft(sig));
    xf = Fs/N*(0:N-1) - Fs/2;
%     subplot(211);
%     plot(xf, abs(spec));
    for i=1:N
        % disp(xf(i));disp(fc1);
        if abs(xf(i)) < fc1 || abs(xf(i)) > fc2
            spec(i) = 0;
        end
    end
    
    spec = fftshift(spec);
    xf = fftshift(xf);
    sig_desired = ifft(spec);
    xf = xf(1:int32(N/2));
    spec = spec(1:int32(N/2));
%     subplot(212);
%     plot(xf, abs(spec));
end
    
    