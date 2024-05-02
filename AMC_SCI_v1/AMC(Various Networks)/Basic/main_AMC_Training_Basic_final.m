clc; clear; close all;

%% Set the paramether
modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % Name of modulation type
numModTypes     = length(modTypes);                                     % Number of modulation type

snr             = -10:2:20;     % Signal-to-Noise(dB)
spf             = 512;          % Samples per frame

numFrame        = 100000;        % Number of total data
trainDataRatio  = 0.8;          % Training data ratio
validDataRatio  = 0.2;          % Validation data ratio
% testDataRatio = 0.1;           % Test data ratio

% Resource grid parameters
sl_ResourcePoolconfig.Nsc   = 600;      % Number of subcarrier
sl_ResourcePoolconfig.Nsyms = 1;        % Number of symbol
nr_CarrierConfig.SCS        = 30*10^3;  % Interval between subcarriers
nr_CarrierConfig.Nfft       = 1024;     % Size of FFT
nr_CarrierConfig.velocity   = 100;      % in km/h
nr_CarrierConfig.fc         = 4*10^9;   % in Hz

Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);

tstart = tic;
tList = [];

%% Create CNN structure 
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

%% Data Generation
for snrIdx = 1:length(snr)
    parfor frameIdx = 1:numFrame
        Hout            = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % QPSK
        txQpskSig       = randi([0 3], spf, 1);
        modQpskSig      = pskmod(txQpskSig, 4, pi/4);
        tdlQpskSig      = Hout(1:512).*modQpskSig;
        awgnQpskSig     = awgn(tdlQpskSig, snr(snrIdx));
        totalQpskSig(:, :, frameIdx) = awgnQpskSig;

        Hout            = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 16QAM
        tx16qamSig      = randi([0 15], spf, 1);
        mod16qamSig     = qammod(tx16qamSig, 16, 'UnitAveragePower', true);
        tdl16qamSig     = Hout(1:512).*mod16qamSig;
        awgn16qamSig    = awgn(tdl16qamSig, snr(snrIdx));
        total16qamSig(:, :, frameIdx) = awgn16qamSig;

        Hout            = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 64QAM
        tx64qamSig      = randi([0 63], spf, 1);
        mod64qamSig     = qammod(tx64qamSig, 64, 'UnitAveragePower', true);
        tdl64qamSig     = Hout(1:512).*mod64qamSig;
        awgn64qamSig    = awgn(tdl64qamSig, snr(snrIdx));
        total64qamSig(:, :, frameIdx) = awgn64qamSig;

        Hout            = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 256QAM
        tx256qamSig     = randi([0 255], spf, 1);
        mod256qamSig    = qammod(tx256qamSig, 256, 'UnitAveragePower', true);
        tdl256qamSig    = Hout(1:512).*mod256qamSig;
        awgn256qamSig   = awgn(tdl256qamSig, snr(snrIdx));
        total256qamSig(:, :, frameIdx) = awgn256qamSig;
    end

    % Divide real part or imaginary part
    dataQpsk(:,1,:)     = real(totalQpskSig);
    dataQpsk(:,2,:)     = imag(totalQpskSig);

    data16qam(:,1,:)    = real(total16qamSig);
    data16qam(:,2,:)    = imag(total16qamSig);

    data64qam(:,1,:)    = real(total64qamSig);
    data64qam(:,2,:)    = imag(total64qamSig);

    data256qam(:,1,:)   = real(total256qamSig);
    data256qam(:,2,:)   = imag(total256qamSig);

    % Total training datasets
    trainingData(:,:,1:numFrame*trainDataRatio)                                 = dataQpsk(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio+1:numFrame*trainDataRatio*2)       = data16qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*2+1:numFrame*trainDataRatio*3)     = data64qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*3+1:numFrame*trainDataRatio*4)     = data256qam(:,:,1:numFrame*trainDataRatio);
    
    validationData(:,:,1:numFrame*validDataRatio)                               = dataQpsk(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio+1:numFrame*validDataRatio*2)     = data16qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*2+1:numFrame*validDataRatio*3)   = data64qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*3+1:numFrame*validDataRatio*4)   = data256qam(:,:,1+numFrame*trainDataRatio:numFrame);

    % Laveling the training data
    parfor n = 1:numFrame* trainDataRatio * numModTypes 
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
    
    % Laveling the validation data
    parfor n = 1:numFrame* validDataRatio * numModTypes 
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

%% Set the hyper parameters
    maxEpochs           = 25;
    miniBatchSize       = 512;
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

%% Training network and processing time
    tic;
    trainedNet = trainNetwork(rxTrainFrames,rxTrainLabels,modClassNet,options);
    tMul = toc;

    tList = horzcat(tList, tMul);

    exportONNXNetwork(trainedNet, snr(snrIdx) + "dB_AMC_Network.onnx")
end