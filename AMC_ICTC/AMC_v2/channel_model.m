clc; clear; close all;

% channel model parameters
v  = 3.0;                    % UE velocity in km/h
fc = 4e9;                    % carrier frequency in Hz
c  = physconst('lightspeed'); % speed of light in m/s
fd = (v*1000/3600)/c*fc;     % UE max Doppler frequency in Hz

bits = randi([0 1],2,1000);

x_qpsk = (1-2*bits(1,:))/sqrt(2)+(1-2*bits(2,:))/sqrt(2)*1j;

figure;
plot(real(x_qpsk),imag(x_qpsk),'x');

% UL channel model
tdl_ul = nrTDLChannel;
tdl_ul.DelayProfile = 'TDL-C';
tdl_ul.NumTransmitAntennas = 1;
tdl_ul.NumReceiveAntennas = 1;
tdl_ul.DelaySpread = 100e-9;
tdl_ul.MaximumDopplerShift = fd;
tdl_ul.RandomStream = 'Global stream'; % random generation

% sigIn = [1; zeros(100,1)];
%     sigOut = tdl_ul(sigIn);

sigIn = x_qpsk.';
sigOut = tdl_ul(sigIn);
y=sigOut;

h = [1 0.5 0.25];
figure;
stem(h,'o');

y = conv(h,x_qpsk);
figure;
plot(real(y),imag(y),'x');