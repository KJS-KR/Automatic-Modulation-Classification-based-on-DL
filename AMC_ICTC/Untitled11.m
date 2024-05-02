%%
clc; clear; close all;
%%
data = randi([0 15], 1000, 1);

txSig = qammod(data, 16).* exp(1i*pi/4);

figure;
plot(real(txSig), imag(txSig), 'x');
xline(0)
yline(0)