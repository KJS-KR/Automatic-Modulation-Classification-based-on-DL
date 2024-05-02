clc; clear; close all;

acc_awgn = [0.2543 0.2561 0.2699 0.2804 0.3028 0.32088	0.3435 0.37163 0.36825 0.424 0.5309	0.6654 0.7519 0.8205 0.89 0.96725 0.99613 0.99975 0.99975 1 1];

acc_awgn_add = [68.66 75.56 78.26 80.61 84.19 86.39 87.38 87.79 87.79 92.85 98.41 99.94 99.99 100 100 100 100 100 100 100 100];
acc_awgn_add2 = [77.51 80.08 82.82 85.59 87.20 87.62 87.74 90.29 97.41 99.87 99.99 100 100 100 100 100 100 100 100 100 100];

acc_awgn_add = acc_awgn_add/100;
acc_awgn_add2 = acc_awgn_add2/100;

acc_no_add = [0.6900    0.7532    0.7819    0.8163    0.8434    0.8651    0.8745    0.8768    0.8779    0.9295    0.9856    0.9998    1.0000    1.0000 1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000];
acc_voting_add = [0.689687500000000	0.753250000000000	0.783937500000000	0.808750000000000	0.842812500000000	0.865062500000000	0.874500000000000	0.876937500000000	0.877062500000000	0.929812500000000	0.985125000000000	0.999750000000000	1	1	1	1	1	1	1	1	1];
acc_fc_add = [0.741000000000000	0.780250000000000	0.799375000000000	0.831750000000000	0.861500000000000	0.873500000000000	0.875000000000000	0.875750000000000	0.877750000000000	0.944750000000000	0.995250000000000	1	1	1	1	1	1	1	1	1	1];
acc_soft_add = [0.724125000000000	0.774750000000000	0.793125000000000	0.826750000000000	0.855875000000000	0.870000000000000	0.874750000000000	0.875500000000000	0.877750000000000	0.944750000000000	0.995250000000000	1	1	1	1	1	1	1	1	1	1];

acc_no_add2 = [0.770750000000000	0.803125000000000	0.829875000000000	0.852875000000000	0.872375000000000	0.874625000000000	0.883875000000000	0.908125000000000	0.973875000000000	0.998875000000000	0.999750000000000	 1 1 1 1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000];
acc_voting_add2 = [0.770750000000000	0.803125000000000	0.829875000000000	0.852875000000000	0.872375000000000	0.874625000000000	0.883875000000000	0.908125000000000	0.973875000000000	0.998875000000000	0.999750000000000	1	1	1	1	1	1	1	1	1	1];
acc_fc_add2 = [0.770750000000000	0.803125000000000	0.829875000000000	0.852875000000000	0.872375000000000	0.874625000000000	0.883875000000000	0.908125000000000	0.973875000000000	0.998875000000000	0.999750000000000	1	1	1	1	1	1	1	1	1	1];
acc_soft_add2 = [0.770750000000000	0.803125000000000	0.829875000000000	0.852875000000000	0.872375000000000	0.874625000000000	0.883875000000000	0.908125000000000	0.973875000000000	0.998875000000000	0.999750000000000	1	1	1	1	1	1	1	1	1	1];

snr = -20:2:20;

figure;
plot(snr, acc_awgn, '-^'); hold on;
plot(snr, acc_awgn_add, '-x'); hold on;
plot(snr, acc_awgn_add2, '-o');
legend("Origin", "Add1", "Add2")
xlabel("SNR(dB)")
ylabel("Accuracy(%)")

figure;
plot(snr, acc_no_add, '-x'); hold on;
plot(snr, acc_voting_add, '-x'); hold on;
plot(snr, acc_fc_add, '-x'); hold on;
plot(snr, acc_soft_add, '-x'); hold on;
legend("no-Fusion", "voting-based", "Feature-based", "Confidence-based")
xlabel("SNR(dB)")
ylabel("Accuracy(%)")

figure;
plot(snr, acc_no_add2, '-x'); hold on;
plot(snr, acc_fc_add2, '-x'); hold on;
plot(snr, acc_voting_add2, '-x'); hold on;
plot(snr, acc_soft_add2, '-x'); hold on;
legend("no-Fusion", "voting-based", "Feature-based", "Confidence-based")
xlabel("SNR(dB)")
ylabel("Accuracy(%)")