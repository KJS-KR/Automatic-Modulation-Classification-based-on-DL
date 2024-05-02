clc; clear; close all;

d = randi([0 3], 1, 1000);

syms = pskmod(d, 4);

figure;
plot(real(syms), imag(syms), 'x');

SNR = 20;
y = awgn(syms, SNR);

figure;
plot(real(y), imag(y), 'x');

h = [1 0.5 0.25];
multipath_awgn = conv(h, y);
multipath_origin = conv(h, syms);

figure;
plot(real(multipath_origin), imag(multipath_origin), 'x');

figure;
plot(real(multipath_awgn), imag(multipath_awgn), 'x');