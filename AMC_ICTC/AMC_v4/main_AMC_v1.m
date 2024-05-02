clc; clear; close all;

%% Data set generation
modTypes = categorical(["QPSK", "8PSK"]);
numModTypes = length(modTypes);

N_train = 100; % training frame 개수 
N_valid = 100; % validation frame 개수
N_frame = 32; % frame 길이

% rxValidFrames: 1 x N_frame x 2 (real,imag) x Nvalid*numModTypes
% rxValidLabels: categorical 배열, 
% rxTrainFrames: 1 x N_frame x 2 (real,imag) x Ntrain*numModTypes
% rxTrainLabels: categorical 배열, 

%% training set
[rxTrainFrames, rxTrainLabels] = DataSetGen(N_train,N_frame,modTypes);

%% validation set
[rxValidFrames, rxValidLabels] = DataSetGen(N_valid,N_frame,modTypes);

%% CNN 훈련시키기
netWidth = 1;
filterSize = [1 8];
poolSize = [1 2];
modClassNet = [
  imageInputLayer([1 N_frame 2], 'Normalization', 'none', 'Name', 'Input Layer')

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

  convolution2dLayer(filterSize, 64*netWidth, 'Padding', 'same', 'Name', 'CNN5')
  batchNormalizationLayer('Name', 'BN5')
  reluLayer('Name', 'ReLU5')
  maxPooling2dLayer(poolSize, 'Stride', [1 2], 'Name', 'MaxPool5')

  convolution2dLayer(filterSize, 96*netWidth, 'Padding', 'same', 'Name', 'CNN6')
  batchNormalizationLayer('Name', 'BN6')
  reluLayer('Name', 'ReLU6')

  averagePooling2dLayer([1 ceil(N_frame/32)], 'Name', 'AP1')

  fullyConnectedLayer(numModTypes, 'Name', 'FC1')
  softmaxLayer('Name', 'SoftMax')

  classificationLayer('Name', 'Output') ];


maxEpochs = 15;
miniBatchSize = 256;


options = helperModClassTrainingOptions(maxEpochs,miniBatchSize,numel(rxTrainLabels),rxValidFrames,rxValidLabels);
trainedNet = trainNetwork(rxTrainFrames,rxTrainLabels,modClassNet,options);