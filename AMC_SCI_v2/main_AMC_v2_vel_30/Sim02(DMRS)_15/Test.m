clc; clear; close all;

bits = randi([0 3], 1000, 1);

qpsk = pskmod(bits, 4, pi/4);

qpsk2 = pskmod(bits, 4, pi/3);
qpsk3 = pskmod(bits, 4, pi/2.4);
qpsk4 = pskmod(bits, 4, pi/2);


plot(real(qpsk), imag(qpsk), 'x'); hold on;
plot(real(qpsk2), imag(qpsk2), 'x'); hold on;
plot(real(qpsk3), imag(qpsk3), 'x'); hold on;
plot(real(qpsk4), imag(qpsk4), 'x'); hold on;
axis([-2 2 -2 2])
