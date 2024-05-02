%% initialization
clc; clear; close all;

%% Setting
SNR = 0:5:30;
phase = [36, 18, 12, 9, 7.2, 6, 5.143, 4.5, 4, 3.6, 3.273, 3, 2.77, 2.571, 2.4, 2.25, 2.118, 2];
%% Create QPSK and Add Noise
M_Q = 4;
x_Q = (0:M_Q-1)';

mod_Q_5 = pskmod(x_Q, M_Q, pi/1); 
mod_Q_10 = pskmod(x_Q, M_Q, pi/18);
mod_Q_15 = pskmod(x_Q, M_Q, pi/12);
mod_Q_20 = pskmod(x_Q, M_Q, pi/9);
mod_Q_25 = pskmod(x_Q, M_Q, pi/7.2);
mod_Q_30 = pskmod(x_Q, M_Q, pi/6);
mod_Q_35 = pskmod(x_Q, M_Q, pi/5.143);
mod_Q_40 = pskmod(x_Q, M_Q, pi/4.5);
mod_Q_45 = pskmod(x_Q, M_Q, pi/4);
mod_Q_50 = pskmod(x_Q, M_Q, pi/3.6);
mod_Q_55 = pskmod(x_Q, M_Q, pi/3.273);
mod_Q_60 = pskmod(x_Q, M_Q, pi/3);
mod_Q_65 = pskmod(x_Q, M_Q, pi/2.77);
mod_Q_70 = pskmod(x_Q, M_Q, pi/2.571);
mod_Q_75 = pskmod(x_Q, M_Q, pi/2.4);
mod_Q_80 = pskmod(x_Q, M_Q, pi/2.25);
mod_Q_85 = pskmod(x_Q, M_Q, pi/2.118);
mod_Q_90 = pskmod(x_Q, M_Q, pi/2);
figure; 
subplot(4, 5, 1);
plot(real(mod_Q_5), imag(mod_Q_5), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 2);
plot(real(mod_Q_10), imag(mod_Q_10), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 3);
plot(real(mod_Q_15), imag(mod_Q_15), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 4);
plot(real(mod_Q_20), imag(mod_Q_20), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 5);
plot(real(mod_Q_25), imag(mod_Q_25), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 6);
plot(real(mod_Q_30), imag(mod_Q_30), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 7);
plot(real(mod_Q_35), imag(mod_Q_35), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 8);
plot(real(mod_Q_40), imag(mod_Q_40), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 9);
plot(real(mod_Q_45), imag(mod_Q_45), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 10);
plot(real(mod_Q_50), imag(mod_Q_50), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 11);
plot(real(mod_Q_55), imag(mod_Q_55), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 12);
plot(real(mod_Q_60), imag(mod_Q_60), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 13);
plot(real(mod_Q_65), imag(mod_Q_65), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 14);
plot(real(mod_Q_70), imag(mod_Q_70), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 15);
plot(real(mod_Q_75), imag(mod_Q_75), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 16);
plot(real(mod_Q_80), imag(mod_Q_80), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 17);
plot(real(mod_Q_85), imag(mod_Q_85), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(4, 5, 18);
plot(real(mod_Q_90), imag(mod_Q_90), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
%% 8PSK
M_8 = 8;
x_8 = (0:M_8-1)';

mod_8_5 = pskmod(x_8, M_8, pi/36); 
mod_8_10 = pskmod(x_8, M_8, pi/18);
mod_8_15 = pskmod(x_8, M_8, pi/12);
mod_8_20 = pskmod(x_8, M_8, pi/9);
mod_8_25 = pskmod(x_8, M_8, pi/7.2);
mod_8_30 = pskmod(x_8, M_8, pi/6);
mod_8_35 = pskmod(x_8, M_8, pi/5.143);
mod_8_40 = pskmod(x_8, M_8, pi/4.5);
mod_8_45 = pskmod(x_8, M_8, pi/4);

figure; 
subplot(3, 3, 1);
plot(real(mod_8_5), imag(mod_8_5), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 2);
plot(real(mod_8_10), imag(mod_8_10), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 3);
plot(real(mod_8_15), imag(mod_8_15), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 4);
plot(real(mod_8_20), imag(mod_8_20), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 5);
plot(real(mod_8_25), imag(mod_8_25), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 6);
plot(real(mod_8_30), imag(mod_8_30), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 7);
plot(real(mod_8_35), imag(mod_8_35), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 8);
plot(real(mod_8_40), imag(mod_8_40), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)
subplot(3, 3, 9);
plot(real(mod_8_45), imag(mod_8_45), 'x');
axis([-2 2 -2 2]);
xline(0)
yline(0)

%% 16QAM
M_16 = 16;
x_16 = (0:M_16-1)';

figure;
for phase_num = 2:2:18
    mod_16 = qammod(x_16, M_16, 'UnitAveragePower',true).* exp(1i*pi/phase(phase_num));

    subplot(3, 3, phase_num/2)
    plot(real(mod_16), imag(mod_16), 'x');

end
%% 64QAM
M_64 = 64;
x_64 = (0:M_64-1)';

figure;
for phase_num = 2:2:18
    mod_16 = qammod(x_64, M_64, 'UnitAveragePower',true).* exp(1i*pi/phase(phase_num));

    subplot(3, 3, phase_num/2)
    plot(real(mod_16), imag(mod_16), 'x');

end
