function [sig_desired, N] = FIR_BPF(sig, fc1, fc2, Fs)
%
    trans = 100;
    fcuts = [fc1-trans/2, fc1+trans/2, fc2-trans/2, fc2+trans/2];
    mags = [0, 1, 0];  devs = [0.01, 0.01, 0.01];
    [n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,Fs);
    n = n + rem(n,2);  % to make the input to fir1 an even number.
    hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

%     figure()
%     [H,f] = freqz(hh,1,1024,Fs);
%     plot(f,abs(H))
%     grid

    % Convolution
%     disp("sig"); disp(sig);
%     disp("hh"); disp(hh);
    sig_desired = conv(sig, hh).';
    N = length(sig) + n;
end
