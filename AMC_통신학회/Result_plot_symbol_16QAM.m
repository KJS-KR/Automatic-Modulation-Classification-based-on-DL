%% 
clc; close all; clear;

%%
acc_repeat_16_8 = [36.66, 45.13, 51.75, 59.13, 64.75, 69.27, 72.44, 74.95];
acc_repeat_16_4 = [27.55, 34.15, 40.15, 48.05, 55.76, 62.00, 67.03, 70.84];
acc_repeat_16_2 = [21.00, 25.02, 30.27, 37.33, 43.98, 52.21, 58.54, 64.55];

SER_16_8 = 1 - acc_repeat_16_8/100;
SER_16_4 = 1 - acc_repeat_16_4/100;
SER_16_2 = 1 - acc_repeat_16_2/100;

SNR = -4:2:10;

% figure;
% plot(SNR, acc_repeat_16_8, 'o')

figure;
semilogy(SNR, SER_16_8, '-o', SNR, SER_16_4, '-o', SNR, SER_16_2, '-o');
% title("Symbol-16QAM, 반복전송")
% xlabel("SNR(dB)")
% ylabel("SER")
