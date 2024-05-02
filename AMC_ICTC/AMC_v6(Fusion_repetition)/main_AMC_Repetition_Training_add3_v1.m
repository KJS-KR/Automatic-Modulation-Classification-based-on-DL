clc; clear; close all;

%% Setting

modTypes    = categorical(["BPSK", "QPSK", "8PSK", "16QAM", "32QAM", "64QAM", "4PAM", "8PAM"]);
numModTypes = length(modTypes);     


numRepetition       = 4;
spf                 = 512;          % 프레임 당 샘플 수
N_Frame             = 100000;         % 프레임 수
snr                 = -20:2:20;     % 신호 대 잡음비(dB)
numSnr              = length(snr);  

testDataRatio       = 1;          % 훈련 프레임 비율
trainDataRatio      = 0.8;          % 훈련 프레임 비율
validDataRatio      = 0.2;          % 검증 프레임 비율

for snrIdx = 1:numSnr
    totalFcOutput = 0;
    totalSoftOutput = 0;
    totalTestAcc = 0;
    
    for frameIdx = 1:N_Frame
        % BPSK
        modNumBpsk = 2;
        randBit = randi([0 modNumBpsk-1], spf, 1);
        for bitIdx = 1:4
            sigBpsk = pskmod(randBit, modNumBpsk);
            awgnSigBpsk = awgn(sigBpsk, snr(snrIdx));
            repSigBpsk(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSigBpsk;
        end

        % total 
        totalSigBpsk(:,frameIdx) = repSigBpsk;

        % (1rep+2rep), (3rep+4rep)
        addSigBpsk(1:spf,frameIdx) = repSigBpsk(1:spf,:) + repSigBpsk(1+spf:spf*2);
%         addSigBpsk(1+spf:spf*2,:) = repSigBpsk(1+spf*2:spf*3) + repSigBpsk(1+spf*3:spf*4);
        
%         add1SigBpsk(1:spf*2,frameIdx) = addSigBpsk;

        % (1rep+2rep+3rep+4rep)
        add2SigBpsk(1:spf,frameIdx) = repSigBpsk(1:spf,:) + repSigBpsk(1+spf:spf*2) + repSigBpsk(1+spf*2:spf*3);

        % QPSK
        modNumQpsk = 4;
        randBit = randi([0 modNumQpsk-1], spf, 1);
        for bitIdx = 1:4
            sigQpsk = pskmod(randBit, modNumQpsk);
            awgnSigQpsk = awgn(sigQpsk, snr(snrIdx));
            repSigQpsk(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSigQpsk;
        end

        % total 
        totalSigQpsk(:,frameIdx) = repSigQpsk;

        % (1rep+2rep), (3rep+4rep)
        addSigQpsk(1:spf,frameIdx) = repSigQpsk(1:spf,:) + repSigQpsk(1+spf:spf*2);
%         addSigQpsk(1+spf:spf*2,:) = repSigQpsk(1+spf*2:spf*3) + repSigQpsk(1+spf*3:spf*4);
        
%         add1SigQpsk(1:spf*2,frameIdx) = addSigQpsk;

        % (1rep+2rep+3rep+4rep)
        add2SigQpsk(1:spf,frameIdx) = repSigQpsk(1:spf,:) + repSigQpsk(1+spf:spf*2) + repSigQpsk(1+spf*2:spf*3);


        % 8PSK
        modNum8psk = 8;
        randBit = randi([0 modNum8psk-1], spf, 1);
        for bitIdx = 1:4
            sig8psk = pskmod(randBit, modNum8psk);
            awgnSig8psk = awgn(sig8psk, snr(snrIdx));
            repSig8psk(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig8psk;
        end

        % total 
        totalSig8psk(:,frameIdx) = repSig8psk;

        % (1rep+2rep), (3rep+4rep)
        addSig8psk(1:spf,frameIdx) = repSig8psk(1:spf,:) + repSig8psk(1+spf:spf*2);
%         addSig8psk(1+spf:spf*2,:) = repSig8psk(1+spf*2:spf*3) + repSig8psk(1+spf*3:spf*4);
        
%         add1Sig8psk(1:spf*2,frameIdx) = addSig8psk;

        % (1rep+2rep+3rep+4rep)
        add2Sig8psk(1:spf,frameIdx) = repSig8psk(1:spf,:) + repSig8psk(1+spf:spf*2) + repSig8psk(1+spf*2:spf*3);


        % 16QAM
        modNum16qam = 16;
        randBit = randi([0 modNum16qam-1], spf, 1);
        for bitIdx = 1:4
            sig16qam = qammod(randBit, modNum16qam);
            awgnSig16qam = awgn(sig16qam, snr(snrIdx));
            repSig16qam(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig16qam;
        end

        % total 
        totalSig16qam(:,frameIdx) = repSig16qam;

        % (1rep+2rep), (3rep+4rep)
        addSig16qam(1:spf,frameIdx) = repSig16qam(1:spf,:) + repSig16qam(1+spf:spf*2);
%         addSig16qam(1+spf:spf*2,:) = repSig16qam(1+spf*2:spf*3) + repSig16qam(1+spf*3:spf*4);
        
%         add1Sig16qam(1:spf*2,frameIdx) = addSig16qam;

        % (1rep+2rep+3rep+4rep)
        add2Sig16qam(1:spf,frameIdx) = repSig16qam(1:spf,:) + repSig16qam(1+spf:spf*2) + repSig16qam(1+spf*2:spf*3);


        % 32QAM
        modNum32qam = 32;
        randBit = randi([0 modNum32qam-1], spf, 1);
        for bitIdx = 1:4
            sig32qam = qammod(randBit, modNum32qam);
            awgnSig32qam = awgn(sig32qam, snr(snrIdx));
            repSig32qam(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig32qam;
        end

        % total 
        totalSig32qam(:,frameIdx) = repSig32qam;

        % (1rep+2rep), (3rep+4rep)
        addSig32qam(1:spf,frameIdx) = repSig32qam(1:spf,:) + repSig32qam(1+spf:spf*2);
%         addSig32qam(1+spf:spf*2,:) = repSig32qam(1+spf*2:spf*3) + repSig32qam(1+spf*3:spf*4);
        
%         add1Sig32qam(1:spf*2,frameIdx) = addSig32qam;

        % (1rep+2rep+3rep+4rep)
        add2Sig32qam(1:spf,frameIdx) = repSig32qam(1:spf,:) + repSig32qam(1+spf:spf*2) + repSig32qam(1+spf*2:spf*3);


        % 64QAM
        modNum64qam = 64;
        randBit = randi([0 modNum64qam-1], spf, 1);
        for bitIdx = 1:4
            sig64qam = qammod(randBit, modNum64qam);
            awgnSig64qam = awgn(sig64qam, snr(snrIdx));
            repSig64qam(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig64qam;
        end

        % total 
        totalSig64qam(:,frameIdx) = repSig64qam;

        % (1rep+2rep), (3rep+4rep)
        addSig64qam(1:spf,frameIdx) = repSig64qam(1:spf,:) + repSig64qam(1+spf:spf*2);
%         addSig64qam(1+spf:spf*2,:) = repSig64qam(1+spf*2:spf*3) + repSig64qam(1+spf*3:spf*4);
        
%         add1Sig64qam(1:spf*2,frameIdx) = addSig64qam;

        % (1rep+2rep+3rep+4rep)
        add2Sig64qam(1:spf,frameIdx) = repSig64qam(1:spf,:) + repSig64qam(1+spf:spf*2) + repSig64qam(1+spf*2:spf*3);


        % 4PAM
        modNum4pam = 4;
        randBit = randi([0 modNum4pam-1], spf, 1);
        for bitIdx = 1:4
            sig4pam = pammod(randBit, modNum4pam);
            awgnSig4pam = awgn(sig4pam, snr(snrIdx));
            repSig4pam(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig4pam;
        end

        % total 
        totalSig4pam(:,frameIdx) = repSig4pam;

        % (1rep+2rep), (3rep+4rep)
        addSig4pam(1:spf,frameIdx) = repSig4pam(1:spf,:) + repSig4pam(1+spf:spf*2);
%         addSig4pam(1+spf:spf*2,:) = repSig4pam(1+spf*2:spf*3) + repSig4pam(1+spf*3:spf*4);
        
%         add1Sig4pam(1:spf*2,frameIdx) = addSig4pam;

        % (1rep+2rep+3rep+4rep)
        add2Sig4pam(1:spf,frameIdx) = repSig4pam(1:spf,:) + repSig4pam(1+spf:spf*2) + repSig4pam(1+spf*2:spf*3);


        % 4PAM
        modNum8pam = 8;
        randBit = randi([0 modNum8pam-1], spf, 1);
        for bitIdx = 1:4
            sig8pam = pammod(randBit, modNum8pam);
            awgnSig8pam = awgn(sig8pam, snr(snrIdx));
            repSig8pam(1+spf*(bitIdx-1):spf+spf*(bitIdx-1),:) = awgnSig8pam;
        end

        % total 
        totalSig8pam(:,frameIdx) = repSig8pam;

        % (1rep+2rep), (3rep+4rep)
        addSig8pam(1:spf,frameIdx) = repSig8pam(1:spf,:) + repSig8pam(1+spf:spf*2);
%         addSig8pam(1+spf:spf*2,:) = repSig8pam(1+spf*2:spf*3) + repSig8pam(1+spf*3:spf*4);
        
%         add1Sig8pam(1:spf*2,frameIdx) = addSig8pam;

        % (1rep+2rep+3rep+4rep)
        add2Sig8pam(1:spf,frameIdx) = repSig8pam(1:spf,:) + repSig8pam(1+spf:spf*2) + repSig8pam(1+spf*2:spf*3);

    end

%% 데이터셋 생성 및 분할

    dataBpsk(:,1,:) = real(add2SigBpsk);
    dataBpsk(:,2,:) = imag(add2SigBpsk);

    dataQpsk(:,1,:) = real(add2SigQpsk);
    dataQpsk(:,2,:) = imag(add2SigQpsk);

    data8psk(:,1,:) = real(add2Sig8psk);
    data8psk(:,2,:) = imag(add2Sig8psk);

    data16qam(:,1,:) = real(add2Sig16qam);
    data16qam(:,2,:) = imag(add2Sig16qam);

    data32qam(:,1,:) = real(add2Sig32qam);
    data32qam(:,2,:) = imag(add2Sig32qam);

    data64qam(:,1,:) = real(add2Sig64qam);
    data64qam(:,2,:) = imag(add2Sig64qam);

    data4pam(:,1,:) = real(add2Sig4pam);
    data4pam(:,2,:) = imag(add2Sig4pam);

    data8pam(:,1,:) = real(add2Sig8pam);
    data8pam(:,2,:) = imag(add2Sig8pam);

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


    %% 데이터셋 생성 및 분할
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
    
    maxEpochs           = 10;
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
    
    trainedNet      = trainNetwork(rxTrainFrames,rxTrainLabels,modClassNet,options);
    exportONNXNetwork(trainedNet, snr(snrIdx) + "dB_AMC_Network(Add3).onnx")
   

end % SNR



