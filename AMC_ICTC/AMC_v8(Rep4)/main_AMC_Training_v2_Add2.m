clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numFrame        = 150000;
    
trainDataRatio  = 0.8;
validDataRatio  = 0.2;

% tdl             = nrTDLChannel('NumReceiveAntennas', 1);

%% 신호 생성
for snrIdx = 17:17
    parfor frameIdx = 1:numFrame
        % QPSK
        txSigQpsk = randi([0 3], spf, 1);
        modQpskSig = pskmod(txSigQpsk, 4, pi/4);
        awgnQpskSig1 = awgn(modQpskSig, snr(snrIdx));
        awgnQpskSig2 = awgn(modQpskSig, snr(snrIdx));
        addSigQpsk = awgnQpskSig1 + awgnQpskSig2;
        totalSigQpsk(:, :, frameIdx) = addSigQpsk;
        
        % 16QAM
        txSig16qam = randi([0 15], spf, 1);
        mod16qamSig = qammod(txSig16qam, 16, 'UnitAveragePower', true);
        awgn16qamSig1 = awgn(mod16qamSig, snr(snrIdx));
        awgn16qamSig2 = awgn(mod16qamSig, snr(snrIdx));
        addSig16qam = awgn16qamSig1 + awgn16qamSig2;
        totalSig16qam(:, :, frameIdx) = addSig16qam;
    
        % 64QAM
        txSig64qam = randi([0 63], spf, 1);
        mod64qamSig = qammod(txSig64qam, 64, 'UnitAveragePower', true);
        awgn64qamSig1 = awgn(mod64qamSig, snr(snrIdx));
        awgn64qamSig2 = awgn(mod64qamSig, snr(snrIdx));
        addSig64qam = awgn64qamSig1 + awgn64qamSig2;
        totalSig64qam(:, :, frameIdx) = addSig64qam;
    
        
        % 256QAM
        txSig256qam = randi([0 255], spf, 1);
        mod256qamSig = qammod(txSig256qam, 256, 'UnitAveragePower', true);
        awgn256qamSig1 = awgn(mod256qamSig, snr(snrIdx));
        awgn256qamSig2 = awgn(mod256qamSig, snr(snrIdx));
        addSig256qam = awgn256qamSig1 + awgn256qamSig2;
        totalSig256qam(:, :, frameIdx) = addSig256qam;
    end

%% 데이터셋 생성 및 분할
    % 실수, 복소수 분리
    dataQpsk(:,1,:) = real(totalSigQpsk);
    dataQpsk(:,2,:) = imag(totalSigQpsk);

    data16qam(:,1,:) = real(totalSig16qam);
    data16qam(:,2,:) = imag(totalSig16qam);

    data64qam(:,1,:) = real(totalSig64qam);
    data64qam(:,2,:) = imag(totalSig64qam);

    data256qam(:,1,:) = real(totalSig256qam);
    data256qam(:,2,:) = imag(totalSig256qam);

    % 전체 훈련 데이터셋
    trainingData(:,:,1:numFrame*trainDataRatio) = dataQpsk(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio+1:numFrame*trainDataRatio*2) = data16qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*2+1:numFrame*trainDataRatio*3) = data64qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*3+1:numFrame*trainDataRatio*4) = data256qam(:,:,1:numFrame*trainDataRatio);
    
    validationData(:,:,1:numFrame*validDataRatio) = dataQpsk(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio+1:numFrame*validDataRatio*2) = data16qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*2+1:numFrame*validDataRatio*3) = data64qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*3+1:numFrame*validDataRatio*4) = data256qam(:,:,1+numFrame*trainDataRatio:numFrame);

    % 훈련 데이터셋 라벨링
    for n = 1:numFrame* trainDataRatio * numModTypes 
        rxTrainFrames(1,:,:,n) = trainingData(:,:,n);
        if n <=numFrame* trainDataRatio
            rxTrainLabels(n) = modTypes(1);
        elseif n<=numFrame* trainDataRatio *2
            rxTrainLabels(n) = modTypes(2);
        elseif n<=numFrame* trainDataRatio *3
            rxTrainLabels(n) = modTypes(3);
        elseif n<=numFrame* trainDataRatio *4
            rxTrainLabels(n) = modTypes(4);
        end
    end
    
    % 검증 데이터셋 라벨링
    for n = 1:numFrame* validDataRatio * numModTypes 
        rxValidFrames(1,:,:,n) = validationData(:,:,n);
        if n <=numFrame* validDataRatio
            rxValidLabels(n) = modTypes(1);
        elseif n<=numFrame* validDataRatio *2
            rxValidLabels(n) = modTypes(2);
        elseif n<=numFrame* validDataRatio *3
            rxValidLabels(n) = modTypes(3);
        elseif n<=numFrame* validDataRatio *4
            rxValidLabels(n) = modTypes(4);
        end
    end

%% 레이어 설정 및 학습
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
    
    maxEpochs           = 25;
    miniBatchSize       = 256;
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
    exportONNXNetwork(trainedNet, snr(snrIdx) + "dB_AMC_Network(Add2).onnx")
end