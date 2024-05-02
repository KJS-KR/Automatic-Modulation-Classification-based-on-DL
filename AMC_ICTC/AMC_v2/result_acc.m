result_Q = [100, 100, 98.95, 97, 95.55, 94.90, 94.15];

num = 0:1:6;

figure;
plot(num*5, result_Q); hold on;
plot(num*5, result_Q,'o');
xlabel("SNR(dB)")
ylabel("Accuracy(%)")
text(0, result_Q(1), num2str(result_Q(1)));
text(5, result_Q(2), num2str(result_Q(2)));
text(10, result_Q(3), num2str(result_Q(3)));
text(15, result_Q(4), num2str(result_Q(4)));
text(20, result_Q(5), num2str(result_Q(5)));
text(25, result_Q(6), num2str(result_Q(6)));
text(30, result_Q(7), num2str(result_Q(7)));

result_8 = [100, 99.95, 97, 99.55, 100, 100, 100];

num = 0:1:6;

figure;
plot(num*5, result_8); hold on;
plot(num*5, result_8,'o');
xlabel("SNR(dB)")
ylabel("Accuracy(%)")
text(0, result_8(1), num2str(result_8(1)));
text(5, result_8(2), num2str(result_8(2)));
text(10, result_8(3), num2str(result_8(3)));
text(15, result_8(4), num2str(result_8(4)));
text(20, result_8(5), num2str(result_8(5)));
text(25, result_8(6), num2str(result_8(6)));
text(30, result_8(7), num2str(result_8(7)));

