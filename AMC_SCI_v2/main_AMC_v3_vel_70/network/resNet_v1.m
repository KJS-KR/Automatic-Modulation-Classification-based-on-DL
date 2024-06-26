clc; close all; clear;

resNet = layerGraph();

tempLayers = [
    imageInputLayer([1 512 2],"Name","data","Normalization","zscore")
    convolution2dLayer([7 7],32,"Name","conv1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn_conv1")
    reluLayer("Name","conv1_relu")
    maxPooling2dLayer([3 3],"Name","pool1","Padding","same")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res2a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn2a_branch2a")
    reluLayer("Name","res2a_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res2a_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2a_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res2a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn2a_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res2a")
    reluLayer("Name","res2a_relu")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res2b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn2b_branch2a")
    reluLayer("Name","res2b_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res2b_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn2b_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res2b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn2b_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res2b")
    reluLayer("Name","res2b_relu")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res3a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn3a_branch2a")
    reluLayer("Name","res3a_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res3a_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn3a_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res3a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn3a_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res3a")
    reluLayer("Name","res3a_relu")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res3b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn3b_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res3b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn3b_branch2a")
    reluLayer("Name","res3b_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res3b_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn3b_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res3b")
    reluLayer("Name","res3b_relu")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res4a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn4a_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res4a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn4a_branch2a")
    reluLayer("Name","res4a_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res4a_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn4a_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res4a")
    reluLayer("Name","res4a_relu")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],32,"Name","res4b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","bn4b_branch1")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],32,"Name","res4b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    batchNormalizationLayer("Name","bn4b_branch2a")
    reluLayer("Name","res4b_branch2a_relu")
    convolution2dLayer([3 3],32,"Name","res4b_branch2b","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","bn4b_branch2b")];
resNet = addLayers(resNet,tempLayers);

tempLayers = [
    additionLayer(2,"Name","res4b")
    reluLayer("Name","res4b_relu")
    globalAveragePooling2dLayer("Name","gapool")
    fullyConnectedLayer(4,"Name","fc")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
resNet = addLayers(resNet,tempLayers);

% 헬퍼 변수 정리
clear tempLayers;

resNet = connectLayers(resNet,"pool1","res2a_branch2a");
resNet = connectLayers(resNet,"pool1","res2a_branch1");
resNet = connectLayers(resNet,"bn2a_branch2b","res2a/in1");
resNet = connectLayers(resNet,"bn2a_branch1","res2a/in2");
resNet = connectLayers(resNet,"res2a_relu","res2b_branch2a");
resNet = connectLayers(resNet,"res2a_relu","res2b_branch1");
resNet = connectLayers(resNet,"bn2b_branch1","res2b/in2");
resNet = connectLayers(resNet,"bn2b_branch2b","res2b/in1");
resNet = connectLayers(resNet,"res2b_relu","res3a_branch2a");
resNet = connectLayers(resNet,"res2b_relu","res3a_branch1");
resNet = connectLayers(resNet,"bn3a_branch1","res3a/in2");
resNet = connectLayers(resNet,"bn3a_branch2b","res3a/in1");
resNet = connectLayers(resNet,"res3a_relu","res3b_branch1");
resNet = connectLayers(resNet,"res3a_relu","res3b_branch2a");
resNet = connectLayers(resNet,"bn3b_branch1","res3b/in2");
resNet = connectLayers(resNet,"bn3b_branch2b","res3b/in1");
resNet = connectLayers(resNet,"res3b_relu","res4a_branch1");
resNet = connectLayers(resNet,"res3b_relu","res4a_branch2a");
resNet = connectLayers(resNet,"bn4a_branch1","res4a/in2");
resNet = connectLayers(resNet,"bn4a_branch2b","res4a/in1");
resNet = connectLayers(resNet,"res4a_relu","res4b_branch1");
resNet = connectLayers(resNet,"res4a_relu","res4b_branch2a");
resNet = connectLayers(resNet,"bn4b_branch1","res4b/in2");
resNet = connectLayers(resNet,"bn4b_branch2b","res4b/in1");

analyzeNetwork(resNet);