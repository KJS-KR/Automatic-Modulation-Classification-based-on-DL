clc; close all; clear;

%% 신호 변조

sig = randi([0 3], 1000, 1);

modQpskSig = pskmod(sig, 4, pi/2);

figure;
plot(real(modQpskSig), imag(modQpskSig), 'x')

tdl = nrTDLChannel();



signalOut = tdl(modQpskSig);

signalOut = awgn(signalOut, 10);

figure;
plot(real(signalOut), imag(signalOut), 'x');

