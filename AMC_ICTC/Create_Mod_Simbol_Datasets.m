%% initialization
clc; clear; close all;

%% Setting
SNR = 0:5:30;
M_Q = 4;
M_8 = 8;
%% Create QPSK and Add Noise
for dB = 1:7
%     figure;
    for pos = 0:3
        make_rand = ['n_Q_', num2str(pos), '_', num2str(dB),' = randi([', num2str(pos),',', num2str(pos),'], 5000, 1);'];
        eval(make_rand)
        make_mod_Q = ['mod_Q_', num2str(pos), '_', num2str(dB),' = pskmod(n_Q_', num2str(pos), '_', num2str(dB),', M_Q, pi/4);'];
        eval(make_mod_Q)
        make_y_Q = ['y_Q_', num2str(pos), '_', num2str(dB),' = awgn(mod_Q_', num2str(pos), '_', num2str(dB),',SNR(', num2str(dB),'));'];
        eval(make_y_Q)
        make_Q_subplot = ['subplot(2, 4, ', num2str(dB),')'];
        eval(make_Q_subplot)
        make_Q_plot = ['plot(real(y_Q_', num2str(pos), '_', num2str(dB),'), imag(y_Q_', num2str(pos), '_', num2str(dB),'), ''x''); hold on;'];
        eval(make_Q_plot)
    end
end

figure;
subplot(2, 2, 2)
plot(real(y_Q_0_4), imag(y_Q_0_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(2, 2, 1)
plot(real(y_Q_1_4), imag(y_Q_1_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(2, 2, 3)
plot(real(y_Q_2_4), imag(y_Q_2_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(2, 2, 4)
plot(real(y_Q_3_4), imag(y_Q_3_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

%% Create 8PSK and Add Noise
figure;
for dB = 1:7
%     figure;
    for pos = 0:7
        make_rand = ['n_8_', num2str(pos), '_', num2str(dB),' = randi([', num2str(pos),',', num2str(pos),'], 5000, 1);'];
        eval(make_rand)
        make_mod_8 = ['mod_8_', num2str(pos), '_', num2str(dB),' = pskmod(n_8_', num2str(pos), '_', num2str(dB),', M_8, pi/8);'];
        eval(make_mod_8)
        make_y_8 = ['y_8_', num2str(pos), '_', num2str(dB),' = awgn(mod_8_', num2str(pos), '_', num2str(dB),',SNR(', num2str(dB),'));'];
        eval(make_y_8)
        make_8_subplot = ['subplot(2, 4, ', num2str(dB),')'];
        eval(make_8_subplot)
        make_8_plot = ['plot(real(y_8_', num2str(pos), '_', num2str(dB),'), imag(y_8_', num2str(pos), '_', num2str(dB),'), ''x''); hold on;'];
        eval(make_8_plot)
    end
end

figure;
subplot(4, 4, 8)
plot(real(y_8_0_4), imag(y_8_0_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 3)
plot(real(y_8_1_4), imag(y_8_1_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 2)
plot(real(y_8_2_4), imag(y_8_2_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 5)
plot(real(y_8_3_4), imag(y_8_3_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 9)
plot(real(y_8_4_4), imag(y_8_4_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 14)
plot(real(y_8_5_4), imag(y_8_5_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 15)
plot(real(y_8_6_4), imag(y_8_6_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

subplot(4, 4, 12)
plot(real(y_8_7_4), imag(y_8_7_4), 'x')
axis([-2 2 -2 2])
xlabel("Re")
ylabel("Im")
xline(0)
yline(0)

%% QPSK 00 ~ 11비트, 0dB ~ 30dB 까지 3000개 데이터셋 생성
% for dB = 1:7
%     figure;
%     for pos = 0:3
%         for N = 1:3000
%                 make_plot = ['plot(real(y_Q_', num2str(pos), '_', num2str(dB),'(N)), imag(y_Q_', num2str(pos), '_', num2str(dB),'(N)), ''k--x'');'];
%                 eval(make_plot)
%                 xticks([])
%                 yticks([])
%                 axis([-2 2 -2 2])
%                 make_data = ['exportgraphics(gcf, ''classification_datasets/simbol_detection/QPSK_', num2str(SNR(dB)),'dB/', num2str(pos+1),'/', num2str(N), '.png'', ''Resolution'', 50);'];
%                 eval(make_data)
%         end
%     end
% end

%% 8PSK 000 ~ 111비트 0dB ~ 30dB 까지 3000개 데이터셋 생성
% for dB = 1:1
%     figure;
%     for pos = 0:7
%         for N = 1:3000
%                 make_plot = ['plot(real(y_8_', num2str(pos), '_', num2str(dB),'(N)), imag(y_8_', num2str(pos), '_', num2str(dB),'(N)), ''k--x''); hold on;'];
%                 eval(make_plot)
%                 xticks([])
%                 yticks([])
%                 axis([-2 2 -2 2])
% %                 make_data = ['exportgraphics(gcf, ''classification_datasets/simbol_detection/8PSK_', num2str(SNR(dB)),'dB/', num2str(pos+1),'/', num2str(N), '.png'', ''Resolution'', 50);'];
% %                 eval(make_data)
%         end
%     end
% end