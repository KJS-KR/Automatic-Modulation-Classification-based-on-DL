clc; clear; close all;

%% Data set generation
modTypes = categorical(["QPSK", "16QAM", "64QAM"]); % 변조유형 라벨
numModTypes = length(modTypes); %변조유형 수

snr = -4:2:20;   %신호 대 잡음비(dB)
spf = 1024;   % 프레임 당 샘플 수

N_Frame = 100000;          % 훈련 + 검증 + 테스트 프레임 개수 (총 데이터 수)
trainDataRatio = 0.8;   % 훈련 프레임 비율
validDataRatio = 0.1;   % 검증 프레임 비율
testDataRatio = 0.1;   % 테스트 프레임 비율

% rxTrainFrames: 1 x N_frame x 2 (real,imag) x Ntrain*numModTypes
% rxTrainLabels: categorical 배열, 
% rxValidFrames: 1 x N_frame x 2 (real,imag) x Nvalid*numModTypes
% rxValidLabels: categorical 배열, 

for n = 8:8
    % OFDM QPSK 
    fftSize         = N_Frame * spf; modNum = 4;     
    randSyms        = randi([0 modNum-1], fftSize, 1);
    sigQpsk         = pskmod(randSyms, modNum, pi/4);
    fftSigQpsk      = fft(sigQpsk, fftSize)/sqrt(fftSize);
    awgnSigQpsk     = awgn(fftSigQpsk, snr(n));
    dfftSigQpsk     = ifft(awgnSigQpsk)*sqrt(fftSize);
    sigQpsk         = reshape(dfftSigQpsk, spf, N_Frame);
    ofdmQpsk(:,1,:) = real(sigQpsk);
    ofdmQpsk(:,2,:) = imag(sigQpsk);
    
    % OFDM 16QAM
    fftSize             = N_Frame * spf; modNum = 16;     
    randSyms            = randi([0 modNum-1], fftSize, 1);
    sig16qam            = qammod(randSyms, modNum, 'UnitAveragePower' ,true);
    fftSig16qam         = fft(sig16qam, fftSize)/sqrt(fftSize);
    awgnSig16qam        = awgn(fftSig16qam , snr(n));
    dfftSig16qam        = ifft(awgnSig16qam )*sqrt(fftSize);
    sig16qam            = reshape(dfftSig16qam , spf, N_Frame);
    ofdm16qam(:,1,:)    = real(sig16qam);
    ofdm16qam(:,2,:)    = imag(sig16qam);
    
    % OFDM 64QAM
    fftSize             = N_Frame * spf; modNum = 64;     
    randSyms            = randi([0 modNum-1], fftSize, 1);
    sig64qam            = qammod(randSyms, modNum, 'UnitAveragePower' ,true);
    fftSig64qam         = fft(sig64qam, fftSize)/sqrt(fftSize);
    awgnSig64qam        = awgn(fftSig64qam , snr(n));
    dfftSig64qam        = ifft(awgnSig64qam)*sqrt(fftSize);
    sig64qam            = reshape(dfftSig64qam , spf, N_Frame);
    ofdm64qam(:,1,:)    = real(sig64qam);
    ofdm64qam(:,2,:)    = imag(sig64qam);
    
    % total training set
    data_tr(:,:,1:N_Frame*trainDataRatio) = ofdmQpsk(:,:,1:N_Frame*trainDataRatio);
    data_tr(:,:,N_Frame*trainDataRatio+1:N_Frame*trainDataRatio*2) = ofdm16qam(:,:,1:N_Frame*trainDataRatio);
    data_tr(:,:,N_Frame*trainDataRatio*2+1:N_Frame*trainDataRatio*3) = ofdm64qam(:,:,1:N_Frame*trainDataRatio);
    
    data_va(:,:,1:N_Frame*validDataRatio) = ofdmQpsk(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
    data_va(:,:,N_Frame*validDataRatio+1:N_Frame*validDataRatio*2) = ofdm16qam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
    data_va(:,:,N_Frame*validDataRatio*2+1:N_Frame*validDataRatio*3) = ofdm64qam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
    
    data_te(:,:,1:N_Frame*validDataRatio) = ofdmQpsk(:,:,1+N_Frame*trainDataRatio+N_Frame*testDataRatio:N_Frame*trainDataRatio+N_Frame*testDataRatio+N_Frame*testDataRatio);
    data_te(:,:,N_Frame*validDataRatio+1:N_Frame*validDataRatio*2) = ofdm16qam(:,:,1+N_Frame*trainDataRatio+N_Frame*testDataRatio:N_Frame*trainDataRatio+N_Frame*testDataRatio+N_Frame*testDataRatio);
    data_te(:,:,N_Frame*validDataRatio*2+1:N_Frame*validDataRatio*3) = ofdm64qam(:,:,1+N_Frame*trainDataRatio+N_Frame*testDataRatio:N_Frame*trainDataRatio+N_Frame*testDataRatio+N_Frame*testDataRatio);
    
    %% training set & validation set & test set
    
    % training set
    for n = 1:N_Frame* trainDataRatio * numModTypes 
        rxTrainFrames(1,:,:,n) = data_tr(:,:,n);
        if n <=N_Frame* trainDataRatio
            rxTrainLabels(n) = modTypes(1);
        elseif n<=N_Frame* trainDataRatio *2
            rxTrainLabels(n) = modTypes(2);
        elseif n>N_Frame* trainDataRatio *2
            rxTrainLabels(n) = modTypes(3);
        end
    end
    
    % validation set
    for n = 1:N_Frame* validDataRatio * numModTypes 
        rxValidFrames(1,:,:,n) = data_va(:,:,n);
        if n <=N_Frame* validDataRatio
            rxValidLabels(n) = modTypes(1);
        elseif n<=N_Frame* validDataRatio *2
            rxValidLabels(n) = modTypes(2);
        elseif n>N_Frame* validDataRatio *2
            rxValidLabels(n) = modTypes(3);
        end
    end
    
    % test set
    for n = 1:N_Frame* testDataRatio * numModTypes 
        rxTestFrames(1,:,:,n) = data_te(:,:,n);
        if n <=N_Frame* testDataRatio
            rxTestLabels(n) = modTypes(1);
        elseif n<=N_Frame* testDataRatio *2
            rxTestLabels(n) = modTypes(2);
        elseif n>N_Frame* testDataRatio *2
            rxTestLabels(n) = modTypes(3);
        end
    end
    
    %% CNN 훈련시키기
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
    
    
    maxEpochs       = 15;
    miniBatchSize   = 256;
    
    validationFrequency = floor(numel(rxTrainLabels)/miniBatchSize);
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
    
    rxTestPred      = classify(trainedNet,rxTestFrames);
    testAccuracy    = mean(rxTestPred == rxTestLabels);
    % disp("Test accuracy: " + testAccuracy*100 + "%")
    
    figure
    cm                  = confusionchart(rxTestLabels, rxTestPred);
    cm.Title            = 'Confusion Matrix for Test Data';
    cm.RowSummary       = 'row-normalized';
    cm.Parent.Position  = [cm.Parent.Position(1:2) 740 424];
end