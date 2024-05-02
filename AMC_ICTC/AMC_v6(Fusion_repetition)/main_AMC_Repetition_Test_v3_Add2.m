clc; clear; close all;

%% Setting

modTypes    = categorical(["BPSK", "QPSK", "8PSK", "16QAM", "32QAM", "64QAM", "4PAM", "8PAM"]);
numModTypes = length(modTypes);     


numRepetition       = 4;
spf                 = 512;          % 프레임 당 샘플 수
N_Frame             = 1000;         % 프레임 수
snr                 = -20:2:20;     % 신호 대 잡음비(dB)
numSnr              = length(snr);  

testDataRatio       = 1;          % 훈련 프레임 비율

totalFcOutput = 0;
totalSoftOutput = 0;
totalTestAcc = 0;

fcAccList = [];
softAccList = [];
votAccList = [];
noFusionAccList = [];

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
        addSigBpsk(1:spf,:) = repSigBpsk(1:spf,:) + repSigBpsk(1+spf:spf*2);
        addSigBpsk(1+spf:spf*2,:) = repSigBpsk(1+spf*2:spf*3) + repSigBpsk(1+spf*3:spf*4);
        
        add1SigBpsk(1:spf*2,frameIdx) = addSigBpsk;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSigQpsk(1:spf,:) = repSigQpsk(1:spf,:) + repSigQpsk(1+spf:spf*2);
        addSigQpsk(1+spf:spf*2,:) = repSigQpsk(1+spf*2:spf*3) + repSigQpsk(1+spf*3:spf*4);
        
        add1SigQpsk(1:spf*2,frameIdx) = addSigQpsk;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig8psk(1:spf,:) = repSig8psk(1:spf,:) + repSig8psk(1+spf:spf*2);
        addSig8psk(1+spf:spf*2,:) = repSig8psk(1+spf*2:spf*3) + repSig8psk(1+spf*3:spf*4);
        
        add1Sig8psk(1:spf*2,frameIdx) = addSig8psk;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig16qam(1:spf,:) = repSig16qam(1:spf,:) + repSig16qam(1+spf:spf*2);
        addSig16qam(1+spf:spf*2,:) = repSig16qam(1+spf*2:spf*3) + repSig16qam(1+spf*3:spf*4);
        
        add1Sig16qam(1:spf*2,frameIdx) = addSig16qam;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig32qam(1:spf,:) = repSig32qam(1:spf,:) + repSig32qam(1+spf:spf*2);
        addSig32qam(1+spf:spf*2,:) = repSig32qam(1+spf*2:spf*3) + repSig32qam(1+spf*3:spf*4);
        
        add1Sig32qam(1:spf*2,frameIdx) = addSig32qam;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig64qam(1:spf,:) = repSig64qam(1:spf,:) + repSig64qam(1+spf:spf*2);
        addSig64qam(1+spf:spf*2,:) = repSig64qam(1+spf*2:spf*3) + repSig64qam(1+spf*3:spf*4);
        
        add1Sig64qam(1:spf*2,frameIdx) = addSig64qam;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig4pam(1:spf,:) = repSig4pam(1:spf,:) + repSig4pam(1+spf:spf*2);
        addSig4pam(1+spf:spf*2,:) = repSig4pam(1+spf*2:spf*3) + repSig4pam(1+spf*3:spf*4);
        
        add1Sig4pam(1:spf*2,frameIdx) = addSig4pam;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

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
        addSig8pam(1:spf,:) = repSig8pam(1:spf,:) + repSig8pam(1+spf:spf*2);
        addSig8pam(1+spf:spf*2,:) = repSig8pam(1+spf*2:spf*3) + repSig8pam(1+spf*3:spf*4);
        
        add1Sig8pam(1:spf*2,frameIdx) = addSig8pam;

        % (1rep+2rep+3rep+4rep)
        % 개발 예정

    end

    for segIdx = 1:2
        SegmentedSigBpsk = add1SigBpsk(1+spf*(segIdx-1):spf*segIdx,:);
    
        dataBpsk(:,1,:) = real(SegmentedSigBpsk);
        dataBpsk(:,2,:) = imag(SegmentedSigBpsk);

        SegmentedSigQpsk = add1SigQpsk(1+spf*(segIdx-1):spf*segIdx,:);
    
        dataQpsk(:,1,:) = real(SegmentedSigQpsk);
        dataQpsk(:,2,:) = imag(SegmentedSigQpsk);

        SegmentedSig8psk = add1Sig8psk(1+spf*(segIdx-1):spf*segIdx,:);
    
        data8psk(:,1,:) = real(SegmentedSig8psk);
        data8psk(:,2,:) = imag(SegmentedSig8psk);

        SegmentedSig16qam = add1Sig16qam(1+spf*(segIdx-1):spf*segIdx,:);
    
        data16qam(:,1,:) = real(SegmentedSig16qam);
        data16qam(:,2,:) = imag(SegmentedSig16qam);

        SegmentedSig32qam = add1Sig32qam(1+spf*(segIdx-1):spf*segIdx,:);
    
        data32qam(:,1,:) = real(SegmentedSig32qam);
        data32qam(:,2,:) = imag(SegmentedSig32qam);

        SegmentedSig64qam = add1Sig64qam(1+spf*(segIdx-1):spf*segIdx,:);
    
        data64qam(:,1,:) = real(SegmentedSig64qam);
        data64qam(:,2,:) = imag(SegmentedSig64qam);

        SegmentedSig4pam = add1Sig4pam(1+spf*(segIdx-1):spf*segIdx,:);
    
        data4pam(:,1,:) = real(SegmentedSig4pam);
        data4pam(:,2,:) = imag(SegmentedSig4pam);

        SegmentedSig8pam = add1Sig8pam(1+spf*(segIdx-1):spf*segIdx,:);
    
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

%% 학습된 신경망을 통한 결과

        testPred = rxTestLabels;

        trainedNet      = importONNXNetwork(snr(snrIdx) + "dB_AMC_network(Add2).onnx");
        rxTestPred      = classify(trainedNet,rxTestFrames);
        rxTestPred      = rxTestPred.';

        for n = 1:length(rxTestPred)
            if rxTestPred(:,n) == "1"
                testPred(:, n) = categorical(["16QAM"]);
            end
            if rxTestPred(:, n) == "2"
                testPred(:, n) = categorical(["32QAM"]);
            end
            if rxTestPred(:, n) == "3"
                testPred(:, n) = categorical(["4PAM"]);
            end
            if rxTestPred(:, n) == "4"
                testPred(:, n) = categorical(["64QAM"]);
            end
            if rxTestPred(:, n) == "5"
                testPred(:, n) = categorical(["8PAM"]);
            end
            if rxTestPred(:, n) == "6"
                testPred(:, n) = categorical(["8PSK"]);
            end
            if rxTestPred(:, n) == "7"
                testPred(:, n) = categorical(["BPSK"]);
            end
            if rxTestPred(:, n) == "8"
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
    averageTestAcc              = (totalTestAcc/2);

    % Feature-Based Fusion Method
    averageFcOutput             = (totalFcOutput/2).';
    [maxFcValue, maxFcIndex]    = max(averageFcOutput);
    testFcLabel                 = maxFcIndex;

    testFcPred = rxTestLabels;

    for n = 1:N_Frame*numModTypes
        if testFcLabel(:, n) == 1
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

    % Confidence-Based Fusion Method
    averageSoftOutput               = (totalSoftOutput/2).';
    [maxSoftValue, maxSoftIndex]    = max(averageSoftOutput);
    testSoftLabel                   = maxSoftIndex;

    testSoftPred                    = rxTestLabels;

    for n = 1:N_Frame*numModTypes
        if testSoftLabel(:,n) == 1
            testSoftPred(:, n) = categorical(["16QAM"]);
        end
        if testSoftLabel(:, n) == 2
            testSoftPred(:, n) = categorical(["32QAM"]);
        end
        if testSoftLabel(:, n) == 3
            testSoftPred(:, n) = categorical(["4PAM"]);
        end
        if testSoftLabel(:, n) == 4
            testSoftPred(:, n) = categorical(["64QAM"]);
        end
        if testSoftLabel(:, n) == 5
            testSoftPred(:, n) = categorical(["8PAM"]);
        end
        if testSoftLabel(:, n) == 6
            testSoftPred(:, n) = categorical(["8PSK"]);
        end
        if testSoftLabel(:, n) == 7
            testSoftPred(:, n) = categorical(["BPSK"]);
        end
        if testSoftLabel(:, n) == 8
            testSoftPred(:, n) = categorical(["QPSK"]);
        end
    end

    noFusionAccList     = horzcat(noFusionAccList, testAccuracy);

    votAccList         = horzcat(votAccList, averageTestAcc);

    testFcAccuracy      = mean(testFcPred == rxTestLabels);
    fcAccList           = horzcat(fcAccList, testFcAccuracy);

    testSoftAccuracy    = mean(testSoftPred == rxTestLabels);
    softAccList         = horzcat(softAccList, testSoftAccuracy);

end % SNR



