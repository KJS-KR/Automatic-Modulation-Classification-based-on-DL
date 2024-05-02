%%  OFDM Fading channel simulation
clear all; close all;

% initialize ==============================================================
samplingRate = 10000; % sampling frequency = 10kHz
dopplerFreq = 100; % doppler frequency = 100Hz
simSample = 1024; % this is used as fft size
cp_length = 80; % cyclic prefix length
modOrder = 4; % modulation order = 4 (QPSK)
EbN0 = -10:5:30 ; % Eb/N0 in dB scale

% Generate tx signal ======================================================
tx = randi([0 modOrder-1], simSample,1);  % Random bit stream
pskSigOfdm = pskmod(tx,modOrder,pi/4);  % QPSK signal
scatter(real(pskSigOfdm), imag(pskSigOfdm), 30, 'b', 'filled'); grid; 
axis([-1.5 1.5 -1.5 1.5]);
xlabel('In-Phase'); ylabel('Quadrature');
title('Freq domain signal');

% ifft ====================================================================
pskSig = ifft(pskSigOfdm)*sqrt(simSample);
figure; plot(1:100,real(pskSig(1:100)),'b',1:100,imag(pskSig(1:100)),'r'); 
grid; legend('real','imag');
xlabel('sample'); ylabel('value');
title('time domain signal');
scatterplot(pskSig); grid; axis([-1.5 1.5 -1.5 1.5]);

% pass through fading =====================================================
chan = rayleighchan(1/samplingRate,dopplerFreq);
pskSig = [pskSig(simSample-cp_length+1:simSample); pskSig]; % add cyclic prefix
fadedSig = filter(chan,pskSig); % Pass signal through channel
fadedSig = fadedSig(cp_length+1:end); % remove cyclic prefix

% store channel coefficient for de-rotation in rx 
% assuming ideal channel estimation
fadingCoeffOfdm = fft(fadedSig)/sqrt(simSample)./pskSigOfdm;
figure; plot(1:100,real(fadedSig(1:100)),'b',1:100,imag(fadedSig(1:100)),'r'); 
grid; legend('real','imag');
xlabel('sample'); ylabel('value');
title('faded and noise added signal');
scatterplot(fadedSig); grid; axis([-1.5 1.5 -1.5 1.5]);

for n = 1:length(EbN0)
    for iter = 1:100
        % Add Gaussian noise. time domain
        % EbN0 + 3dB, because QPSK has two bits per symbol
        rxSigTime = awgn(fadedSig,EbN0(n)+10*log10(log(modOrder)/log(2))); 
        rxSigFreq = fft(rxSigTime)/sqrt(simSample);

        % compensate fading channel, perfect channel estimation
        chanCompensation = rxSigFreq ./ fadingCoeffOfdm; 
        if (iter == 1) % plot only once per EbN0
            scatterplot(chanCompensation); grid; axis([-1.5 1.5 -1.5 1.5]);
            title_str = sprintf('channel compensated EbN0 %ddB', EbN0(n));
            title(title_str);
            pause(1);
        end
        rx = pskdemod(chanCompensation,modOrder,pi/4); % Demodulate.
        
        % Compute error rate.
        [nErrors, berIter(iter)] = biterr(tx,rx);
    end
    BER(n) = mean(berIter);
end

% Compute theoretical performance results, for comparison.
BERtheory = berfading(EbN0,'psk',modOrder,1);

% Plot BER results. =======================================================
figure;
semilogy(EbN0,BERtheory,'b-',EbN0,BER,'r*');
legend('Theoretical BER','Empirical BER');
xlabel('SNR (dB)'); ylabel('BER');
title('QPSK over Rayleigh Fading Channel');
grid;