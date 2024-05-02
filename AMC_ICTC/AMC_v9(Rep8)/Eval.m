clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numFrame        = 3000;
numSegment      = 8;

total = [];

txSigQpsk = randi([0 3], spf, 1);
modQpskSig = pskmod(txSigQpsk, 4, pi/4);
awgnQpskSig = cell(numSegment, 1);
for segIdx = 1:numSegment
    awgnQpskSig{segIdx} = awgn(modQpskSig, 10);
end

subplot(2,2,1)
plot(real(awgnQpskSig{1}), imag(awgnQpskSig{1}), 'x')
subplot(2,2,2)
plot(real(awgnQpskSig{2}), imag(awgnQpskSig{2}), 'x')
subplot(2,2,3)
plot(real(awgnQpskSig{3}), imag(awgnQpskSig{3}), 'x')
subplot(2,2,4)
plot(real(awgnQpskSig{4}), imag(awgnQpskSig{4}), 'x')

for segIdx = 1:numSegment
    total = vertcat(total, awgnQpskSig{segIdx});
end