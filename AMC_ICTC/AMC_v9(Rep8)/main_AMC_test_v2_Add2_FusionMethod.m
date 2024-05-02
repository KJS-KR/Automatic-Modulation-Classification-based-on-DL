clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numFrame        = 10000;
numRep          = 8;
numSegment      = 4;

fcAccList = [];
softAccList = [];
votingAccList = [];
noFusionAccList = [];

for snrIdx = 17:17 %:numSnr
    snr(snrIdx)
    totalFcOutput = 0;
    totalSoftOutput = 0;
    totalTestAcc = 0;
    %% 신호 생성
    parfor frameIdx = 1:numFrame
        % QPSK
        txSigQpsk = randi([0 3], spf, 1);
        modQpskSig = pskmod(txSigQpsk, 4, pi/4);
        awgnQpskSig = cell(numSegment, 1);
        for repIdx = 1:numRep
            awgnQpskSig{repIdx} = awgn(modQpskSig, snr(snrIdx));
        end
        repQpskSig = vertcat(awgnQpskSig{1} + awgnQpskSig{2}, awgnQpskSig{3} + awgnQpskSig{4}, awgnQpskSig{5} + awgnQpskSig{6}, awgnQpskSig{7} + awgnQpskSig{8})
        totalQpskSig(:, :, frameIdx) = repQpskSig;
        
        % 16QAM
        txSig16qam = randi([0 15], spf, 1);
        mod16qamSig = qammod(txSig16qam, 16, 'UnitAveragePower', true);
        awgn16qamSig = cell(numSegment, 1);
        for repIdx = 1:numRep
            awgn16qamSig{repIdx} = awgn(mod16qamSig, snr(snrIdx));
        end
        rep16qamSig = vertcat(awgn16qamSig{1} + awgn16qamSig{2}, awgn16qamSig{3} + awgn16qamSig{4}, awgn16qamSig{5} + awgn16qamSig{6}, awgn16qamSig{7} + awgn16qamSig{8})
        total16qamSig(:, :, frameIdx) = rep16qamSig;
    
        % 64QAM
        txSig64qam = randi([0 63], spf, 1);
        mod64qamSig = qammod(txSig64qam, 64, 'UnitAveragePower', true);
        awgn64qamSig = cell(numSegment, 1);
        for repIdx = 1:numRep
            awgn64qamSig{repIdx} = awgn(mod64qamSig, snr(snrIdx));
        end
        rep64qamSig = vertcat(awgn64qamSig{1} + awgn64qamSig{2}, awgn64qamSig{3} + awgn64qamSig{4}, awgn64qamSig{5} + awgn64qamSig{6}, awgn64qamSig{7} + awgn64qamSig{8})
        total64qamSig(:, :, frameIdx) = rep64qamSig;
    
        % 256QAM
        txSig256qam = randi([0 255], spf, 1);
        mod256qamSig = qammod(txSig256qam, 256, 'UnitAveragePower', true);
        awgn256qamSig = cell(numSegment, 1);
        for repIdx = 1:numRep
            awgn256qamSig{repIdx} = awgn(mod256qamSig, snr(snrIdx));
        end
        rep256qamSig = vertcat(awgn256qamSig{1} + awgn256qamSig{2}, awgn256qamSig{3} + awgn256qamSig{4}, awgn256qamSig{5} + awgn256qamSig{6}, awgn256qamSig{7} + awgn256qamSig{8})
        total256qamSig(:, :, frameIdx) = rep256qamSig;
    end

%% 데이터셋 분할
    for segIdx = 1:numSegment
        SegmentedQpskSig = totalQpskSig(1+spf*(segIdx-1):spf*segIdx,:);
        dataQpsk(:,1,:) = real(SegmentedQpskSig);
        dataQpsk(:,2,:) = imag(SegmentedQpskSig);
    
        Segmented16qamSig = total16qamSig(1+spf*(segIdx-1):spf*segIdx,:);
        data16qam(:,1,:) = real(Segmented16qamSig);
        data16qam(:,2,:) = imag(Segmented16qamSig);
        
        Segmented64qamSig = total64qamSig(1+spf*(segIdx-1):spf*segIdx,:);
        data64qam(:,1,:) = real(Segmented64qamSig);
        data64qam(:,2,:) = imag(Segmented64qamSig);
    
        Segmented256qamSig = total256qamSig(1+spf*(segIdx-1):spf*segIdx,:);
        data256qam(:,1,:) = real(Segmented256qamSig);
        data256qam(:,2,:) = imag(Segmented256qamSig);
    
        % 전체 훈련 데이터셋
        testData(:,:,1:numFrame) = dataQpsk(:,:,1:numFrame);
        testData(:,:,numFrame+1:numFrame*2) = data16qam(:,:,1:numFrame);
        testData(:,:,numFrame*2+1:numFrame*3) = data64qam(:,:,1:numFrame);
        testData(:,:,numFrame*3+1:numFrame*4) = data256qam(:,:,1:numFrame);
        
        % 테스트 데이터셋 라벨링
        parfor n = 1:numFrame * numModTypes 
            rxTestFrames(1,:,:,n) = testData(:,:,n);
            if n <=numFrame
                rxTestLabels(n) = modTypes(1);
            elseif n<=numFrame *2
                rxTestLabels(n) = modTypes(2);
            elseif n<=numFrame *3
                rxTestLabels(n) = modTypes(3);
            elseif n<=numFrame *4
                rxTestLabels(n) = modTypes(4);
            end
        end
    
%% 학습된 신경망을 통해 Fusion Method 시뮬레이션
        testPred = rxTestLabels;
    
        trainedNet      = importONNXNetwork("Network_v2/" + snr(snrIdx) + "dB_AMC_network(Add2).onnx");
        rxTestPred      = classify(trainedNet,rxTestFrames);
        rxTestPred      = rxTestPred.';
    
        parfor n = 1:length(rxTestPred)
            if rxTestPred(:,n) == "1"
                testPred(:, n) = categorical(["16QAM"]);
            end
            if rxTestPred(:, n) == "2"
                testPred(:, n) = categorical(["256QAM"]);
            end
            if rxTestPred(:, n) == "3"
                testPred(:, n) = categorical(["64QAM"]);
            end
            if rxTestPred(:, n) == "4"
                testPred(:, n) = categorical(["QPSK"]);
            end
        end
    
        testAccuracy    = mean(testPred == rxTestLabels);
        totalTestAcc    = totalTestAcc+testAccuracy;
        fcOutput = activations(trainedNet, rxTestFrames, 'FC1', 'OutputAs', 'row');
        totalFcOutput = totalFcOutput+fcOutput;
 
        softOutput = activations(trainedNet, rxTestFrames, 'SoftMax', 'OutputAs', 'row');
        totalSoftOutput = totalSoftOutput+softOutput;
    end
     % voting-Based Fusion Method
    averageTestAcc              = (totalTestAcc/numSegment);

    % Feature-Based Fusion Method
    averageFcOutput             = (totalFcOutput/numSegment).';
    [maxFcValue, maxFcIndex]    = max(averageFcOutput);
    testFcLabel                 = maxFcIndex;

    testFcPred = rxTestLabels;

    parfor n = 1:length(rxTestPred)
        if testFcLabel(:,n) == 1
            testFcPred(:, n) = categorical(["16QAM"]);
        end
        if testFcLabel(:, n) == 2
            testFcPred(:, n) = categorical(["256QAM"]);
        end
        if testFcLabel(:, n) == 3
            testFcPred(:, n) = categorical(["64QAM"]);
        end
        if testFcLabel(:, n) == 4
            testFcPred(:, n) = categorical(["QPSK"]);
        end
    end

     % Confidence-Based Fusion Method
    averageSoftOutput               = (totalSoftOutput/numSegment).';
    [maxSoftValue, maxSoftIndex]    = max(averageSoftOutput);
    testSoftLabel                   = maxSoftIndex;

    testSoftPred                    = rxTestLabels;

    parfor n = 1:length(rxTestPred)
        if testSoftLabel(:,n) == 1
            testSoftPred(:, n) = categorical(["16QAM"]);
        end
        if testSoftLabel(:, n) == 2
            testSoftPred(:, n) = categorical(["256QAM"]);
        end
        if testSoftLabel(:, n) == 3
            testSoftPred(:, n) = categorical(["64QAM"]);
        end
        if testSoftLabel(:, n) == 4
            testSoftPred(:, n) = categorical(["QPSK"]);
        end
    end

    noFusionAccList     = horzcat(noFusionAccList, testAccuracy);

    votingAccList         = horzcat(votingAccList, averageTestAcc);

    testFcAccuracy      = mean(testFcPred == rxTestLabels);
    fcAccList           = horzcat(fcAccList, testFcAccuracy);

    testSoftAccuracy    = mean(testSoftPred == rxTestLabels);
    softAccList         = horzcat(softAccList, testSoftAccuracy);
end
