%% 초기화
% clc; close all; clear;

%% 기본 설정
modSymbolTypes = categorical(["QPSK_00_", "QPSK_01_", "QPSK_10_", "QPSK_11_"]);

numSymbolTypes = length(modSymbolTypes);

percentTrainingSamples = 80;
percentValidationSamples = 10;
percentTestSamples = 10;

SPF = [4 8 16 32];
SNR = -5:5:10;
% Phase = [1 8 4];

trainNow = true;

totalSymbolNum = 50000;
numFramesPerModType = 10000;
symbolNum = 10000;

%% 파형 생성
tic
for numSNR = 1:4
    for numSPF = 4:4
        dataDirectory = fullfile("SymbolDatasets", "QPSK", "AWGN", string(SNR(numSNR)), string(SPF(numSPF)));
        disp("Data file directory is " + dataDirectory)

        fileNameRoot = "frame";
        dataFilesExist = false;
        if exist(dataDirectory,'dir')
            files = dir(fullfile(dataDirectory,sprintf("%s*",fileNameRoot)));
            if length(files) == numSymbolTypes*numFramesPerModType
                dataFilesExist = true;
            end
        end
    
        if ~dataFilesExist
            disp("Generating data and saving in data files...")
            [success,msg,msgID] = mkdir(dataDirectory);
            if ~success
                error(msgID,msg)
            end

            for symType = 0:numSymbolTypes-1
                for p = 1:numFramesPerModType
                    rand = randi([0 3], SPF(numSPF)*30, 1);
                    x = pskmod(rand, 4, pi/4);
                    y = normalize(awgn(x, SNR(numSNR)));
                    
                    idxList = find(rand==symType);
                    symbol = zeros(SPF(numSPF), 1);
                    for idx = 1:SPF(numSPF)
                        symbol(idx) = y(idxList(idx));
                    end
                    label = modSymbolTypes(symType+1);
                    fileName = fullfile(dataDirectory,...
                        sprintf("%s%s%03d",fileNameRoot,modSymbolTypes(symType+1),p));
                      save(fileName,"symbol","label")
                end
            end
        else
            disp("Data files exist. Skip data generation.")
        end
        
%% 데이터 저장소 만들기
        frameDS = signalDatastore(dataDirectory,'SignalVariableNames',["symbol","label"]);

        % 복소 신호를 실수형 배열로 변환하기
        frameDSTrans = transform(frameDS,@helperModClassIQAsPages);

        % % 훈련, 검증, 테스트로 분할하기
        splitPercentages = [percentTrainingSamples,percentValidationSamples,percentTestSamples];
        [trainDSTrans,validDSTrans,testDSTrans] = helperModClassSplitData(frameDSTrans,splitPercentages);

        % 데이터를 메모리로 가져오기
        % Gather the training and validation frames into the memory
        trainFramesTall = tall(transform(trainDSTrans, @helperModClassReadFrame));
        rxTrainFrames = gather(trainFramesTall);

        rxTrainFrames = cat(4, rxTrainFrames{:});
        validFramesTall = tall(transform(validDSTrans, @helperModClassReadFrame));
        rxValidFrames = gather(validFramesTall);

        rxValidFrames = cat(4, rxValidFrames{:});

        % % Gather the training and validation labels into the memory
        trainLabelsTall = tall(transform(trainDSTrans, @helperModClassReadLabel));
        rxTrainLabels = gather(trainLabelsTall);

        validLabelsTall = tall(transform(validDSTrans, @helperModClassReadLabel));
        rxValidLabels = gather(validLabelsTall);

        % %% CNN 훈련시키기
        % modClassNet = helperModClassCNN(modulationTypes,sps,spf(spf_num));
        numSymbolTypes = numel(modSymbolTypes);

        netWidth = 1;
        filterSize = [1 8];
        poolSize = [1 2];
        modClassNet = [
          imageInputLayer([1 SPF(numSPF) 2], 'Normalization', 'none', 'Name', 'Input Layer')

          convolution2dLayer(filterSize, 16*netWidth, 'Padding', 'same', 'Name', 'CNN1')
          batchNormalizationLayer('Name', 'BN1')
          reluLayer('Name', 'ReLU1')
          maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool1')

          convolution2dLayer(filterSize, 24*netWidth, 'Padding', 'same', 'Name', 'CNN2')
          batchNormalizationLayer('Name', 'BN2')
          reluLayer('Name', 'ReLU2')
          maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool2')

          convolution2dLayer(filterSize, 32*netWidth, 'Padding', 'same', 'Name', 'CNN3')
          batchNormalizationLayer('Name', 'BN3')
          reluLayer('Name', 'ReLU3')
          maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool3')

          convolution2dLayer(filterSize, 48*netWidth, 'Padding', 'same', 'Name', 'CNN4')
          batchNormalizationLayer('Name', 'BN4')
          reluLayer('Name', 'ReLU4')
          maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool4')
% 
%           convolution2dLayer(filterSize, 64*netWidth, 'Padding', 'same', 'Name', 'CNN5')
%           batchNormalizationLayer('Name', 'BN5')
%           reluLayer('Name', 'ReLU5')
%           maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool5')

          convolution2dLayer(filterSize, 96*netWidth, 'Padding', 'same', 'Name', 'CNN6')
          batchNormalizationLayer('Name', 'BN6')
          reluLayer('Name', 'ReLU6')

          averagePooling2dLayer([1 ceil(SPF(numSPF)/32)], 'Name', 'AP1')

          fullyConnectedLayer(numSymbolTypes, 'Name', 'FC1')
          softmaxLayer('Name', 'SoftMax')

          classificationLayer('Name', 'Output') ];

        maxEpochs = 20;
        miniBatchSize = 256;
        options = helperModClassTrainingOptions(maxEpochs,miniBatchSize,...
          numel(rxTrainLabels),rxValidFrames,rxValidLabels);

        if trainNow == true
          fprintf('%s - Training the network\n', datestr(toc/86400,'HH:MM:SS'))
          trainedNet = trainNetwork(rxTrainFrames,rxTrainLabels,modClassNet,options);
        else
          load trainedModulationClassificationNetwork
        end

        % 테스트 프레임에 대한 분류 정확도를 구하여 훈련된 신경망을 평가
        fprintf('%s - Classifying test frames\n', datestr(toc/86400,'HH:MM:SS'))

        % Gather the test frames into the memory
        testFramesTall = tall(transform(testDSTrans, @helperModClassReadFrame));
        rxTestFrames = gather(testFramesTall);

        rxTestFrames = cat(4, rxTestFrames{:});

        % Gather the test labels into the memory
        testLabelsTall = tall(transform(testDSTrans, @helperModClassReadLabel));
        rxTestLabels = gather(testLabelsTall);

        rxTestPred = classify(trainedNet,rxTestFrames);
        testAccuracy = mean(rxTestPred == rxTestLabels);
        disp("Test accuracy: " + testAccuracy*100 + "%")

        figure
        cm = confusionchart(rxTestLabels, rxTestPred);
        cm.Title = 'SNR=' + string(SNR(numSNR)) + '/SPF=' + string(SPF(numSPF));
        cm.RowSummary = 'row-normalized';
        cm.Parent.Position = [cm.Parent.Position(1:2) 740 424];
    end
end










% rand = randi([0 3], totalSymbolNum, 1);
% x = pskmod(rand, 4, pi/4);
% y = normalize(awgn(x, 20));
% 
% for idx = 0:3
%     makeList = ['idxList_',num2str(idx),' = find(rand==', num2str(idx),');'];
%     eval(makeList);
%     makeSymbolList = ['PSK_Q_Symbol_',num2str(idx),' = zeros(symbolNum, 1);'];
%     eval(makeSymbolList);
% end
% 
% for idx = 1:symbolNum
%     PSK_Q_Symbol_0(idx) = y(idxList_0(idx));
%     PSK_Q_Symbol_1(idx) = y(idxList_1(idx));
%     PSK_Q_Symbol_2(idx) = y(idxList_2(idx));
%     PSK_Q_Symbol_3(idx) = y(idxList_3(idx));
% end
