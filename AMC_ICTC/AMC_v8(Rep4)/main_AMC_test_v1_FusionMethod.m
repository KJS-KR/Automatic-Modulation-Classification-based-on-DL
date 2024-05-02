clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numFrame        = 30000;
numSegment      = 4;

testAccList = [];

totalFcOutput = 0;
totalSoftOutput = 0;
totalTestAcc = 0;

fcAccList = [];
softAccList = [];
votingAccList = [];
noFusionAccList = [];

for snrIdx = 1:numSnr
    snr(snrIdx)
    
    totalFcOutput = 0;
    totalSoftOutput = 0;
    totalTestAcc = 0;
    
    %% 신호 생성
    parfor frameIdx = 1:numFrame
        % QPSK
        txSigQpsk = randi([0 3], spf, 1);
        modQpskSig = pskmod(txSigQpsk, 4, pi/4);
        awgnQpskSig1 = awgn(modQpskSig, snr(snrIdx));
        awgnQpskSig2 = awgn(modQpskSig, snr(snrIdx));
        awgnQpskSig3 = awgn(modQpskSig, snr(snrIdx));
        awgnQpskSig4 = awgn(modQpskSig, snr(snrIdx));
        repQpskSig = vertcat(awgnQpskSig1, awgnQpskSig2, awgnQpskSig3, awgnQpskSig4);
        totalQpskSig(:, :, frameIdx) = repQpskSig;
        
        % 16QAM
        txSig16qam = randi([0 15], spf, 1);
        mod16qamSig = qammod(txSig16qam, 16, 'UnitAveragePower', true);
        awgn16qamSig1 = awgn(mod16qamSig, snr(snrIdx));
        awgn16qamSig2 = awgn(mod16qamSig, snr(snrIdx));
        awgn16qamSig3 = awgn(mod16qamSig, snr(snrIdx));
        awgn16qamSig4 = awgn(mod16qamSig, snr(snrIdx));
        rep16qamSig = vertcat(awgn16qamSig1, awgn16qamSig2, awgn16qamSig3, awgn16qamSig4);
        total16qamSig(:, :, frameIdx) = rep16qamSig;
    
        % 64QAM
        txSig64qam = randi([0 63], spf, 1);
        mod64qamSig = qammod(txSig64qam, 64, 'UnitAveragePower', true);
        awgn64qamSig1 = awgn(mod64qamSig, snr(snrIdx));
        awgn64qamSig2 = awgn(mod64qamSig, snr(snrIdx));
        awgn64qamSig3 = awgn(mod64qamSig, snr(snrIdx));
        awgn64qamSig4 = awgn(mod64qamSig, snr(snrIdx));
        rep64qamSig = vertcat(awgn64qamSig1, awgn64qamSig2, awgn64qamSig3, awgn64qamSig4);
        total64qamSig(:, :, frameIdx) = rep64qamSig;
    
        % 256QAM
        txSig256qam = randi([0 255], spf, 1);
        mod256qamSig = qammod(txSig256qam, 256, 'UnitAveragePower', true);
        awgn256qamSig1 = awgn(mod256qamSig, snr(snrIdx));
        awgn256qamSig2 = awgn(mod256qamSig, snr(snrIdx));
        awgn256qamSig3 = awgn(mod256qamSig, snr(snrIdx));
        awgn256qamSig4 = awgn(mod256qamSig, snr(snrIdx));
        rep256qamSig = vertcat(awgn256qamSig1, awgn256qamSig2, awgn256qamSig3, awgn256qamSig4);
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
    
        trainedNet      = importONNXNetwork("Network_v2/" + snr(snrIdx) + "dB_AMC_network.onnx");
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

    totalTestAcc    = 0;
    totalFcOutput   = 0;
    totalSoftOutput = 0;
end
