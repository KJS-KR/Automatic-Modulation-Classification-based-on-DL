clc; clear; close all;
%% Basic Parameters
modTypes        = categorical(["QPSK", "16QAM", "64QAM", "256QAM"]);    % Name of modulation type
numModTypes     = length(modTypes);                                     % Number of modulation type

snr             = -10:2:20;     % Signal-to-Noise(dB)
% spf             = 512;          % Samples per frame
numFrame        = 10000;        % Number of total data
rep             = 8;
comb            = 1;
numSegment      = rep/comb;


tstart  = tic;
tList   = [];

testAccList = [];

fcAccList = [];
softAccList = [];
votingAccList = [];
noFusionAccList = [];

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
sl_ResourcePoolconfig.Nsyms     = N_syms * rep; % Number of symbol
nr_CarrierConfig.SCS            = 30*10^3; % Interval between subcarriers
nr_CarrierConfig.Nfft           = 1024; % Size of FFT
nr_CarrierConfig.velocity       = 100; % in km/h
nr_CarrierConfig.fc             = 4*10^9; % in Hz

%% Data generation
for snrIdx = 1:1 %length(snr) 
    snr(snrIdx)
    
    totalFcOutput = 0;
    totalSoftOutput = 0;
    totalTestAcc = 0;

    for frameIdx = 1:1 %numFrame
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

        softComQpskResource = cell(numSegment, 1);
        
        for segIdx = 1:numSegment
            if comb == 1
                softComQpskResource{segIdx} = awgnQpskSig{segIdx};
            elseif comb == 2
                softComQpskResource{segIdx} = awgnQpskSig{2*(segIdx-1)+1} + awgnQpskSig{2*segIdx};
            elseif comb == 4
                softComQpskResource{segIdx} = awgnQpskSig{4*(segIdx-1)+1} + awgnQpskSig{4*(segIdx-1)+2} + awgnQpskSig{4*(segIdx-1)+3} + awgnQpskSig{4*(segIdx-1)+4};
            end
        end
        
        for segIdx = 2:numSegment
            softComQpskResource{1} = vertcat(softComQpskResource{1}, softComQpskResource{segIdx});
        end

        totalQpskSig(:, :, frameIdx) = softComQpskResource{1};
    end
end