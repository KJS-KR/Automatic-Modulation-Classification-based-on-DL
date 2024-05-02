clc; clear; close all;

%% Set the paramether
modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % Name of modulation type
numModTypes     = length(modTypes);                                     % Number of modulation type

snr             = -10:2:20;     % Signal-to-Noise(dB)
spf             = 512;          % Samples per frame

numFrame        = 30000;       % Number of total data
% trainDataRatio  = 0.8;         % Training data ratio
% validDataRatio  = 0.2;         % Validation data ratio
% testDataRatio   = 1;           % Test data ratio

% Resource grid parameters
sl_ResourcePoolconfig.Nsc = 600; % Number of subcarrier
sl_ResourcePoolconfig.Nsyms = 1; % Number of symbol
nr_CarrierConfig.SCS = 30*10^3; % Interval between subcarriers
nr_CarrierConfig.Nfft = 1024; % Size of FFT
nr_CarrierConfig.velocity = 100; % in km/h
nr_CarrierConfig.fc = 4*10^9; % in Hz

Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);

tstart = tic;
tList = [];

testAccList = [];

%% Data Generation
for snrIdx = 1:length(snr)
    snr(snrIdx)
    parfor frameIdx = 1:numFrame
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % QPSK
        txQpskSig = randi([0 3], spf, 1);
        modQpskSig = pskmod(txQpskSig, 4, pi/4);
        tdlQpskSig = Hout(1:512).*modQpskSig;
        awgnQpskSig = awgn(tdlQpskSig, snr(snrIdx));
        totalQpskSig(:, :, frameIdx) = awgnQpskSig;

        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 16QAM
        tx16qamSig = randi([0 15], spf, 1);
        mod16qamSig = qammod(tx16qamSig, 16, 'UnitAveragePower', true);
        tdl16qamSig = Hout(1:512).*mod16qamSig;
        awgn16qamSig = awgn(tdl16qamSig, snr(snrIdx));
        total16qamSig(:, :, frameIdx) = awgn16qamSig;

        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 64QAM
        tx64qamSig = randi([0 63], spf, 1);
        mod64qamSig = qammod(tx64qamSig, 64, 'UnitAveragePower', true);
        tdl64qamSig = Hout(1:512).*mod64qamSig;
        awgn64qamSig = awgn(tdl64qamSig, snr(snrIdx));
        total64qamSig(:, :, frameIdx) = awgn64qamSig;

        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        % 256QAM
        tx256qamSig = randi([0 255], spf, 1);
        mod256qamSig = qammod(tx256qamSig, 256, 'UnitAveragePower', true);
        tdl256qamSig = Hout(1:512).*mod256qamSig;
        awgn256qamSig = awgn(tdl256qamSig, snr(snrIdx));
        total256qamSig(:, :, frameIdx) = awgn256qamSig;
    end

%% Divide real part or imaginary part
    dataQpsk(:,1,:) = real(totalQpskSig);
    dataQpsk(:,2,:) = imag(totalQpskSig);

    data16qam(:,1,:) = real(total16qamSig);
    data16qam(:,2,:) = imag(total16qamSig);

    data64qam(:,1,:) = real(total64qamSig);
    data64qam(:,2,:) = imag(total64qamSig);

    data256qam(:,1,:) = real(total256qamSig);
    data256qam(:,2,:) = imag(total256qamSig);

    % Total test datasets
    testData(:,:,1:numFrame) = dataQpsk(:,:,1:numFrame);
    testData(:,:,numFrame+1:numFrame*2) = data16qam(:,:,1:numFrame);
    testData(:,:,numFrame*2+1:numFrame*3) = data64qam(:,:,1:numFrame);
    testData(:,:,numFrame*3+1:numFrame*4) = data256qam(:,:,1:numFrame);
    
    % Laveling the test data
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

%% Testing network and processing time
    testPred = rxTestLabels;
    trainedNet      = importONNXNetwork("Network/" + snr(snrIdx) + "dB_AMC_Network.onnx");

    tic;
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

    tMul = toc;
    tList = horzcat(tList, tMul);

    testAccList     = horzcat(testAccList, testAccuracy);
end