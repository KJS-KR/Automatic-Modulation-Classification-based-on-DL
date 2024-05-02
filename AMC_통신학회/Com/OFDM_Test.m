clc; clear; close all;

snr = 4;
mod4 = 4;
mod16 = 16;
mod64 = 64;
numSym = 32;

rand4 = randi([0 mod4-1], numSym, 1);
rand16 = randi([0 mod16-1], numSym, 1);
rand64 = randi([0 mod64-1], numSym, 1);

psk4SigOfdm = pskmod(rand4, mod4, pi/4);
qam16SigOfdm = qammod(rand16, mod16, 'UnitAveragePower', true);
qam64SigOfdm = qammod(rand64, mod64, 'UnitAveragePower', true);

psk4Sig = ifft(psk4SigOfdm)*sqrt(numSym);
qam16Sig = ifft(qam16SigOfdm)*sqrt(numSym);
qam64Sig = ifft(qam64SigOfdm)*sqrt(numSym);
% figure;
% plot(real(pskSig), '-x'); hold on;
% plot(imag(pskSig), '-o')

awgnSig4 = awgn(psk4Sig, snr);
awgnSig16 = awgn(qam16Sig, snr);
awgnSig64 = awgn(qam64Sig, snr);

psk4Sig = fft(awgnSig4, numSym)/sqrt(numSym);
norm4Sig = normalize(psk4Sig);
qam16Sig = fft(awgnSig16, numSym)/sqrt(numSym);
norm16Sig = normalize(qam16Sig);
qam64Sig = fft(awgnSig64, numSym)/sqrt(numSym);
norm64Sig = normalize(qam64Sig);

scatterplot(psk4Sig)
scatterplot(norm4Sig)
% scatterplot(qam16Sig)
% scatterplot(norm16Sig)
% scatterplot(qam64Sig)
% scatterplot(norm64Sig)
