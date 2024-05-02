clc; close all; clear;

%% 기본 파라미터 설정
modTypes    = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);
numModTypes = length(modTypes);

spf             = 512;
snr             = -20:2:20;
numSnr          = length(snr);
numFrame        = 3000;

testAccList = [];
%% 신호 생성
for snrIdx = 1:numSnr
    parfor frameIdx = 1:numFrame
        % QPSK
        txSigQpsk = randi([0 3], spf, 1);
        modQpskSig = pskmod(txSigQpsk, 4, pi/4);
        awgnQpskSig = cell(numRep, 1);
        for repIdx = 1:numRep
            awgnQpskSig{repIdx} = awgn(modQpskSig, snr(snrIdx));
        end
        repQpskSig = vertcat(awgnQpskSig{1} + awgnQpskSig{2}, awgnQpskSig{3} + awgnQpskSig{4}, awgnQpskSig{5} + awgnQpskSig{6}, awgnQpskSig{7} + awgnQpskSig{8}, awgnQpskSig{9} + awgnQpskSig{10}, awgnQpskSig{11} + awgnQpskSig{12}, awgnQpskSig{13} + awgnQpskSig{14}, awgnQpskSig{15} + awgnQpskSig{16})
        totalQpskSig(:, :, frameIdx) = repQpskSig;
        
        % 16QAM
        txSig16qam = randi([0 15], spf, 1);
        mod16qamSig = qammod(txSig16qam, 16, 'UnitAveragePower', true);
        awgn16qamSig = cell(numRep, 1);
        for repIdx = 1:numRep
            awgn16qamSig{repIdx} = awgn(mod16qamSig, snr(snrIdx));
        end
        rep16qamSig = vertcat(awgn16qamSig{1} + awgn16qamSig{2}, awgn16qamSig{3} + awgn16qamSig{4}, awgn16qamSig{5} + awgn16qamSig{6}, awgn16qamSig{7} + awgn16qamSig{8}, awgn16qamSig{9} + awgn16qamSig{10}, awgn16qamSig{11} + awgn16qamSig{12}, awgn16qamSig{13} + awgn16qamSig{14}, awgn16qamSig{15} + awgn16qamSig{16})
        total16qamSig(:, :, frameIdx) = rep16qamSig;
    
        % 64QAM
        txSig64qam = randi([0 63], spf, 1);
        mod64qamSig = qammod(txSig64qam, 64, 'UnitAveragePower', true);
        awgn64qamSig = cell(numRep, 1);
        for repIdx = 1:numRep
            awgn64qamSig{repIdx} = awgn(mod64qamSig, snr(snrIdx));
        end
        rep64qamSig = vertcat(awgn64qamSig{1} + awgn64qamSig{2}, awgn64qamSig{3} + awgn16qamSig{4}, awgn64qamSig{5} + awgn64qamSig{6}, awgn64qamSig{7} + awgn64qamSig{8}, awgn64qamSig{9} + awgn64qamSig{10}, awgn64qamSig{11} + awgn16qamSig{12}, awgn64qamSig{13} + awgn64qamSig{14}, awgn64qamSig{15} + awgn64qamSig{16})
        total64qamSig(:, :, frameIdx) = rep64qamSig;
    
        % 256QAM
        txSig256qam = randi([0 255], spf, 1);
        mod256qamSig = qammod(txSig256qam, 256, 'UnitAveragePower', true);
        awgn256qamSig = cell(numRep, 1);
        for repIdx = 1:numRep
            awgn256qamSig{repIdx} = awgn(mod256qamSig, snr(snrIdx));
        end
        rep256qamSig = vertcat(awgn256qamSig{1} + awgn256qamSig{2}, awgn256qamSig{3} + awgn256qamSig{4}, awgn256qamSig{5} + awgn256qamSig{6}, awgn256qamSig{7} + awgn256qamSig{8}, awgn256qamSig{9} + awgn256qamSig{10}, awgn256qamSig{11} + awgn256qamSig{12}, awgn256qamSig{13} + awgn256qamSig{14}, awgn256qamSig{15} + awgn256qamSig{16})
        total256qamSig(:, :, frameIdx) = rep256qamSig;
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
    testData(:,:,1:numFrame) = dataQpsk(:,:,1:numFrame);
    testData(:,:,numFrame+1:numFrame*2) = data16qam(:,:,1:numFrame);
    testData(:,:,numFrame*2+1:numFrame*3) = data64qam(:,:,1:numFrame);
    testData(:,:,numFrame*3+1:numFrame*4) = data256qam(:,:,1:numFrame);
    
    % 테스트 데이터셋 라벨링
    for n = 1:numFrame * numModTypes 
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
    
%% 레이어 설정 및 학습
    testPred = rxTestLabels;

    trainedNet      = importONNXNetwork(snr(snrIdx) + "dB_AMC_network(Add2).onnx");
    rxTestPred      = classify(trainedNet,rxTestFrames);
    rxTestPred      = rxTestPred.';

    for n = 1:length(rxTestPred)
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
    testAccList = horzcat(testAccList, testAccuracy);
end