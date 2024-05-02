%% 
clc; close all; clear;

%%
acc_order = [36.45, 36.65, 37.06, 38.62, 45.10, 50.17, 57.29, 66.67];

acc_repeat_Q_16 = [94.85, 97.75, 99.10, 99.65, 99.76, 99.92, 99.94, 99.97];
acc_repeat_Q_8 = [86.68, 92.56, 96.19, 98.54, 99.29, 99.73, 99.84, 99.9537];
acc_repeat_Q_4 = [74.87, 82.45, 89.86, 94.47, 97.47, 98.88, 99.55, 99.79];
acc_repeat_Q_2 = [61.81, 69.90, 77.92, 86.08, 92.42, 96.23, 98.18, 99.28];

acc_repeat_16_8 = [36.66, 45.13, 51.75, 59.13, 64.75, 69.27, 72.44, 74.95];
acc_repeat_16_4 = [27.55, 34.15, 40.15, 48.05, 55.76, 62.00, 67.03, 70.84];
acc_repeat_16_2 = [21.00, 25.02, 30.27, 37.33, 43.98, 52.21, 58.54, 64.55];

acc_repeat_64_8 = [11.57, 13.66, 17.83, 20.46, 23.47, 25.95, 28.42, 29.87];
acc_repeat_64_4 = [8.88, 10.39, 12.84, 15.91, 19.25, 21.77, 24.20, 26.80];
acc_repeat_64_2 = [6.27, 7.49, 9.11, 11.51, 14.52, 16.93, 20.33, 23.32];

SER_Q_16 = 1 - acc_repeat_Q_16/100;
SER_Q_8 = 1 - acc_repeat_Q_8/100;
SER_Q_4 = 1 - acc_repeat_Q_4/100;
SER_Q_2 = 1 - acc_repeat_Q_2/100;

SER_16_8 = 1 - acc_repeat_16_8/100;
SER_16_4 = 1 - acc_repeat_16_4/100;
SER_16_2 = 1 - acc_repeat_16_2/100;

SER_64_8 = 1 - acc_repeat_64_8/100;
SER_64_4 = 1 - acc_repeat_64_4/100;
SER_64_2 = 1 - acc_repeat_64_2/100;

SNR = -4:2:10;

figure;
plot(SNR, acc_order, 'b-o', 'LineWidth', 2);
title("Accuracy for Modulation Orders")
% text(SNR, acc_order, string(acc_order))
xlabel("SNR(dB)")
ylabel("ACCURACY(%)")
legend("Order Classification Accuracy");


figure;
semilogy(SNR, SER_Q_16, '-s',SNR, SER_Q_8, '-o', SNR, SER_Q_4, '-*', SNR, SER_Q_2, '-x', 'LineWidth', 2)
title("SER for QPSK Modulation Symbols")
xlabel("SNR(dB)")
ylabel("SER")
legend("반복전송횟수=12회", "반복전송횟수=8회", "반복전송횟수=4회", "반복전송횟수=2회")
% 
% figure;
% semilogy(SNR, SER_16_8, '-o'); hold on;
% semilogy(SNR, SER_16_4, '-o'); hold on;
% semilogy(SNR, SER_16_2, '-o'); hold on;
% title("Symbol-16QAM, 반복전송")
% xlabel("SNR(dB)")
% ylabel("SER")

% figure;
% semilogy(SNR, SER_64_8, '-o'); hold on;
% semilogy(SNR, SER_64_4, '-o'); hold on;
% semilogy(SNR, SER_64_2, '-o'); hold on;
% title("Symbol-64QAM, 반복전송")
% xlabel("SNR(dB)")
% ylabel("SER")

