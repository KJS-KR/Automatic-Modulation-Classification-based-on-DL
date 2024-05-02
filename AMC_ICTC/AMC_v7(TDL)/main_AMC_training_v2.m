clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numRep          = 4;
numFrame        = 1000;
    
trainDataRatio  = 0.8;
validDataRatio  = 0.2;

tdl             = nrTDLChannel();

%% 신호 생성

% QPSK
txSigQpsk = randi([0 3], spf, 1);
modQpskSig = pskmod(txSigQpsk, 4, pi/4);
repQpskSig = [];
for rep = 1:numRep
    tdlQpskSig = tdl(modQpskSig);
    awgnQpskSig = awgn(tdlQpskSig, 10);
    repQpskSig = vertcat(repQpskSig, awgnQpskSig);
end

% 16QAM
txSig16qam = randi([0 15], spf, 1);
mod16qamSig = qammod(txSig16qam, 16);
rep16qamSig = [];
for rep = 1:numRep
    tdl16qamSig = tdl(mod16qamSig);
    awgn16qamSig = awgn(tdl16qamSig, 10);
    rep16qamSig = vertcat(rep16qamSig, awgn16qamSig);
end

% 64QAM
txSig64qam = randi([0 63], spf, 1);
mod64qamSig = qammod(txSig64qam, 64);
rep64qamSig = [];
for rep = 1:numRep
    tdl64qamSig = tdl(mod64qamSig);
    awgn64qamSig = awgn(tdl64qamSig, 10);
    rep64qamSig = vertcat(rep64qamSig, awgn64qamSig);
end

% 256QAM
txSig256qam = randi([0 255], spf, 1);
mod256qamSig = qammod(txSig256qam, 256);
rep256qamSig = [];
for rep = 1:numRep
    tdl256qamSig = tdl(mod256qamSig);
    awgn256qamSig = awgn(tdl256qamSig, 10);
    rep256qamSig = vertcat(rep256qamSig, awgn256qamSig);
end
%% 신호 확인

figure;
subplot(2, 2, 1)
plot(real(modQpskSig), imag(modQpskSig), 'x')
subplot(2, 2, 2)
plot(real(mod16qamSig), imag(mod16qamSig), 'x')
subplot(2, 2, 3)
plot(real(mod64qamSig), imag(mod64qamSig), 'x')
subplot(2, 2, 4)
plot(real(mod256qamSig), imag(mod256qamSig), 'x')


figure;
subplot(2, 2, 1)
plot(real(repQpskSig), imag(repQpskSig), 'x')
subplot(2, 2, 2)
plot(real(rep16qamSig), imag(rep16qamSig), 'x')
subplot(2, 2, 3)
plot(real(rep64qamSig), imag(rep64qamSig), 'x')
subplot(2, 2, 4)
plot(real(rep256qamSig), imag(rep256qamSig), 'x')
