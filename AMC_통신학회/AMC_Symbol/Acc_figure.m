acc_spf_4 = [77.42, 96.03, 99.95, 100];
acc_spf_8 = [89.62, 99.95, 100, 100];
acc_spf_16 = [98.55, 100, 100, 100];
acc_spf_32 = [100, 100, 100, 100];

acc_snr_neg5 = [77.42, 89.62, 98.55, 100];

SNR = -5:5:10;
SPF = [4, 8, 16, 32];

figure;
% subplot(2, 2, 1)
plot(SNR, acc_spf_4, 'LineWidth', 1); grid on; hold on;
% subplot(2, 2, 2)
plot(SNR, acc_spf_8, 'LineWidth', 1); grid on; hold on;
% subplot(2, 2, 3)
plot(SNR, acc_spf_16, 'LineWidth', 1); grid on; hold on;
% subplot(2, 2, 4)
plot(SNR, acc_spf_32, 'LineWidth', 1); grid on; hold on;
legend("SPF=4", "SPF=8", "SPF=16", "SPF=32")
title("QPSK Symbol Detection")
xlabel("SNR(dB)");
ylabel("Accuracy(%)");
axis([-5, 10, 70, 100])

figure;
subplot(2, 2, 1)
plot(SNR, acc_spf_4, 'LineWidth', 1); grid on;
for idx = 1:4
    text(SNR(idx), acc_spf_4(idx), string(acc_spf_4(idx)));
end
title("QPSK Symbol Detection, SPF=4")
xlabel("SNR(dB)");
ylabel("Accuracy(%)");
axis([-5, 10, 70, 100])

subplot(2, 2, 2)
plot(SNR, acc_spf_8, 'LineWidth', 1); grid on;
for idx = 1:4
    text(SNR(idx), acc_spf_8(idx), string(acc_spf_8(idx)));
end
title("QPSK Symbol Detection, SPF=8")
xlabel("SNR(dB)");
ylabel("Accuracy(%)");
axis([-5, 10, 70, 100])

subplot(2, 2, 3)
plot(SNR, acc_spf_16, 'LineWidth', 1); grid on;
for idx = 1:4
    text(SNR(idx), acc_spf_16(idx), string(acc_spf_16(idx)));
end
title("QPSK Symbol Detection, SPF=16")
xlabel("SNR(dB)");
ylabel("Accuracy(%)");
axis([-5, 10, 70, 100])

subplot(2, 2, 4)
plot(SNR, acc_spf_32, 'LineWidth', 1); grid on;
for idx = 1:4
    text(SNR(idx), acc_spf_32(idx), string(acc_spf_32(idx)));
end
title("QPSK Symbol Detection, SPF=32")
xlabel("SNR(dB)");
ylabel("Accuracy(%)");
axis([-5, 10, 70, 100])

figure;
plot(SPF, acc_snr_neg5, 'LineWidth', 1); grid on;
for idx = 1:4
    text(SPF(idx), acc_snr_neg5(idx), string(acc_snr_neg5(idx)));
end
