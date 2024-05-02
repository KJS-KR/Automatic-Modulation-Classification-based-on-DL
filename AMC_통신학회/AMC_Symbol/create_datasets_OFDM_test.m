%% 초기화
clc; close all; clear;

%% 기본 설정

modSymbolTypes = categorical(["QPSK_00_", "QPSK_01_", "QPSK_10_", "QPSK_11_"]);

numSymbolTypes = length(modSymbolTypes);

Repeat = 12;
SPF = 1000;
SNR = 20;
mod = 64;

rand = randi([0 mod-1], 1, SPF);

rand2dim = [];
for idx = 1:Repeat
    rand2dim = vertcat(rand2dim, rand);
end
modQ = pammod(rand2dim, 64);

awgnQ = awgn(modQ, SNR);

normQ = normalize(awgnQ);

orderData = reshape(normQ(1,:),length(normQ(1,:)),1);
symbolData = normQ(:,1);
figure;
plot(real(normQ(1,:)), imag(normQ(1,:)), 'x'); grid on;
figure;
plot(real(normQ(:,1)), imag(normQ(:,1)), 'x'); grid on;



