
%% initialization
clc; clear; close all;

%% Setting
SNR = 0:5:30;

%% Create QPSK and Add Noise
M_Q = 4;
x_Q = (0:M_Q-1)';

mod_Q_origin = pskmod(x_Q, M_Q);

n_Q = randi([0 M_Q-1], 5000, 1);

mod_Q = pskmod(n_Q, M_Q, pi/4);

y_Q_0 = awgn(mod_Q, SNR(1));

plot(real(mod_Q_origin), imag(mod_Q_origin), 'x');
axis([-2 2 -2 2])
xline(0)
yline(0)
% figure;
% for N = 1:7
%     make_y_Q = ['y_Q_', num2str(N), ' = awgn(mod_Q, SNR(', num2str(N), '));'];
%     eval(make_y_Q)
%     make_Q_subplot = ['subplot(2, 4, ', num2str(N),')'];
%     eval(make_Q_subplot)
%     make_Q_plot = ['plot(real(y_Q_', num2str(N),'), imag(y_Q_', num2str(N),'), ''x''); hold on;'];
%     eval(make_Q_plot)
%     make_Q_axis = ['axis([-2 2 -2 2])'];
%     eval(make_Q_axis)
%     make_Q_title = ['title("SNR = ', num2str(SNR(N)),'dB")'];
%     eval(make_Q_title)
%     xlabel("Re")
%     ylabel("Im")
%     xline(0)
%     yline(0)
% end
% 
% %% Create 8PSK and Add Noise
% M_8 = 8;
% x_8 = (0:M_8-1)';
% 
% mod_8_origin = pskmod(x_8, M_8, pi/4);
% 
% n_8 = randi([0 M_8-1], 5000, 1);
% 
% mod_8 = pskmod(n_8, M_8, pi/8);
% 
% y_8_0 = awgn(mod_8, SNR(1));
% 
% 
% figure;
% for N = 1:7
%     make_y_8 = ['y_8_', num2str(N), ' = awgn(mod_8, SNR(', num2str(N), '));'];
%     eval(make_y_8)
%     make_8_subplot = ['subplot(2, 4, ', num2str(N),')'];
%     eval(make_8_subplot)
%     make_8_plot = ['plot(real(y_8_', num2str(N),'), imag(y_8_', num2str(N),'), ''x''); hold on;'];
%     eval(make_8_plot)
%     make_8_axis = ['axis([-2 2 -2 2])'];
%     eval(make_8_axis)
%     make_8_title = ['title("SNR = ', num2str(SNR(N)),'dB")'];
%     eval(make_8_title)
%     xlabel("Re")
%     ylabel("Im")
%     xline(0)
%     yline(0)
% end
% 
% % for Num = 1:7
% %     make_save_num = ['save_num_', num2str(Num), '= 0;'];
% %     eval(make_save_num)
% %     make_count = ['count_', num2str(Num), '= 0;'];
% %     eval(make_count)
% % end
% 
% %% QPSK 0dB ~ 30dB 까지 3000개 데이터셋 생성
% % for dB = 1:7
% %     figure;
% %     for N = 1:3000
% %             make_ plot = ['plot(real(y_Q_', num2str(dB),'(N)), imag(y_Q_', num2str(dB),'(N)), ''k--x'');'];
% %             eval(make_plot)
% %             xticks([])
% %             yticks([])
% %             axis([-2 2 -2 2])
% %             make_data = ['exportgraphics(gcf, ''classification_datasets/modulation/', num2str(SNR(dB)),'dB/QPSK/', num2str(N), '.png'', ''Resolution'', 50);'];
% %             eval(make_data)
% %     end
% % end
% %% 8PSK 0dB ~ 30dB 까지 3000개 데이터셋 생성
% % for dB = 1:7
% %     figure;
% %     for N = 1:3000
% %             make_plot = ['plot(real(y_8_', num2str(dB),'(N)), imag(y_8_', num2str(dB),'(N)), ''k--x'');'];
% %             eval(make_plot)
% %             xticks([])
% %             yticks([])
% %             axis([-2 2 -2 2])
% %             make_data = ['exportgraphics(gcf, ''classification_datasets/modulation/', num2str(SNR(dB)),'dB/8PSK/', num2str(N), '.png'', ''Resolution'', 50);'];
% %             eval(make_data)
% %     end
% % end
