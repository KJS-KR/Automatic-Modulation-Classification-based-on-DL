%% 초기화
clc; close all; clear;

%% 훈련 데이터 파형 생성 기본 설정

modTypes = categorical(["QPSK", "16QAM", "64QAM"]);
numModTypes = length(modTypes);

numFramesPerModType = 192000;

percentTrainingSamples = 80;
percentValidationSamples = 10;
percentTestSamples = 10;

SPF = [2 4 8];
SNR = -6:2:10;

trainNow = true;

%% 파형 생성
tic
for SNR_num = 9:1:9
    for SPF_num = 2:1:2
        SNR_string = "SNR="+SNR(SNR_num);
        SPF_string = "SPF="+SPF(SPF_num);
        
        for modType = 1:numModTypes
            modTypeName = string(modTypes(modType));
            directoryName = SNR_string + "_" + SPF_string;
            dataDirectory = fullfile("DataFiles", "Channel=AWGN", "Repeated_Transmission", directoryName, modTypeName);
            disp("Data file directory is " + dataDirectory)

            fileNameRoot = "frame";

            dataFilesExist = false;
            if exist(dataDirectory,'dir')
              files = dir(fullfile(dataDirectory,sprintf("%s*",fileNameRoot)));

              if length(files) == numFramesPerModType
                dataFilesExist = true;
              end
            end

            if ~dataFilesExist
              disp("Generating data and saving in data files...")
              [success,msg,msgID] = mkdir(dataDirectory);

              if ~success
                error(msgID,msg)
              end

                fprintf('%s - Generating %s frames\n', ...
                  datestr(toc/86400,'HH:MM:SS'), modTypes(modType))
                  for p = 1:numFramesPerModType
                    if modTypes(modType) == "QPSK"
                        modNum = 4;
    %                     elseif modTypes(modType) == "8PSK"
    %                         modNum = 8;
                    elseif modTypes(modType) == "16QAM"
                        modNum = 16;
                    elseif modTypes(modType) == "64QAM"
                        modNum = 64;
                    end
                    rand = randi([0 modNum-1], SPF(SPF_num), 1);

                    if modNum == 4
                        x = pskmod(rand, modNum, pi/4);
                        x_norm = normalize(x);
                        y = awgn(x_norm, SNR(SNR_num));
                    elseif modNum == 16
                        x = qammod(rand, modNum);
                        x_norm = normalize(x);
                        y = awgn(x_norm, SNR(SNR_num));
                    elseif modNum == 64
                        x = qammod(rand, modNum);
                        x_norm = normalize(x);
                        y = awgn(x_norm, SNR(SNR_num));
                    end

                    orderData = y;
                    orderLabel = modTypes(modType);

                    fileName = fullfile(dataDirectory,...
                        sprintf("%s%s%03d",fileNameRoot,modTypes(modType),p));
                      save(fileName, "orderData", "orderLabel")
                  end
            else
              disp("Data files exist. Skip data generation.")
            end
        end
%% 변조 유형 분류 데이터 저장소 만들기
                dataDirectory = fullfile("DataFiles", "Channel=AWGN", "Repeated_Transmission", directoryName);
                frameDS = signalDatastore(dataDirectory, 'IncludeSubfolders', 1, 'SignalVariableNames', ["orderData","orderLabel"]);

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

%% CNN 훈련시키기
                % modClassNet = helperModClassCNN(modulationTypes,sps,spf(spf_num));
                numModTypes = numel(modTypes);

                netWidth = 1;
                filterSize = [1 8];
                poolSize = [1 2];
                modClassNet = [
                  imageInputLayer([1 SPF(SPF_num) 2], 'Normalization', 'none', 'Name', 'Input Layer')

                  convolution2dLayer(filterSize, 16*netWidth, 'Padding', 'same', 'Name', 'CNN1')
                  batchNormalizationLayer('Name', 'BN1')
                  reluLayer('Name', 'ReLU1')
                  maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool1')

                  convolution2dLayer(filterSize, 24*netWidth, 'Padding', 'same', 'Name', 'CNN2')
                  batchNormalizationLayer('Name', 'BN2')
                  reluLayer('Name', 'ReLU2')
                  maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool2')

%                   convolution2dLayer(filterSize, 32*netWidth, 'Padding', 'same', 'Name', 'CNN3')
%                   batchNormalizationLayer('Name', 'BN3')
%                   reluLayer('Name', 'ReLU3')
%                   maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool3')

%                   convolution2dLayer(filterSize, 48*netWidth, 'Padding', 'same', 'Name', 'CNN4')
%                   batchNormalizationLayer('Name', 'BN4')
%                   reluLayer('Name', 'ReLU4')
%                   maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool4')
 
        %           convolution2dLayer(filterSize, 64*netWidth, 'Padding', 'same', 'Name', 'CNN5')
        %           batchNormalizationLayer('Name', 'BN5')
        %           reluLayer('Name', 'ReLU5')
        %           maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool5')

                  convolution2dLayer(filterSize, 96*netWidth, 'Padding', 'same', 'Name', 'CNN6')
                  batchNormalizationLayer('Name', 'BN6')
                  reluLayer('Name', 'ReLU6')

                  averagePooling2dLayer([1 ceil(SPF(SPF_num)/32)], 'Name', 'AP1')

                  fullyConnectedLayer(numModTypes, 'Name', 'FC1')
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
                cm.Title = 'order-SNR=' + string(SNR(SNR_num)) + '/SPF=' + string(SPF(SPF_num));
                cm.RowSummary = 'row-normalized';
                cm.Parent.Position = [cm.Parent.Position(1:2) 740 424];
    end
end