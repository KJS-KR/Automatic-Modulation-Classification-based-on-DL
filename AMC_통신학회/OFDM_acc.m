% clc; close all; clear;

SNR = -4:2:20;

order_acc = [40.10, 42.07, 44.87, 50.98, 58.66, 65.49, 69.24 71.60, 78.39, 87.57, 93.24, 97.93, 99.09];

symbol2_acc = [5.24, 6.45, 8.60, 11.49, 15.80, 21.45, 29.49, 39.87, 53, 66.82, 80.56, 90.80, 96.87];
symbol4_acc = [7.68, 9.83, 13.61, 18.39, 25.53, 35.22, 45.92, 59.85, 74.01, 86.24, 94.45, 98.45, 99.76];
symbol8_acc = [11.52, 15.62, 21.59, 29.73, 39.80, 52.99, 67.03, 80.45, 90.95, 96.86, 99.38, 99.91, 99.99];
symbol16_acc = [18.37, 25.74, 34.71, 46.45, 59.65, 74.16, 86.21, 94.16, 98.54, 99.75, 99.99, 100, 100];

SER_2 = 100 - symbol2_acc;
SER_4 = 100 - symbol4_acc;
SER_8 = 100 - symbol8_acc;
SER_16 = 100 - symbol16_acc;


% OFDM 변조 유형 분류
ofdm_acc = [33.21, 33.10, 33.76, 45.75, 50.28, 64.55, 70.07, 75.71, 87.00, 92.95, 97.88, 98.58, 99.60];
ofdm_acc_2 = [37.7, 49.85, 63.05, 72.60, 79.32, 87.04, 94.01, 99.47, 100, 100, 100, 100, 100];

figure;
plot(SNR, order_acc, '-o', 'linewidth', 2); grid on; hold on;
plot(SNR, ofdm_acc, '-x', 'linewidth', 2); hold on;
plot(SNR, ofdm_acc_2, '-x', 'linewidth', 2);
legend("이전 방식", "OFDM 방식&32프레임", "OFDM 방식&1024프레임")
title("QPSK, 16QAM, 64QAM 변조 분류 결과")
xlabel("SNR(dB)")
ylabel("Accuracy(%)")

figure;
semilogy(SNR, SER_2, '-o', SNR, SER_4, '-x', SNR, SER_8, '-*', SNR, SER_16, '-s', 'linewidth', 2); grid on;
legend("반복전송 2회", "반복전송 4회", "반복전송 8회", "반복전송 16회")
title("반복전송횟수에 따른 심볼 오류 확률")
xlabel("SNR(dB)")
ylabel("Symbol Error Rate")

