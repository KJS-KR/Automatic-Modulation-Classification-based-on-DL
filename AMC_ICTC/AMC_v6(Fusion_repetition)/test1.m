% clc; close all; clear;

modNumQpsk = 16;
randBit = randi([0 modNumQpsk-1], 512, 9);
sigQpsk = qammod(randBit, 16);
sigQpsk = awgn(sigQpsk, 10);
addSigQpsk = sigQpsk + sigQpsk;

figure;
plot(real(sigQpsk), imag(sigQpsk), 'x'); hold on;
plot(real(addSigQpsk), imag(addSigQpsk), 'x');