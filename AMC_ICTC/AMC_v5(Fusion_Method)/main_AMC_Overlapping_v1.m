clc; clear; close all;

%% Setting

modTypes    = categorical(["BPSK", "QPSK", "8PSK", "16QAM", "32QAM", "64QAM", "4PAM", "8PAM"]);
numModTypes = length(modTypes);     

spf                 = 2048;          % 프레임 당 샘플 수
segmentLength       = 512;
numSegment          = [4 5 7 13];
overlappingRatio    = [0 0.75 0.5 0.25];


N_Frame             = 1000;         % 프레임 수
signalBurstRange    = spf * N_Frame; 
snr                 = -20:2:20;     % 신호 대 잡음비(dB)
numSnr              = length(snr);  
testDataRatio      = 1;          % 훈련 프레임 비율
validDataRatio      = 0;          % 검증 프레임 비율

totalFcOutput = 0;
totalTestAcc = [];

fcAccList = [];
testAccList = [];
noFusionAccList = [];

for snrIdx = 1:1:numSnr

    %% BPSK 신호 생성
    modNumBpsk = 2;
    randBit = randi([0 modNumBpsk-1], signalBurstRange, 1);
    sigBpsk = pskmod(randBit, 2);
    
    % figure;
    % subplot(3, 3, 1)
    % plot(real(sigBpsk), imag(sigBpsk), 'x');
    % title("BPSK")
    % axis([-2 2 -2 2])
    
    %% QPSK 신호 생성
    modNumQpsk = 4;
    randBit = randi([0 modNumQpsk-1], signalBurstRange, 1);
    sigQpsk = pskmod(randBit, 4, pi/4);
    
    % subplot(3, 3, 2)
    % plot(real(sigQpsk), imag(sigQpsk), 'x');
    % title("QPSK")
    % axis([-2 2 -2 2])
    
    %% 8PSK 신호 생성
    modNum8psk = 8;
    randBit = randi([0 modNum8psk-1], signalBurstRange, 1);
    sig8psk = pskmod(randBit, 8, pi/4);
    % subplot(3, 3, 3)
    % plot(real(sig8psk), imag(sig8psk), 'x');
    % title("8PSK")
    % axis([-2 2 -2 2])
    
    %% 16QAM 신호 생성
    modNum16qam = 16;
    randBit = randi([0 modNum16qam-1], signalBurstRange, 1);
    sig16qam = qammod(randBit, modNum16qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 4)
    % plot(real(sig16qam), imag(sig16qam), 'x');
    % title("16QAM")
    % axis([-2 2 -2 2])
    
    %% 32QAM 신호 생성
    modNum32qam = 32;
    randBit = randi([0 modNum32qam-1], signalBurstRange, 1);
    sig32qam = qammod(randBit, modNum32qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 5)
    % plot(real(sig32qam), imag(sig32qam), 'x');
    % title("32QAM")
    % axis([-2 2 -2 2])
    
    %% 64QAM 신호 생성
    modNum64qam = 64;
    randBit = randi([0 modNum64qam-1], signalBurstRange, 1);
    sig64qam = qammod(randBit, modNum64qam, 'UnitAveragePower', true);
    
    % subplot(3, 3, 6)
    % plot(real(sig64qam), imag(sig64qam), 'x');
    % title("64QAM")
    % axis([-2 2 -2 2])
    
    %% 4PAM 신호 생성
    modNum4pam = 4;
    randBit = randi([0 modNum4pam-1], signalBurstRange, 1);
    sig4pam = pammod(randBit, modNum4pam);
    sig4pam = normalize(sig4pam);
    
    % subplot(3, 3, 7)
    % plot(real(sig4pam), imag(sig4pam), 'x');
    % title("4PAM")
    % axis([-2 2 -2 2])
    
    %% 8PAM 신호 생성
    modNum8pam = 8;
    randBit = randi([0 modNum8pam-1], signalBurstRange, 1);
    sig8pam = pammod(randBit, modNum8pam);
    sig8pam = normalize(sig8pam);
    
    % subplot(3, 3, 8)
    % plot(real(sig8pam), imag(sig8pam), 'x');
    % title("8PAM")
    % axis([-2 2 -2 2])
    
    %% 데이터셋 생성 및 분할
    
    % BPSK
    awgnSigBpsk = awgn(sigBpsk, snr(snrIdx));
    
    % figure;
    % subplot(3, 3, 1)
    % plot(real(awgnSigBpsk), imag(awgnSigBpsk), 'x');
    % title("BPSK")
    
    sigBpsk = reshape(awgnSigBpsk, spf, N_Frame); 
    
    % QPSK
    awgnSigQpsk = awgn(sigQpsk, snr(snrIdx));
    
    % subplot(3, 3, 2)
    % plot(real(awgnSigQpsk), imag(awgnSigQpsk), 'x');
    % title("QPSK")
    
    sigQpsk = reshape(awgnSigQpsk, spf, N_Frame);
    
    % 8PSK
    awgnSig8psk = awgn(sig8psk, snr(snrIdx));
    
    % subplot(3, 3, 3)
    % plot(real(awgnSig8psk), imag(awgnSig8psk), 'x');
    % title("8PSK")
    
    sig8psk = reshape(awgnSig8psk, spf, N_Frame);
    
    % 16QAM
    awgnSig16qam = awgn(sig16qam, snr(snrIdx));
    
    % subplot(3, 3, 4)
    % plot(real(awgnSig16qam), imag(awgnSig16qam), 'x');
    % title("16QAM")
    
    sig16qam = reshape(awgnSig16qam, spf, N_Frame);
    
    % 32QAM
    awgnSig32qam = awgn(sig32qam, snr(snrIdx));
    
    % subplot(3, 3, 5)
    % plot(real(awgnSig32qam), imag(awgnSig32qam), 'x');
    % title("32QAM")
    
    sig32qam = reshape(awgnSig32qam, spf, N_Frame);
    
    % 64QAM
    awgnSig64qam = awgn(sig64qam, snr(snrIdx));
    
    % subplot(3, 3, 6)
    % plot(real(awgnSig64qam), imag(awgnSig64qam), 'x');
    % title("64QAM")
    
    sig64qam = reshape(awgnSig64qam, spf, N_Frame);
    
    % 4PAM
    awgnSig4pam = awgn(sig4pam, snr(snrIdx));
    
    % subplot(3, 3, 7)
    % plot(real(awgnSig4pam), imag(awgnSig4pam), 'x');
    % title("4PAM")
    
    sig4pam = reshape(awgnSig4pam, spf, N_Frame);
    
    % 8PAM
    awgnSig8pam = awgn(sig8pam, snr(snrIdx));
    
    % subplot(3, 3, 8)
    % plot(real(awgnSig8pam), imag(awgnSig8pam), 'x');
    % title("8PAM")
    
    sig8pam = reshape(awgnSig8pam, spf, N_Frame);

    for overlapIndex = 1:length(numSegment)
        Segment = numSegment(overlapIndex);
        fcAccList = [];
        totalFcOutput = 0;
        for segIdx = 1:Segment
            SegmentedSigBpsk = sigBpsk(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            dataBpsk(:,1,:) = real(SegmentedSigBpsk);
            dataBpsk(:,2,:) = imag(SegmentedSigBpsk);
    
            SegmentedSigQpsk = sigQpsk(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            dataQpsk(:,1,:) = real(SegmentedSigQpsk);
            dataQpsk(:,2,:) = imag(SegmentedSigQpsk);
    
            SegmentedSig8psk = sig8psk(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data8psk(:,1,:) = real(SegmentedSig8psk);
            data8psk(:,2,:) = imag(SegmentedSig8psk);
    
            SegmentedSig16qam = sig16qam(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data16qam(:,1,:) = real(SegmentedSig16qam);
            data16qam(:,2,:) = imag(SegmentedSig16qam);
    
            SegmentedSig32qam = sig32qam(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data32qam(:,1,:) = real(SegmentedSig32qam);
            data32qam(:,2,:) = imag(SegmentedSig32qam);
    
            SegmentedSig64qam = sig64qam(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data64qam(:,1,:) = real(SegmentedSig64qam);
            data64qam(:,2,:) = imag(SegmentedSig64qam);
    
            SegmentedSig4pam = sig4pam(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data4pam(:,1,:) = real(SegmentedSig4pam);
            data4pam(:,2,:) = imag(SegmentedSig4pam);
    
            SegmentedSig8pam = sig8pam(1+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex):segmentLength+segmentLength*(segIdx-1)*overlappingRatio(overlapIndex),:);
        
            data8pam(:,1,:) = real(SegmentedSig8pam);
            data8pam(:,2,:) = imag(SegmentedSig8pam);
    
    
            % Total Training Set
            trainingData(:,:,1:N_Frame*testDataRatio) = dataBpsk(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio+1:N_Frame*testDataRatio*2) = dataQpsk(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*2+1:N_Frame*testDataRatio*3) = data8psk(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*3+1:N_Frame*testDataRatio*4) = data16qam(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*4+1:N_Frame*testDataRatio*5) = data32qam(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*5+1:N_Frame*testDataRatio*6) = data64qam(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*6+1:N_Frame*testDataRatio*7) = data4pam(:,:,1:N_Frame*testDataRatio);
            trainingData(:,:,N_Frame*testDataRatio*7+1:N_Frame*testDataRatio*8) = data8pam(:,:,1:N_Frame*testDataRatio);
            
            validationData(:,:,1:N_Frame*validDataRatio) = dataBpsk(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio+1:N_Frame*validDataRatio*2) = dataQpsk(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*2+1:N_Frame*validDataRatio*3) = data8psk(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*3+1:N_Frame*validDataRatio*4) = data16qam(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*4+1:N_Frame*validDataRatio*5) = data32qam(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*5+1:N_Frame*validDataRatio*6) = data64qam(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*6+1:N_Frame*validDataRatio*7) = data4pam(:,:,1+N_Frame*testDataRatio:N_Frame);
            validationData(:,:,N_Frame*validDataRatio*7+1:N_Frame*validDataRatio*8) = data8pam(:,:,1+N_Frame*testDataRatio:N_Frame);
            
            % Labeling Training Set
            for n = 1:N_Frame* testDataRatio * numModTypes 
                rxTestFrames(1,:,:,n) = trainingData(:,:,n);
                if n <=N_Frame* testDataRatio
                    rxTestLabels(n) = modTypes(1);
                elseif n<=N_Frame* testDataRatio *2
                    rxTestLabels(n) = modTypes(2);
                elseif n<=N_Frame* testDataRatio *3
                    rxTestLabels(n) = modTypes(3);
                elseif n<=N_Frame* testDataRatio *4
                    rxTestLabels(n) = modTypes(4);
                elseif n<=N_Frame* testDataRatio *5
                    rxTestLabels(n) = modTypes(5);
                elseif n<=N_Frame* testDataRatio *6
                    rxTestLabels(n) = modTypes(6);
                elseif n<=N_Frame* testDataRatio *7
                    rxTestLabels(n) = modTypes(7);
                elseif n>N_Frame* testDataRatio *7
                    rxTestLabels(n) = modTypes(8);
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
    
%% 학습된 신경망을 통한 결과
    
            trainedNet      = importONNXNetwork(snr(snrIdx) + "dB_AMC_network.onnx");

            fcOutput = activations(trainedNet, rxTestFrames, 'FC1', 'OutputAs', 'row');
            totalFcOutput = totalFcOutput+fcOutput;
        end

        % Feature-Based Fusion Method
        averageFcOutput               = (totalFcOutput/Segment).';
        [maxFcValue, maxFcIndex]    = max(averageFcOutput);
        testFcLabel                   = maxFcIndex;
        testFcPred                    = rxTestLabels;
    
        for n = 1:N_Frame*numModTypes
            if testFcLabel(:,n) == 1
                testFcPred(:, n) = categorical(["16QAM"]);
            end
            if testFcLabel(:, n) == 2
                testFcPred(:, n) = categorical(["32QAM"]);
            end
            if testFcLabel(:, n) == 3
                testFcPred(:, n) = categorical(["4PAM"]);
            end
            if testFcLabel(:, n) == 4
                testFcPred(:, n) = categorical(["64QAM"]);
            end
            if testFcLabel(:, n) == 5
                testFcPred(:, n) = categorical(["8PAM"]);
            end
            if testFcLabel(:, n) == 6
                testFcPred(:, n) = categorical(["8PSK"]);
            end
            if testFcLabel(:, n) == 7
                testFcPred(:, n) = categorical(["BPSK"]);
            end
            if testFcLabel(:, n) == 8
                testFcPred(:, n) = categorical(["QPSK"]);
            end
        end
        
        testFcAccuracy    = mean(testFcPred == rxTestLabels);
        fcAccList         = horzcat(fcAccList, testFcAccuracy);
        totalTestAcc      = horzcat(totalTestAcc,fcAccList);
    end
%     totalTestAcc = horzcat(totalTestAcc,fcAccList);
end

totalTestAcc = reshape(totalTestAcc, 4, 21);




