clc; clear; close all;

channel_q_8_y = [95.45 96.3 94.15 92.75 94.65 94.25 93.35 92.95 93.35 94.45]; 
channel_q_8_x = 0:5:45;

figure;
bar(channel_q_8_x,channel_q_8_y)
ylim([90 100])
title("3Channel QPSK 8QPSK Classification")
xlabel("phase shift [°]")
ylabel("accuracy [%]")

channel_16_64_y = [95.1 95.25 95.25 95.55 93.8 94 93.4 95.9 94.55 94.7]; 
channel_16_64_x = 0:5:45;

figure;
bar(channel_16_64_x,channel_16_64_y)
ylim([90 100])
title("3Channel 16QAM 64QAM Classification")
xlabel("phase shift [°]")
ylabel("accuracy [%]")