%% 초기회
clc; clear; close all;

%%  8개의 디지털 변조 유형과 3개의 아날로그 변조 유형을 인식
% modulationTypes = categorical(["BPSK", "QPSK", "8PSK", ...
%   "16QAM", "64QAM", "PAM4", "GFSK", "CPFSK", ...
%   "B-FM", "DSB-AM", "SSB-AM"]);

% Test를 위해 5개의 변조 유형만 선택
modulationTypes = categorical(["QPSK", "8PSK"]);
% modulationTypes = categorical(["16QAM", "64QAM"]);

%% 훈련을 위한 파형 생성
% 각 변조 유형에 대해 10,000개의 프레임을 생성합니다. 그중에서 80%는 훈련용으로, 10%는 검증용으로, 10%는 테스트용
trainNow = true;
if trainNow == true
  numFramesPerModType = 10000;
else
  numFramesPerModType = 500;
end
percentTrainingSamples = 80;
percentValidationSamples = 10;
percentTestSamples = 10;

phase_list = [1, 36, 18, 12, 9, 7.2, 6, 5.143, 4.5, 4, 3.6, 3.273, 3, 2.77, 2.571, 2.4, 2.25, 2.118, 2];
phase_125 = 12.5;

SNR = 0:5:30;
sps = 8;                % Samples per symbol
spf = 1024;             % Samples per frame
symbolsPerFrame = spf / sps;
fs = 200e3;             % Sample rate
fc = [902e6 100e6];     % Center frequencies

%% 
% maxDeltaOff = 5;
% deltaOff = (rand()*2*maxDeltaOff) - maxDeltaOff;
% C = 1 + (deltaOff/1e6);

testAccuracyList = [];
phaseList = [];
%% 결합된 채널
% 프레임에 세 가지 채널 손상을 모두 적용하려면 helperModClassTestChannel 객체를 사용
for SNR_num = 1:1:7 
    for phase_q = 1:1:1
        for phase_8 = 9:1:9
            channel = helperModClassTestChannel(...
              'SampleRate', fs, ...
              'SNR', SNR(SNR_num), ...
              'KFactor', 4, ...
              'MaximumDopplerShift', 4, ...
              'MaximumClockOffset', 5, ...
              'PathDelays', [0 1.8 3.4] / fs, ...
              'AveragePathGains', [0 -2 -10], ...
              'CenterFrequency', 902e6);

            %   'MaximumDopplerShift', 4, ...
            %   'MaximumClockOffset', 5, ...
            %   'PathDelays', [0 1.8 3.4] / fs, ...
            %   'AveragePathGains', [0 -2 -10], ...
                
            %% info 객체 함수를 사용하여 채널에 대한 기본 정보를 확인
            chInfo = info(channel);

%% 파형 생성
% Set the random number generator to a known state to be able to regenerate
% the same frames every time the simulation is run
            rng(1235)
            tic

            numModulationTypes = length(modulationTypes);

            channelInfo = info(channel);
            transDelay = 50;
            make_dir = ['dataDirectory = fullfile("DataFiles", "SNR_',num2str(SNR(SNR_num)),'", "3Channel_on_QPSK_', num2str(phase_q*0),'_8PSK_', num2str(phase_8*5),'");'];
            eval(make_dir);
            disp("Data file directory is " + dataDirectory)

            fileNameRoot = "frame";

            % Check if data files exist
            dataFilesExist = false;
            if exist(dataDirectory,'dir')
              files = dir(fullfile(dataDirectory,sprintf("%s*",fileNameRoot)));
              if length(files) == numModulationTypes*numFramesPerModType
                dataFilesExist = true;
              end
            end

            if ~dataFilesExist
              disp("Generating data and saving in data files...")
              [success,msg,msgID] = mkdir(dataDirectory);
              if ~success
                error(msgID,msg)
              end
              for modType = 1:numModulationTypes
                fprintf('%s - Generating %s frames\n', ...
                  datestr(toc/86400,'HH:MM:SS'), modulationTypes(modType))

                label = modulationTypes(modType);
                numSymbols = (numFramesPerModType / sps);
                dataSrc = helperModClassGetSource(modulationTypes(modType), sps, 2*spf, fs);
                modulator = helperModClassGetModulator(modulationTypes(modType), sps, fs, phase_q, phase_list(phase_8));
                if contains(char(modulationTypes(modType)), {'B-FM','DSB-AM','SSB-AM'})
                  % Analog modulation types use a center frequency of 100 MHz
                  channel.CenterFrequency = 100e6;
                else
                  % Digital modulation types use a center frequency of 902 MHz
                  channel.CenterFrequency = 902e6;
                end

                for p=1:numFramesPerModType
                  % Generate random data
                  x = dataSrc();

                  % Modulate
                  y = modulator(x);

                  % Pass through independent channels
                  rxSamples = channel(y);

                  % Remove transients from the beginning, trim to size, and normalize
                  frame = helperModClassFrameGenerator(rxSamples, spf, spf, transDelay, sps);

                  % Save data file
                  fileName = fullfile(dataDirectory,...
                    sprintf("%s%s%03d",fileNameRoot,modulationTypes(modType),p));
                  save(fileName,"frame","label")
                end
              end
            else
              disp("Data files exist. Skip data generation.")
            end
%% 데이터 저장소 만들기
            frameDS = signalDatastore(dataDirectory,'SignalVariableNames',["frame","label"]);

            % 복소 신호를 실수형 배열로 변환하기
            frameDSTrans = transform(frameDS,@helperModClassIQAsPages);

            % 훈련, 검증, 테스트로 분할하기
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

            % Gather the training and validation labels into the memory
            trainLabelsTall = tall(transform(trainDSTrans, @helperModClassReadLabel));
            rxTrainLabels = gather(trainLabelsTall);

            validLabelsTall = tall(transform(validDSTrans, @helperModClassReadLabel));
            rxValidLabels = gather(validLabelsTall);

%% CNN 훈련시키기
            modClassNet = helperModClassCNN(modulationTypes,sps,spf);

            maxEpochs = 25;
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

            testAccuracyList = horzcat(testAccuracyList, testAccuracy*100);
            phaseList = horzcat(phaseList, phase_8*5);

            figure
            cm = confusionchart(rxTestLabels, rxTestPred);
            cm.Title = testAccuracy*100;
            cm.RowSummary = 'row-normalized';
            cm.Parent.Position = [cm.Parent.Position(1:2) 740 424];

    % %% SDR을 사용하여 테스트하기
    %         radioPlatform = "ADALM-PLUTO";
    % 
    %         switch radioPlatform
    %           case "ADALM-PLUTO"
    %             if helperIsPlutoSDRInstalled() == true
    %               radios = findPlutoRadio();
    %               if length(radios) >= 2
    %                 helperModClassSDRTest(radios);
    %               else
    %                 disp('Selected radios not found. Skipping over-the-air test.')
    %               end
    %             end
    %           case {"USRP B2xx","USRP X3xx","USRP N2xx"}
    %             if (helperIsUSRPInstalled() == true) && (helperIsPlutoSDRInstalled() == true)
    %               txRadio = findPlutoRadio();
    %               rxRadio = findsdru();
    %               switch radioPlatform
    %                 case "USRP B2xx"
    %                   idx = contains({rxRadio.Platform}, {'B200','B210'});
    %                 case "USRP X3xx"
    %                   idx = contains({rxRadio.Platform}, {'X300','X310'});
    %                 case "USRP N2xx"
    %                   idx = contains({rxRadio.Platform}, 'N200/N210/USRP2');
    %               end
    %               rxRadio = rxRadio(idx);
    %               if (length(txRadio) >= 1) && (length(rxRadio) >= 1)
    %                 helperModClassSDRTest(rxRadio);
    %               else
    %                 disp('Selected radios not found. Skipping over-the-air test.')
    %               end
    %             end
    %         end
        end
    end
end
figure;
plot(testAccuracyList, phaseList, 'x');