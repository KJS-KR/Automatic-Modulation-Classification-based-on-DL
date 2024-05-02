%% 세팅
clc; clear; close all;

%% 
modulationTypes = categorical(["QPSK", "8PSK"]);
numModulationTypes = length(modulationTypes);
% rng(1235)

% 수 만큼 프레임 생성
numFramesPerModType = 1;

% 신호 대 잡음비 (dB)
SNR = 0:5:30;

% Samples per symbol, 심볼당 샘플의 수
sps = 8;

% Samples per frame, 프레임당 샘플의 수
spf = 1024;

% 프레임당 심볼의 수
symbolsPerFrame = spf / sps;

% Sameple rate
% 1초 당 Sample의 갯수를 단위로 나타낸 것
fs = 200e3;

% Center frequencies
fc = [902e6 100e6];

%% 결합된 채널
% 프레임에 세 가지 채널 손상 적용


for Num = 1:1:7
        channel = helperModClassTestChannel(...
          'SNR', SNR(Num), ...
          'SampleRate', fs, ...
          'PathDelays', [0 1.8 3.4] / fs, ...
          'AveragePathGains', [0 -2 -10], ...
          'KFactor', 4, ...
          'MaximumDopplerShift', 4, ...
          'MaximumClockOffset', 5, ...
          'CenterFrequency', 902e6);

        chinfo = info(channel);
        transDelay = 50;
    figure;
    for modType = 2:2
        label = modulationTypes(modType);
        dataSrc = helperModClassGetSource(modulationTypes(modType), sps, 2*spf, fs);
        modulator = helperModClassGetModulator(modulationTypes(modType), sps, fs);

        x = dataSrc();
        y = modulator(x);
        rxSamples = channel(y);

%         subplot(3, 3, 8)
%         plot(real(rxSamples), imag(rxSamples), 'x');
%         title(['SNR = ', num2str(SNR(Num)), 'dB']);
%         xline(0)
%         yline(0)
        
        frame = helperModClassFrameGenerator(rxSamples, spf, spf, transDelay, sps);
        
        subplot(3, 3, 9)
        plot(real(frame), imag(frame), 'x');
        title("FrameGenerator 후 학습 데이터");
        xline(0)
        yline(0)
    end
end