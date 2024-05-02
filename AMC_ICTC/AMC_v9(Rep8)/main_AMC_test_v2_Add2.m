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