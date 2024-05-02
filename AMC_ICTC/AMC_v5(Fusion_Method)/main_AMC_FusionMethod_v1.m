clc; clear; close all;

%% Setting

modTypes    = categorical(["BPSK", "QPSK", "8PSK", "16QAM", "32QAM", "64QAM", "4PAM", "8PAM"]);
numModTypes = length(modTypes);     

spf                 = 2048;          % 프레임 당 샘플 수
N_Frame             = 10000;         % 프레임 수
totalSignal         = spf * N_Frame; 
snr                 = -10:2:20;     % 신호 대 잡음비(dB)
numSnr              = length(snr);  
trainDataRatio      = 0.8;          % 훈련 프레임 비율
validDataRatio      = 0.2;          % 검증 프레임 비율

for idx = 1:numSnr
    %% BPSK 신호 생성
    modNumBpsk = 2;
    randBit = randi([0 modNumBpsk-1], totalSignal, 1);
    sigBpsk = pskmod(randBit, 2);
    
    % figure;
    % subplot(3, 3, 1)
    % plot(real(sigBpsk), imag(sigBpsk), 'x');
    % title("BPSK")
    % axis([-2 2 -2 2])
    
    %% QPSK 신호 생성
    modNumQpsk = 4;
    randBit = randi([0 modNumQpsk-1], totalSignal, 1);
    sigQpsk = pskmod(randBit, 4, pi/4);
    
    % subplot(3, 3, 2)
    % plot(real(sigQpsk), imag(sigQpsk), 'x');
    % title("QPSK")
    % axis([-2 2 -2 2])
    
    %% 8PSK 신호 생성
    modNum8psk = 8;
    randBit = randi([0 modNum8psk-1], totalSignal, 1);
    sig8psk = pskmod(randBit, 8, pi/4);
    
    % subplot(3, 3, 3)
    % plot(real(sig8psk), imag(sig8psk), 'x');
    % title("8PSK")
    % axis([-2 2 -2 2])
    
    %% 16QAM 신호 생성
    modNum16qam = 16;
    randBit = randi([0 modNum16qam-1], totalSignal, 1);
    sig16qam = qammod(randBit, modNum16qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 4)
    % plot(real(sig16qam), imag(sig16qam), 'x');
    % title("16QAM")
    % axis([-2 2 -2 2])
    
    %% 32QAM 신호 생성
    modNum32qam = 32;
    randBit = randi([0 modNum32qam-1], totalSignal, 1);
    sig32qam = qammod(randBit, modNum32qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 5)
    % plot(real(sig32qam), imag(sig32qam), 'x');
    % title("32QAM")
    % axis([-2 2 -2 2])
    
    %% 64QAM 신호 생성
    modNum64qam = 64;
    randBit = randi([0 modNum64qam-1], totalSignal, 1);
    sig64qam = qammod(randBit, modNum64qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 6)
    % plot(real(sig64qam), imag(sig64qam), 'x');
    % title("64QAM")
    % axis([-2 2 -2 2])
    
    %% 4PAM 신호 생성
    modNum4pam = 4;
    randBit = randi([0 modNum4pam-1], totalSignal, 1);
    sig4pam = pammod(randBit, modNum4pam);
    sig4pam = normalize(sig4pam);
    
    % subplot(3, 3, 7)
    % plot(real(sig4pam), imag(sig4pam), 'x');
    % title("4PAM")
    % axis([-2 2 -2 2])
    
    %% 8PAM 신호 생성
    modNum8pam = 8;
    randBit = randi([0 modNum8pam-1], totalSignal, 1);
    sig8pam = pammod(randBit, modNum8pam);
    sig8pam = normalize(sig8pam);
    
    % subplot(3, 3, 8)
    % plot(real(sig8pam), imag(sig8pam), 'x');
    % title("8PAM")
    % axis([-2 2 -2 2])
    
    %% 데이터셋 생성 및 분할
    
    % snr2 = 10;
    
    % BPSK
    awgnSigBpsk = awgn(sigBpsk, snr(idx));
    
    % figure;
    % subplot(3, 3, 1)
    % plot(real(awgnSigBpsk), imag(awgnSigBpsk), 'x');
    % title("BPSK")
    
    sigBpsk = reshape(awgnSigBpsk, spf, N_Frame);
    dataBpsk(:,1,:) = real(sigBpsk);
    dataBpsk(:,2,:) = imag(sigBpsk);
    
    % QPSK
    awgnSigQpsk = awgn(sigQpsk, snr(idx));
    
    % subplot(3, 3, 2)
    % plot(real(awgnSigQpsk), imag(awgnSigQpsk), 'x');
    % title("QPSK")
    
    sigQpsk = reshape(awgnSigQpsk, spf, N_Frame);
    dataQpsk(:,1,:) = real(sigQpsk);
    dataQpsk(:,2,:) = imag(sigQpsk);
    
    % 8PSK
    awgnSig8psk = awgn(sig8psk, snr(idx));
    
    % subplot(3, 3, 3)
    % plot(real(awgnSig8psk), imag(awgnSig8psk), 'x');
    % title("8PSK")
    
    sig8psk = reshape(awgnSig8psk, spf, N_Frame);
    data8psk(:,1,:) = real(sig8psk);
    data8psk(:,2,:) = imag(sig8psk);
    
    % 16QAM
    awgnSig16qam = awgn(sig16qam, snr(idx));
    
    % subplot(3, 3, 4)
    % plot(real(awgnSig16qam), imag(awgnSig16qam), 'x');
    % title("16QAM")
    
    sig16qam = reshape(awgnSig16qam, spf, N_Frame);
    data16qam(:,1,:) = real(sig16qam);
    data16qam(:,2,:) = imag(sig16qam);
    
    % 32QAM
    awgnSig32qam = awgn(sig32qam, snr(idx));
    
    % subplot(3, 3, 5)
    % plot(real(awgnSig32qam), imag(awgnSig32qam), 'x');
    % title("32QAM")
    
    sig32qam = reshape(awgnSig32qam, spf, N_Frame);
    data32qam(:,1,:) = real(sig32qam);
    data32qam(:,2,:) = imag(sig32qam);
    
    % 64QAM
    awgnSig64qam = awgn(sig64qam, snr(idx));
    
    % subplot(3, 3, 6)
    % plot(real(awgnSig64qam), imag(awgnSig64qam), 'x');
    % title("64QAM")
    
    sig64qam = reshape(awgnSig64qam, spf, N_Frame);
    data64qam(:,1,:) = real(sig64qam);
    data64qam(:,2,:) = imag(sig64qam);
    
    % 4PAM
    awgnSig4pam = awgn(sig4pam, snr(idx));
    
    % subplot(3, 3, 7)
    % plot(real(awgnSig4pam), imag(awgnSig4pam), 'x');
    % title("4PAM")
    
    sig4pam = reshape(awgnSig4pam, spf, N_Frame);
    data4pam(:,1,:) = real(sig4pam);
    data4pam(:,2,:) = imag(sig4pam);
    
    % 8PAM
    awgnSig8pam = awgn(sig8pam, snr(idx));
    
    % subplot(3, 3, 8)
    % plot(real(awgnSig8pam), imag(awgnSig8pam), 'x');
    % title("8PAM")
    
    sig8pam = reshape(awgnSig8pam, spf, N_Frame);
    data8pam(:,1,:) = real(sig8pam);
    data8pam(:,2,:) = imag(sig8pam);
    
    % Total Training Set
    trainingData(:,:,1:N_Frame*trainDataRatio) = dataBpsk(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio+1:N_Frame*trainDataRatio*2) = dataQpsk(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*2+1:N_Frame*trainDataRatio*3) = data8psk(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*3+1:N_Frame*trainDataRatio*4) = data16qam(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*4+1:N_Frame*trainDataRatio*5) = data32qam(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*5+1:N_Frame*trainDataRatio*6) = data64qam(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*6+1:N_Frame*trainDataRatio*7) = data4pam(:,:,1:N_Frame*trainDataRatio);
    trainingData(:,:,N_Frame*trainDataRatio*7+1:N_Frame*trainDataRatio*8) = data8pam(:,:,1:N_Frame*trainDataRatio);
    
    validationData(:,:,1:N_Frame*validDataRatio) = dataBpsk(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio+1:N_Frame*validDataRatio*2) = dataQpsk(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*2+1:N_Frame*validDataRatio*3) = data8psk(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*3+1:N_Frame*validDataRatio*4) = data16qam(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*4+1:N_Frame*validDataRatio*5) = data32qam(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*5+1:N_Frame*validDataRatio*6) = data64qam(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*6+1:N_Frame*validDataRatio*7) = data4pam(:,:,1+N_Frame*trainDataRatio:N_Frame);
    validationData(:,:,N_Frame*validDataRatio*7+1:N_Frame*validDataRatio*8) = data8pam(:,:,1+N_Frame*trainDataRatio:N_Frame);
    
    % Labeling Training Set
    for n = 1:N_Frame* trainDataRatio * numModTypes 
        rxTrainFrames(1,:,:,n) = trainingData(:,:,n);
        if n <=N_Frame* trainDataRatio
            rxTrainLabels(n) = modTypes(1);
        elseif n<=N_Frame* trainDataRatio *2
            rxTrainLabels(n) = modTypes(2);
        elseif n<=N_Frame* trainDataRatio *3
            rxTrainLabels(n) = modTypes(3);
        elseif n<=N_Frame* trainDataRatio *4
            rxTrainLabels(n) = modTypes(4);
        elseif n<=N_Frame* trainDataRatio *5
            rxTrainLabels(n) = modTypes(5);
        elseif n<=N_Frame* trainDataRatio *6
            rxTrainLabels(n) = modTypes(6);
        elseif n<=N_Frame* trainDataRatio *7
            rxTrainLabels(n) = modTypes(7);
        elseif n>N_Frame* trainDataRatio *7
            rxTrainLabels(n) = modTypes(8);
        end
    end
    
    % Labeling Validation Set
    for n = 1:N_Frame* validDataRatio * numModTypes 
        rxValidFrames(1,:,:,n) = validationData(:,:,n);
        if n <=N_Frame* validDataRatio
            rxValidLabels(n) = modTypes(1);
        elseif n<=N_Frame* validDataRatio *2
            rxValidLabels(n) = modTypes(2);
        elseif n<=N_Frame* validDataRatio *3
            rxValidLabels(n) = modTypes(3);
        elseif n<=N_Frame* validDataRatio *4
            rxValidLabels(n) = modTypes(4);
        elseif n<=N_Frame* validDataRatio *5
            rxValidLabels(n) = modTypes(5);
        elseif n<=N_Frame* validDataRatio *6
            rxValidLabels(n) = modTypes(6);
        elseif n<=N_Frame* validDataRatio *7
            rxValidLabels(n) = modTypes(7);
        elseif n>N_Frame* validDataRatio *7
            rxValidLabels(n) = modTypes(8);
        end
    end
    
    netWidth    = 1;
    filterSize  = [1 8];
    poolSize    = [1 2];
    modClassNet = [
        imageInputLayer([1 spf 2], 'Normalization', 'none', 'Name', 'Input Layer')
        
        convolution2dLayer(filterSize, 16*netWidth, 'Padding', 'same', 'Name', 'CNN1')
        batchNormalizationLayer('Name', 'BN1')
        reluLayer('Name', 'ReLU1')
        maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool1')
        
        convolution2dLayer(filterSize, 24*netWidth, 'Padding', 'same', 'Name', 'CNN2')
        batchNormalizationLayer('Name', 'BN2')
        reluLayer('Name', 'ReLU2')
        maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool2')
        
        convolution2dLayer(filterSize, 32*netWidth, 'Padding', 'same', 'Name', 'CNN3')
        batchNormalizationLayer('Name', 'BN3')
        reluLayer('Name', 'ReLU3')
        maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool3')
        
        convolution2dLayer(filterSize, 48*netWidth, 'Padding', 'same', 'Name', 'CNN4')
        batchNormalizationLayer('Name', 'BN4')
        reluLayer('Name', 'ReLU4')
        maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool4')
        
        convolution2dLayer(filterSize, 64*netWidth, 'Padding', 'same', 'Name', 'CNN5')
        batchNormalizationLayer('Name', 'BN5')
        reluLayer('Name', 'ReLU5')
        maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool5')
        
        convolution2dLayer(filterSize, 96*netWidth, 'Padding', 'same', 'Name', 'CNN6')
        batchNormalizationLayer('Name', 'BN6')
        reluLayer('Name', 'ReLU6')
        
        averagePooling2dLayer([1 ceil(spf/32)], 'Name', 'AP1')
        
        fullyConnectedLayer(numModTypes, 'Name', 'FC1')
        softmaxLayer('Name', 'SoftMax')
        
        classificationLayer('Name', 'Output') ];
    
    maxEpochs           = 30;
    miniBatchSize       = 128;
    trainingSize        = numel(rxTrainLabels);
    validationFrequency = floor(trainingSize/miniBatchSize);
    
    options = trainingOptions('sgdm', ...
          'InitialLearnRate',2e-2, ...
          'MaxEpochs',maxEpochs, ...
          'MiniBatchSize',miniBatchSize, ...
          'Shuffle','every-epoch', ...
          'Plots','training-progress', ...
          'Verbose',false, ...
          'ValidationData',{rxValidFrames,rxValidLabels}, ...
          'ValidationFrequency',validationFrequency, ...
          'LearnRateSchedule', 'piecewise', ...
          'LearnRateDropPeriod', 9, ...
          'LearnRateDropFactor', 0.1);
    
    trainedNet      = trainNetwork(rxTrainFrames,rxTrainLabels,modClassNet,options);
    exportONNXNetwork(trainedNet, snr(idx) + "dB_AMC_network")
end