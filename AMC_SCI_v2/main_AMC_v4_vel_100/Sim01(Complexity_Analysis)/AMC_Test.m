clc; clear; close all;

%% Basic Parameters
netTypes        = ["basicNet", "resNet", "tripleResNet", "googleNet", "vggNet"];
selectNet       = 2;

modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % Name of modulation type
numModTypes     = length(modTypes);                                     % Number of modulation type

snr             = -10:2:20;     % Signal-to-Noise(dB)
% spf             = 512;          % Samples per frame
numFrame        = 5000;        % Number of total data
trainDataRatio  = 0.8;          % Training data ratio
validDataRatio  = 0.2;          % Validation data ratio
% testDataRatio = 0.1;           % Test data ratio
testAccList = [];
tstart = tic;
tList = [];

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

%% TDL Channel Model Parameters
sl_ResourcePoolconfig.Nsc       = 600; % Number of subcarrier
sl_ResourcePoolconfig.Nsyms     = N_syms; % Number of symbol
nr_CarrierConfig.SCS            = 30*10^3; % Interval between subcarriers
nr_CarrierConfig.Nfft           = 1024; % Size of FFT
nr_CarrierConfig.velocity       = 30; % in km/h
nr_CarrierConfig.fc             = 6*10^9; % in Hz

%% Create CNN structure 
netWidth    = 1;
filterSize  = [1 8];
poolSize    = [1 2];

if selectNet == 1
    modClassNet = basicNet(spf, numModTypes);
elseif selectNet == 2
    modClassNet = resNet(spf, numModTypes);
elseif selectNet == 3
    modClassNet = tripleResNet(spf, numModTypes);
elseif selectNet == 4
    modClassNet = googleNet(spf, numModTypes);
elseif selectNet == 5
    modClassNet = vggNet(spf, numModTypes);
end

%% Data generation
for snrIdx = 1:2 %length(snr) 
    snr(snrIdx)
    parfor frameIdx = 1:numFrame
        % QPSK
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        txQpskSig = randi([0 3], spf, 1);
        modQpskSig = pskmod(txQpskSig, 4, pi/4);
        modQpskSig = reshape(modQpskSig,N_sc,N_syms);
        ResourceQpsk = vertcat(modQpskSig, ResourceGridPart);
        ResourceQpsk(ind_dmrs) = 2*newSymDmrsQpsk;
%         figure;
%         imagesc(abs(ResourceQpsk))
        H = Hout(1:N_sc,1:N_syms);
        tdlQpskSig = zeros(size(ResourceGridTotal));
        tdlQpskSig(1:N_sc,1:N_syms) = H.*ResourceQpsk(1:N_sc,1:N_syms);
%         figure;
%         imagesc(abs(tdlQpskSig))
        tdlQpskSig = reshape(tdlQpskSig(1:N_sc, 1:N_syms),[],1);
        awgnQpskSig = awgn(tdlQpskSig, snr(snrIdx));
        totalQpskSig(:, :, frameIdx) = awgnQpskSig;
        
        % 16QAM
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        tx16qamSig = randi([0 15], spf, 1);
        mod16qamSig = qammod(tx16qamSig, 16, 'UnitAveragePower', true);
        mod16qamSig = reshape(mod16qamSig,N_sc,N_syms);
        Resource16qam = vertcat(mod16qamSig, ResourceGridPart); 
        Resource16qam(ind_dmrs) = 2*newSymDmrs16qam;
        H = Hout(1:N_sc,1:N_syms);
        tdl16qamSig = zeros(size(ResourceGridTotal));
        tdl16qamSig(1:N_sc,1:N_syms) = H.*Resource16qam(1:N_sc,1:N_syms);
        tdl16qamSig = reshape(tdl16qamSig(1:N_sc, 1:N_syms),[],1);
        awgn16qamSig = awgn(tdl16qamSig, snr(snrIdx));
        total16qamSig(:, :, frameIdx) = awgn16qamSig;
        % 64QAM
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        tx64qamSig = randi([0 63], spf, 1);
        mod64qamSig = qammod(tx16qamSig, 64, 'UnitAveragePower', true);
        mod64qamSig = reshape(mod64qamSig,N_sc,N_syms);
        Resource64qam = vertcat(mod64qamSig, ResourceGridPart);
        Resource64qam(ind_dmrs) = 2*newSymDmrs64qam;
        H = Hout(1:N_sc,1:N_syms);
        tdl64qamSig = zeros(size(ResourceGridTotal));
        tdl64qamSig(1:N_sc,1:N_syms) = H.*Resource64qam(1:N_sc,1:N_syms);
        tdl64qamSig = reshape(tdl64qamSig(1:N_sc, 1:N_syms),[],1);
        awgn64qamSig = awgn(tdl64qamSig, snr(snrIdx));
        total64qamSig(:, :, frameIdx) = awgn64qamSig;
        % 256QAM
        Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig);
        tx256qamSig = randi([0 255], spf, 1);
        mod256qamSig = qammod(tx256qamSig, 256, 'UnitAveragePower', true);
        mod256qamSig = reshape(mod256qamSig,N_sc,N_syms);
        Resource256qam = vertcat(mod256qamSig, ResourceGridPart);
        Resource256qam(ind_dmrs) = 2*newSymDmrs256qam;
        H = Hout(1:N_sc,1:N_syms);
        tdl256qamSig = zeros(size(ResourceGridTotal));
        tdl256qamSig(1:N_sc,1:N_syms) = H.*Resource256qam(1:N_sc,1:N_syms);
        tdl256qamSig = reshape(tdl256qamSig(1:N_sc, 1:N_syms),[],1);
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
    trainedNet      = importONNXNetwork(netTypes(selectNet) + "_Network/" + snr(snrIdx) + "dB_AMC_Network.onnx");

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