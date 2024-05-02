clc; clear; close all;

%% Setting

modTypes    = categorical(["BPSK", "QPSK", "8PSK", "16QAM", "32QAM", "64QAM", "4PAM", "8PAM"]);
numModTypes = length(modTypes);

spf                 = 512;
N_Frame             = 5000;
signalBurstRange    = spf * N_Frame;
snr                 = -20:2:30;
numSnr              = length(snr);
trainDataRatio      = 0.5;   % 훈련 프레임 비율
validDataRatio      = 0.5;   % 검증 프레임 비율

%% BPSK 신호 생성
modNumBpsk = 2;

randBit = randi([0 modNumBpsk-1], signalBurstRange, 1);

sigBpsk = pskmod(randBit, 2);

% figure;
% subplot(3, 4, 1)
% plot(real(sigBpsk), imag(sigBpsk), 'x');
% title("BPSK")
% axis([-2 2 -2 2])

%% QPSK 신호 생성
modNumQpsk = 4;

randBit = randi([0 modNumQpsk-1], signalBurstRange, 1);

sigQpsk = pskmod(randBit, 4, pi/4);

% subplot(3, 4, 2)
% plot(real(sigQpsk), imag(sigQpsk), 'x');
% title("QPSK")
% axis([-2 2 -2 2])

%% 8PSK 신호 생성
modNum8psk = 8;

randBit = randi([0 modNum8psk-1], signalBurstRange, 1);

sig8psk = pskmod(randBit, 8, pi/4);

% subplot(3, 4, 3)
% plot(real(sig8psk), imag(sig8psk), 'x');
% title("8PSK")
% axis([-2 2 -2 2])

%% OQPSK 신호 생성
% modNumOqpsk = 4;
% 
% randBit = randi([0 1], 1000, 1);
% 
% oqpskmod = comm.OQPSKModulator('BitInput',true);
% sigOqpsk = oqpskmod(randBit);
% 
% subplot(3, 4, 4)
% plot(real(sigOqpsk), imag(sigOqpsk), 'x');
% title("OQPSK")
% axis([-2 2 -2 2])

%% 2FSK 신호 생성
% modNum2fsk = 2;
% 
% randBit = randi([0 modNum2fsk-1], 1000, 1);
% 
% sig2fsk = fskmod(randBit, 2);
% 
% subplot(3, 4, 5)
% plot(real(sig2fsk), imag(sig2fsk), 'x');
% title("2FSK")
% axis([-2 2 -2 2])

%% 4FSK 신호 생성
% modNum4fsk = 4;
% 
% randBit = randi([0 modNum4fsk-1], 1000, 1);
% 
% sig4fsk = fskmod(randBit, 4);
% 
% subplot(3, 4, 6)
% plot(real(sig4fsk), imag(sig4fsk), 'x');
% title("4FSK")
% axis([-2 2 -2 2])

%% 8FSK 신호 생성
% modNum8fsk = 8;
% 
% randBit = randi([0 modNum8fsk-1], 1000, 1);
% 
% sig8fsk = fskmod(randBit, 8);
% 
% subplot(3, 4, 7)
% plot(real(sigOqpsk), imag(sigOqpsk), 'x');
% title("8FSK")
% axis([-2 2 -2 2])

%% 16QAM 신호 생성
modNum16qam = 16;

randBit = randi([0 modNum16qam-1], signalBurstRange, 1);

sig16qam = qammod(randBit, modNum16qam, 'UnitAveragePower', true);

% subplot(3, 4, 8)
% plot(real(sig16qam), imag(sig16qam), 'x');
% title("16QAM")
% axis([-2 2 -2 2])

%% 32QAM 신호 생성
modNum32qam = 32;

randBit = randi([0 modNum32qam-1], signalBurstRange, 1);

sig32qam = qammod(randBit, modNum32qam, 'UnitAveragePower', true);

% subplot(3, 4, 9)
% plot(real(sig32qam), imag(sig32qam), 'x');
% title("32QAM")
% axis([-2 2 -2 2])

%% 64QAM 신호 생성
modNum64qam = 64;

randBit = randi([0 modNum64qam-1], signalBurstRange, 1);

sig64qam = qammod(randBit, modNum64qam, 'UnitAveragePower', true);

% subplot(3, 4, 10)
% plot(real(sig64qam), imag(sig64qam), 'x');
% title("64QAM")
% axis([-2 2 -2 2])

%% 4PAM 신호 생성
modNum4pam = 4;

randBit = randi([0 modNum4pam-1], signalBurstRange, 1);

sig4pam = pammod(randBit, modNum4pam);
sig4pam = normalize(sig4pam);

% subplot(3, 4, 11)
% plot(real(sig4pam), imag(sig4pam), 'x');
% title("4PAM")
% axis([-2 2 -2 2])


%% 8PAM 신호 생성
modNum8pam = 8;

randBit = randi([0 modNum8pam-1], signalBurstRange, 1);

sig8pam = pammod(randBit, modNum8pam);
sig8pam = normalize(sig8pam);

% subplot(3, 4, 12)
% plot(real(sig8pam), imag(sig8pam), 'x');
% title("8PAM")
% axis([-2 2 -2 2])

for n = 1:numSnr

% BPSK
awgnSigBpsk = awgn(sigBpsk, snr(n));
sigBpsk = reshape(sigBpsk, spf, N_Frame);
dataBpsk(:,1,:) = real(sigBpsk);
dataBpsk(:,2,:) = imag(sigBpsk);

% QPSK
awgnSigQpsk = awgn(sigQpsk, snr(n));
sigQpsk = reshape(sigQpsk, spf, N_Frame);
dataQpsk(:,1,:) = real(sigQpsk);
dataQpsk(:,2,:) = imag(sigQpsk);

% 8PSK
awgnSig8psk = awgn(sig8psk, snr(n));
sig8psk = reshape(sig8psk, spf, N_Frame);
data8psk(:,1,:) = real(sig8psk);
data8psk(:,2,:) = imag(sig8psk);

% 16QAM
awgnSig16qam = awgn(sig16qam, snr(n));
sig16qam = reshape(sig16qam, spf, N_Frame);
data16qam(:,1,:) = real(sig16qam);
data16qam(:,2,:) = imag(sig16qam);

% 32QAM
awgnSig32qam = awgn(sig32qam, snr(n));
sig32qam = reshape(sig32qam, spf, N_Frame);
data32qam(:,1,:) = real(sig32qam);
data32qam(:,2,:) = imag(sig32qam);

% 64QAM
awgnSig64qam = awgn(sig64qam, snr(n));
sig64qam = reshape(sig64qam, spf, N_Frame);
data64qam(:,1,:) = real(sig64qam);
data64qam(:,2,:) = imag(sig64qam);

% 4PAM
awgnSig4pam = awgn(sig4pam, snr(n));
sig4pam = reshape(sig4pam, spf, N_Frame);
data4pam(:,1,:) = real(sig4pam);
data4pam(:,2,:) = imag(sig4pam);

% 8PAM
awgnSig8pam = awgn(sig8pam, snr(n));
sig8pam = reshape(sig8pam, spf, N_Frame);
data8pam(:,1,:) = real(sig8pam);
data8pam(:,2,:) = imag(sig8pam);

% Total Training Set
trainingData(:,:,1:N_Frame*trainDataRatio) = dataBpsk(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio+1:N_Frame*trainDataRatio*2) = dataQpsk(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*2+1:N_Frame*trainDataRatio*3) = data8psk(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*3+1:N_Frame*trainDataRatio*4) = data16qam(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*4+1:N_Frame*trainDataRatio*5) = data32qam(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*5+1:N_Frame*trainDataRatio*6) = data64qam(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*6+1:N_Frame*trainDataRatio*7) = data4pam(:,:,1:N_Frame*trainDataRatio);
trainingData(:,:,N_Frame*trainDataRatio*7+1:N_Frame*trainDataRatio*8) = data8pam(:,:,1:N_Frame*trainDataRatio);

validationData(:,:,1:N_Frame*validDataRatio) = dataBpsk(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*validDataRatio+1:N_Frame*validDataRatio*2) = dataQpsk(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*validDataRatio*2+1:N_Frame*validDataRatio*3) = data8psk(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*trainDataRatio*3+1:N_Frame*trainDataRatio*4) = data16qam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*trainDataRatio*4+1:N_Frame*trainDataRatio*5) = data32qam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*trainDataRatio*5+1:N_Frame*trainDataRatio*6) = data64qam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*trainDataRatio*6+1:N_Frame*trainDataRatio*7) = data4pam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);
validationData(:,:,N_Frame*trainDataRatio*7+1:N_Frame*trainDataRatio*8) = data8pam(:,:,1+N_Frame*trainDataRatio:N_Frame*trainDataRatio+N_Frame*validDataRatio);

% Labeling Training Set
for n = 1:N_Frame* trainDataRatio * numModTypes 
    rxTrainFrames(1,:,:,n) = trainingData(:,:,n);
    if n <=N_Frame* trainDataRatio
        rxTrainLabels(n) = modTypes(1);
    elseif n<=N_Frame* trainDataRatio *2
        rxTrainLabels(n) = modTypes(2);
    elseif n<=N_Frame* trainDataRatio *3
        rxTrainLabels(n) = modTypes(3);
    elseif n<=N_Frame* trainDataRatio *4
        rxTrainLabels(n) = modTypes(4);
    elseif n<=N_Frame* trainDataRatio *5
        rxTrainLabels(n) = modTypes(5);
    elseif n<=N_Frame* trainDataRatio *6
        rxTrainLabels(n) = modTypes(6);
    elseif n<=N_Frame* trainDataRatio *7
        rxTrainLabels(n) = modTypes(7);
    elseif n>N_Frame* trainDataRatio *7
        rxTrainLabels(n) = modTypes(8);
    end
end

% Labeling Validation Set
for n = 1:N_Frame* validDataRatio * numModTypes 
    rxValidFrames(1,:,:,n) = trainingData(:,:,n);
    if n <=N_Frame* trainDataRatio
        rxValidLabels(n) = modTypes(1);
    elseif n<=N_Frame* trainDataRatio *2
        rxValidLabels(n) = modTypes(2);
    elseif n<=N_Frame* trainDataRatio *3
        rxValidLabels(n) = modTypes(3);
    elseif n<=N_Frame* trainDataRatio *4
        rxValidLabels(n) = modTypes(4);
    elseif n<=N_Frame* trainDataRatio *5
        rxValidLabels(n) = modTypes(5);
    elseif n<=N_Frame* trainDataRatio *6
        rxValidLabels(n) = modTypes(6);
    elseif n<=N_Frame* trainDataRatio *7
        rxValidLabels(n) = modTypes(7);
    elseif n>N_Frame* trainDataRatio *7
        rxValidLabels(n) = modTypes(8);
    end
end

lgraph = layerGraph();

tempLayers = [
    imageInputLayer([1 512 2],"Name","imageinput")
    convolution2dLayer([2 31],32,"Name","conv_1","Padding","same")
    batchNormalizationLayer("Name","bn_conv1_1","Epsilon",0.001)
    reluLayer("Name","activation_1_relu_1")
    convolution2dLayer([2 15],48,"Name","conv_2","Padding","same")
    batchNormalizationLayer("Name","bn_conv1_2","Epsilon",0.001)
    reluLayer("Name","activation_1_relu_2")
    convolution2dLayer([2 7],64,"Name","conv_3","Padding","same")
    batchNormalizationLayer("Name","bn_conv1_3","Epsilon",0.001)
    reluLayer("Name","activation_1_relu_3")
    convolution2dLayer([2 1],64,"Name","conv_42","Padding","same")
    batchNormalizationLayer("Name","bn_conv1_4","Epsilon",0.001)
    reluLayer("Name","activation_1_relu_4")
    maxPooling2dLayer([3 1],"Name","max_pooling2d_1","Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],64,"Name","res2a_branch2a_1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_1","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_1")
    convolution2dLayer([3 3],64,"Name","res2a_branch2b_1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_1","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_1")
    convolution2dLayer([1 1],128,"Name","conv_4","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_1","Epsilon",0.001)
    reluLayer("Name","activation_4_relu_1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],64,"Name","res2a_branch2a_2","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_2","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_2")
    convolution2dLayer([3 3],64,"Name","res2a_branch2b_2","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_2","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_2")
    convolution2dLayer([1 1],128,"Name","conv_5","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_2","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_2")
    reluLayer("Name","activation_4_relu_2")
    convolution2dLayer([1 1],128,"Name","conv_13","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_3","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_3")
    convolution2dLayer([3 3],128,"Name","conv_14","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_3","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_3")
    convolution2dLayer([1 1],256,"Name","conv_6","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_3","Epsilon",0.001)
    reluLayer("Name","activation_4_relu_3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","conv_15","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_4","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_4")
    convolution2dLayer([3 3],128,"Name","conv_16","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_4","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_4")
    convolution2dLayer([1 1],256,"Name","conv_7","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_4","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_4")
    reluLayer("Name","activation_4_relu_4")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","conv_18","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_5","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_5")
    convolution2dLayer([3 3],128,"Name","conv_17","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_5","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_5")
    convolution2dLayer([1 1],256,"Name","conv_8","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_5","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_5")
    reluLayer("Name","activation_4_relu_5")
    convolution2dLayer([1 1],128,"Name","conv_19","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_6","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_6")
    convolution2dLayer([3 3],128,"Name","conv_20","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_6","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_6")
    convolution2dLayer([1 1],256,"Name","conv_9","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_6","Epsilon",0.001)
    reluLayer("Name","activation_4_relu_6")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","conv_22","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_7","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_7")
    convolution2dLayer([3 3],128,"Name","conv_21","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_7","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_7")
    convolution2dLayer([1 1],256,"Name","conv_10","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_7","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_7")
    reluLayer("Name","activation_4_relu_7")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","conv_23","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_8","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_8")
    convolution2dLayer([3 3],128,"Name","conv_24","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_8","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_8")
    convolution2dLayer([1 1],256,"Name","conv_11","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_8","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_8")
    reluLayer("Name","activation_4_relu_8")
    convolution2dLayer([1 1],256,"Name","conv_26","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_9","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_9")
    convolution2dLayer([3 3],256,"Name","conv_25","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_9","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_9")
    convolution2dLayer([1 1],512,"Name","conv_12","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_9","Epsilon",0.001)
    reluLayer("Name","activation_4_relu_9")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],256,"Name","conv_29","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_10","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_10")
    convolution2dLayer([3 3],256,"Name","conv_28","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_10","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_10")
    convolution2dLayer([1 1],512,"Name","conv_27","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_10","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_10")
    reluLayer("Name","activation_4_relu_10")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],256,"Name","conv_32","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_11","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_11")
    convolution2dLayer([3 3],256,"Name","conv_31","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_11","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_11")
    convolution2dLayer([1 1],512,"Name","conv_30","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_11","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_11")
    reluLayer("Name","activation_4_relu_11")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],256,"Name","conv_35","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_12","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_12")
    convolution2dLayer([3 3],256,"Name","conv_34","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_12","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_12")
    convolution2dLayer([1 1],512,"Name","conv_33","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_12","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_12")
    reluLayer("Name","activation_4_relu_12")
    convolution2dLayer([1 1],512,"Name","conv_38","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_13","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_13")
    convolution2dLayer([3 3],512,"Name","conv_37","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_13","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_13")
    convolution2dLayer([1 1],1024,"Name","conv_36","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_13","Epsilon",0.001)
    reluLayer("Name","activation_4_relu_13")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],512,"Name","conv_41","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2a_14","Epsilon",0.001)
    reluLayer("Name","activation_2_relu_14")
    convolution2dLayer([3 3],512,"Name","conv_40","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b_14","Epsilon",0.001)
    reluLayer("Name","activation_3_relu_14")
    convolution2dLayer([1 1],1024,"Name","conv_39","Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2c_14","Epsilon",0.001)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","add_14")
    reluLayer("Name","activation_4_relu_14")
    averagePooling2dLayer([1 7],"Name","avgpool2d","Padding","same")
    fullyConnectedLayer(8,"Name","fc")
    softmaxLayer("Name","fc_softmax")
    classificationLayer("Name","classoutput")];
lgraph = addLayers(lgraph,tempLayers);

% 헬퍼 변수 정리
clear tempLayers;

lgraph = connectLayers(lgraph,"activation_4_relu_1","res2a_branch2a_2");
lgraph = connectLayers(lgraph,"activation_4_relu_1","add_2/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_2","add_2/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_3","conv_15");
lgraph = connectLayers(lgraph,"activation_4_relu_3","add_4/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_4","add_4/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_4","conv_18");
lgraph = connectLayers(lgraph,"activation_4_relu_4","add_5/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_5","add_5/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_6","conv_22");
lgraph = connectLayers(lgraph,"activation_4_relu_6","add_7/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_7","add_7/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_7","conv_23");
lgraph = connectLayers(lgraph,"activation_4_relu_7","add_8/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_8","add_8/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_9","conv_29");
lgraph = connectLayers(lgraph,"activation_4_relu_9","add_10/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_10","add_10/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_10","conv_32");
lgraph = connectLayers(lgraph,"activation_4_relu_10","add_11/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_11","add_11/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_11","conv_35");
lgraph = connectLayers(lgraph,"activation_4_relu_11","add_12/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_12","add_12/in1");
lgraph = connectLayers(lgraph,"activation_4_relu_13","conv_41");
lgraph = connectLayers(lgraph,"activation_4_relu_13","add_14/in2");
lgraph = connectLayers(lgraph,"bn2a_branch2c_14","add_14/in1");

maxEpochs           = 20;
miniBatchSize       = 128;
validationFrequency = 1500;

options = trainingOptions('sgdm', ...
      'InitialLearnRate',2e-2, ...
      'MaxEpochs',maxEpochs, ...
      'MiniBatchSize',miniBatchSize, ...
      'Shuffle','every-epoch', ...
      'Plots','training-progress', ...
      'Verbose',false, ...
      'ValidationData',{rxValidFrames,rxValidLabels}, ...
      'ValidationFrequency',validationFrequency, ...
      'LearnRateSchedule', 'piecewise', ...
      'LearnRateDropPeriod', 9, ...
      'LearnRateDropFactor', 0.1);

trainedNet      = trainNetwork(rxTrainFrames,rxTrainLabels,lgraph,options);
end