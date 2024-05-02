clc; clear; close all;
%% Basic Parameters
modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % Name of modulation type
numModTypes     = length(modTypes);                                     % Number of modulation type

snr             = -10:2:20;     % Signal-to-Noise(dB)
% spf             = 512;          % Samples per frame
numFrame        = 5000;        % Number of total data
numSegment      = 1;
rep             = 4;

tstart  = tic;
tList   = [];

testAccList = [];

fcAccList = [];
softAccList = [];
votingAccList = [];
noFusionAccList = [];

%% TDL Channel Model Parameters
sl_ResourcePoolconfig.Nsc       = 600; % Number of subcarrier
sl_ResourcePoolconfig.Nsyms     = 14; % Number of symbol
nr_CarrierConfig.SCS            = 30*10^3; % Interval between subcarriers
nr_CarrierConfig.Nfft           = 1024; % Size of FFT
nr_CarrierConfig.velocity       = 30; % in km/h
nr_CarrierConfig.fc             = 6*10^9; % in Hz

%% PDSCH DMRS Parameters
N_RB    = 3;                % PDSCH RB 수
N_sc    = N_RB * 12;        % PDSCH subcarrier 수
N_syms  = 14;               % PDSCH 심볼 수
spf     = N_sc * N_syms;    % Samples per frame

% DMRS 생성
carrier         = nrCarrierConfig('NSlot',10);
pdsch           = nrPDSCHConfig;
pdsch.PRBSet    = 0:30;
dmrs                        = nrPDSCHDMRSConfig;
dmrs.DMRSConfigurationType  = 2;
dmrs.DMRSLength             = 2;
dmrs.DMRSAdditionalPosition = 1;
dmrs.DMRSTypeAPosition      = 2;
dmrs.DMRSPortSet            = 5;
dmrs.NIDNSCID               = 10;
dmrs.NSCID                  = 0;
pdsch.DMRS  = dmrs;
sym_dmrs    = nrPDSCHDMRS(carrier,pdsch,'OutputDataType','single');
ind_dmrs    = nrPDSCHDMRSIndices(carrier,pdsch,'IndexBase','0based','IndexOrientation','carrier');
ResourceGridPart = zeros(52*12-N_sc,14);
ResourceGridTotal = zeros(52*12,14);

% New DMRS(Phase Shifted Symbol)
demod_dmrs = pskdemod(sym_dmrs, 4, pi/4);
newSymDmrsQpsk = pskmod(demod_dmrs, 4, pi/4);
newSymDmrs16qam = pskmod(demod_dmrs, 4, pi/3.2);
newSymDmrs64qam = pskmod(demod_dmrs, 4, pi/2.66666666667);
newSymDmrs256qam = pskmod(demod_dmrs, 4, pi/2.28571428571);

%% Data generation
for snrIdx = 6:length(snr) 
    snr(snrIdx)
    
    totalFcOutput = 0;
    totalSoftOutput = 0;
    totalTestAcc = 0;

    parfor frameIdx = 1:numFrame
        % QPSK
        txQpskSig = randi([0 3], spf, 1);
        modQpskSig = pskmod(txQpskSig, 4, pi/4);
        modQpskSig = reshape(modQpskSig,N_sc,N_syms);
        ResourceQpsk = vertcat(modQpskSig, ResourceGridPart);
        ResourceQpsk(ind_dmrs) = 2*newSymDmrsQpsk;
        awgnQpskSig = cell(rep, 1);
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        for repIdx = 1:rep
            H = Hout(1:N_sc, N_syms*(rep-1)+1:N_syms*rep);
            tdlQpskSig = zeros(size(ResourceGridTotal));
            tdlQpskSig(1:N_sc,1:N_syms) = H.*ResourceQpsk(1:N_sc,1:N_syms);
            tdlQpskSig = reshape(tdlQpskSig(1:N_sc, 1:N_syms),[],1);
            awgnQpskSig{repIdx} = awgn(tdlQpskSig, snr(snrIdx));
        end
        softComQpskSig1 = awgnQpskSig{1} + awgnQpskSig{2};
        softComQpskSig2 = awgnQpskSig{3} + awgnQpskSig{4};

        totalQpskSig(:, :, frameIdx) = softComQpskSig1 + softComQpskSig2;
        
        % 16QAM
        tx16qamSig = randi([0 15], spf, 1);
        mod16qamSig = qammod(tx16qamSig, 16, 'UnitAveragePower', true);
        mod16qamSig = reshape(mod16qamSig,N_sc,N_syms);
        Resource16qam = vertcat(mod16qamSig, ResourceGridPart); 
        Resource16qam(ind_dmrs) = 2*newSymDmrs16qam;
        awgn16qamSig = cell(rep, 1);
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        for repIdx = 1:rep
            H = Hout(1:N_sc, N_syms*(rep-1)+1:N_syms*rep);
            tdl16qamSig = zeros(size(ResourceGridTotal));
            tdl16qamSig(1:N_sc,1:N_syms) = H.*Resource16qam(1:N_sc,1:N_syms);
            tdl16qamSig = reshape(tdl16qamSig(1:N_sc, 1:N_syms),[],1);
            awgn16qamSig{repIdx} = awgn(tdl16qamSig, snr(snrIdx));
        end
        softCom16qamSig1 = awgn16qamSig{1} + awgn16qamSig{2};
        softCom16qamSig2 = awgn16qamSig{3} + awgn16qamSig{4};
        total16qamSig(:, :, frameIdx) = softCom16qamSig1 + softCom16qamSig2;
        
        % 64QAM
        tx64qamSig = randi([0 63], spf, 1);
        mod64qamSig = qammod(tx16qamSig, 64, 'UnitAveragePower', true);
        mod64qamSig = reshape(mod64qamSig,N_sc,N_syms);
        Resource64qam = vertcat(mod64qamSig, ResourceGridPart);
        Resource64qam(ind_dmrs) = 2*newSymDmrs64qam;
        awgn64qamSig = cell(rep, 1);
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        for repIdx = 1:rep
            H = Hout(1:N_sc, N_syms*(rep-1)+1:N_syms*rep);
            tdl64qamSig = zeros(size(ResourceGridTotal));
            tdl64qamSig(1:N_sc,1:N_syms) = H.*Resource64qam(1:N_sc,1:N_syms);
            tdl64qamSig = reshape(tdl64qamSig(1:N_sc, 1:N_syms),[],1);
            awgn64qamSig{repIdx} = awgn(tdl64qamSig, snr(snrIdx));
        end
        softCom64qamSig1 = awgn64qamSig{1} + awgn64qamSig{2};
        softCom64qamSig2 = awgn64qamSig{3} + awgn64qamSig{4};
        total64qamSig(:, :, frameIdx) = softCom64qamSig1 + softCom64qamSig2;

        % 256QAM
        tx256qamSig = randi([0 255], spf, 1);
        mod256qamSig = qammod(tx256qamSig, 256, 'UnitAveragePower', true);
        mod256qamSig = reshape(mod256qamSig,N_sc,N_syms);
        Resource256qam = vertcat(mod256qamSig, ResourceGridPart);
        Resource256qam(ind_dmrs) = 2*newSymDmrs256qam;
        awgn256qamSig = cell(rep, 1);
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        for repIdx = 1:rep
            H = Hout(1:N_sc, N_syms*(rep-1)+1:N_syms*rep);
            tdl256qamSig = zeros(size(ResourceGridTotal));
            tdl256qamSig(1:N_sc,1:N_syms) = H.*Resource256qam(1:N_sc,1:N_syms);
            tdl256qamSig = reshape(tdl256qamSig(1:N_sc, 1:N_syms),[],1);
            awgn256qamSig{repIdx} = awgn(tdl256qamSig, snr(snrIdx));
        end
        softCom256qamSig1 = awgn256qamSig{1} + awgn256qamSig{2};
        softCom256qamSig2 = awgn256qamSig{3} + awgn256qamSig{4};
        total256qamSig(:, :, frameIdx) = softCom256qamSig1 + softCom256qamSig2;
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
    
        trainedNet      = importONNXNetwork("4Comb_Network/" + snr(snrIdx) + "dB_AMC_network.onnx");
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
