clc; close all; clear;

modNum = 4;
snr = 10;
fftSize = 1024;
randBit = randi([0 modNum-1], fftSize, 1);
sigQpsk = pskmod(randBit, modNum, pi/4);

% scatterplot(sigQpsk)

fftSigQpsk = fft(sigQpsk, fftSize)/sqrt(fftSize);

figure;
stem(real(fftSigQpsk))

awgnSigQpsk = awgn(fftSigQpsk, snr);

dfftSigQpsk = ifft(awgnSigQpsk)*sqrt(fftSize);

figure;
plot(real(dfftSigQpsk), imag(dfftSigQpsk), 'x')
axis([-2, 2 -2, 2])