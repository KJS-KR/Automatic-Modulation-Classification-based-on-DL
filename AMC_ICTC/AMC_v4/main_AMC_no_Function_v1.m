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

numModTypes = length(modTypes);

% QPSK
Nsyms    = N_train * N_frame; modNum = 4;
randsyms = randi([0 modNum-1], Nsyms, 1);
qpskSig  = pskmod(randsyms, modNum, pi/4);
qpskSig  = reshape(qpskSig,N_frame,N_train);
qpskSig_real(:,1,:) = real(qpskSig);
qpskSig_real(:,2,:) = imag(qpskSig);

% 8PSK
Nsyms    = N_train * N_frame; modNum = 8;
randsyms = randi([0 modNum-1], Nsyms, 1);
epskSig  = pskmod(randsyms, modNum);
size(epskSig)
epskSig  = reshape(epskSig,N_frame,N_train);
epskSig_real(:,1,:) = real(epskSig);
epskSig_real(:,2,:) = imag(epskSig);

% total training set
data_tr(:,:,1:N_train) = qpskSig_real;
data_tr(:,:,N_train+1:N_train*numModTypes) = epskSig_real;

%% training set & validation set
for n = 1:N_train * numModTypes 
    rxTrainFrames(1,:,:,n) = data_tr(:,:,n);
    if n <=N_train
        rxTrainLabels(n) = modTypes(1);
    elseif n>N_train
        rxTrainLabels(n) = modTypes(2);
    end
end
