clc; clear; close all;

%% Set the paramether
modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % 변조유형 라벨명
numModTypes     = length(modTypes);                                     % 변조유형 수

snr             = -10:2:20;     % Signal-to-Noise(dB)
spf             = 512;          % samples per frame

numFrame        = 10000;        % 훈련 + 검증 + 테스트 프레임 개수 (총 데이터 수)
trainDataRatio  = 0.8;          % 훈련 프레임 비율
validDataRatio  = 0.2;          % 검증 프레임 비율
% testDataRatio = 0.1;           % 테스트 프레임 비율

%% Data Generation
for snrIdx = 14:14 %length(snr)
    parfor frameIdx = 1:numFrame
        % QPSK
        txQpskSig = randi([0 3], spf, 1);
        modQpskSig = pskmod(txQpskSig, 4, pi/4);
        awgnQpskSig = awgn(modQpskSig, snr(snrIdx));
        totalQpskSig(:, :, frameIdx) = awgnQpskSig;

        % 16QAM
        tx16qamSig = randi([0 15], spf, 1);
        mod16qamSig = qammod(tx16qamSig, 16, 'UnitAveragePower', true);
        awgn16qamSig = awgn(mod16qamSig, snr(snrIdx));
        total16qamSig(:, :, frameIdx) = awgn16qamSig;

        % 64QAM
        tx64qamSig = randi([0 63], spf, 1);
        mod64qamSig = qammod(tx64qamSig, 64, 'UnitAveragePower', true);
        awgn64qamSig = awgn(mod64qamSig, snr(snrIdx));
        total64qamSig(:, :, frameIdx) = awgn64qamSig;

        % 256QAM
        tx256qamSig = randi([0 255], spf, 1);
        mod256qamSig = qammod(tx256qamSig, 256, 'UnitAveragePower', true);
        awgn256qamSig = awgn(mod256qamSig, snr(snrIdx));
        total256qamSig(:, :, frameIdx) = awgn256qamSig;
    end

    % divide between real part or imaginary part
    dataQpsk(:,1,:) = real(totalQpskSig);
    dataQpsk(:,2,:) = imag(totalQpskSig);

    data16qam(:,1,:) = real(total16qamSig);
    data16qam(:,2,:) = imag(total16qamSig);

    data64qam(:,1,:) = real(total64qamSig);
    data64qam(:,2,:) = imag(total64qamSig);

    data256qam(:,1,:) = real(total256qamSig);
    data256qam(:,2,:) = imag(total256qamSig);

    % Total training datasets
    trainingData(:,:,1:numFrame*trainDataRatio) = dataQpsk(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio+1:numFrame*trainDataRatio*2) = data16qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*2+1:numFrame*trainDataRatio*3) = data64qam(:,:,1:numFrame*trainDataRatio);
    trainingData(:,:,numFrame*trainDataRatio*3+1:numFrame*trainDataRatio*4) = data256qam(:,:,1:numFrame*trainDataRatio);
    
    validationData(:,:,1:numFrame*validDataRatio) = dataQpsk(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio+1:numFrame*validDataRatio*2) = data16qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*2+1:numFrame*validDataRatio*3) = data64qam(:,:,1+numFrame*trainDataRatio:numFrame);
    validationData(:,:,numFrame*validDataRatio*3+1:numFrame*validDataRatio*4) = data256qam(:,:,1+numFrame*trainDataRatio:numFrame);

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

%% Create network structure
    lgraph = layerGraph();

    tempLayers = [
        imageInputLayer([1 512 2],"Name","data","Normalization","zscore")
        convolution2dLayer([7 7],32,"Name","conv1","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn_conv1")
        reluLayer("Name","conv1_relu")
        maxPooling2dLayer([3 3],"Name","pool1","Padding","same")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res2a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn2a_branch2a")
        reluLayer("Name","res2a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res2a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn2a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res2a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn2a_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res2a")
        reluLayer("Name","res2a_relu")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res2b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn2b_branch2a")
        reluLayer("Name","res2b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res2b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn2b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res2b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn2b_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res2b")
        reluLayer("Name","res2b_relu")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res3a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch2a")
        reluLayer("Name","res3a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res3a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn3a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res3a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res3a")
        reluLayer("Name","res3a_relu")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res3b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn3b_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res3b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn3b_branch2a")
        reluLayer("Name","res3b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res3b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn3b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res3b")
        reluLayer("Name","res3b_relu")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res4a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res4a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch2a")
        reluLayer("Name","res4a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res4a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn4a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res4a")
        reluLayer("Name","res4a_relu")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res4b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn4b_branch1")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res4b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn4b_branch2a")
        reluLayer("Name","res4b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res4b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn4b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res4b")
        reluLayer("Name","res4b_relu")
        globalAveragePooling2dLayer("Name","gapool")
        fullyConnectedLayer(4,"Name","fc")
        softmaxLayer("Name","softmax")
        classificationLayer("Name","classoutput")];
    lgraph = addLayers(lgraph,tempLayers);
    
    % 헬퍼 변수 정리
    clear tempLayers;
    
    lgraph = connectLayers(lgraph,"pool1","res2a_branch2a");
    lgraph = connectLayers(lgraph,"pool1","res2a_branch1");
    lgraph = connectLayers(lgraph,"bn2a_branch2b","res2a/in1");
    lgraph = connectLayers(lgraph,"bn2a_branch1","res2a/in2");
    lgraph = connectLayers(lgraph,"res2a_relu","res2b_branch2a");
    lgraph = connectLayers(lgraph,"res2a_relu","res2b_branch1");
    lgraph = connectLayers(lgraph,"bn2b_branch1","res2b/in2");
    lgraph = connectLayers(lgraph,"bn2b_branch2b","res2b/in1");
    lgraph = connectLayers(lgraph,"res2b_relu","res3a_branch2a");
    lgraph = connectLayers(lgraph,"res2b_relu","res3a_branch1");
    lgraph = connectLayers(lgraph,"bn3a_branch1","res3a/in2");
    lgraph = connectLayers(lgraph,"bn3a_branch2b","res3a/in1");
    lgraph = connectLayers(lgraph,"res3a_relu","res3b_branch1");
    lgraph = connectLayers(lgraph,"res3a_relu","res3b_branch2a");
    lgraph = connectLayers(lgraph,"bn3b_branch1","res3b/in2");
    lgraph = connectLayers(lgraph,"bn3b_branch2b","res3b/in1");
    lgraph = connectLayers(lgraph,"res3b_relu","res4a_branch1");
    lgraph = connectLayers(lgraph,"res3b_relu","res4a_branch2a");
    lgraph = connectLayers(lgraph,"bn4a_branch1","res4a/in2");
    lgraph = connectLayers(lgraph,"bn4a_branch2b","res4a/in1");
    lgraph = connectLayers(lgraph,"res4a_relu","res4b_branch1");
    lgraph = connectLayers(lgraph,"res4a_relu","res4b_branch2a");
    lgraph = connectLayers(lgraph,"bn4b_branch1","res4b/in2");
    lgraph = connectLayers(lgraph,"bn4b_branch2b","res4b/in1"); 

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
    tic
    trainedNet      = trainNetwork(rxTrainFrames,rxTrainLabels,lgraph,options);
    exportONNXNetwork(trainedNet, snr(snrIdx) + "dB_AMC_Network.onnx")
end
