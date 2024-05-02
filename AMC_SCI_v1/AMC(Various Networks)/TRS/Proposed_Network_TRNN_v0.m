clc; close all; clear;

lgraph = layerGraph();

tempLayers = [
    imageInputLayer([1 512 2],"Name","imageinput")
    convolution2dLayer([1 1],32,"Name","conv_1","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([2 3],32,"Name","conv_2","Padding","same")
    reluLayer("Name","relu_2")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_1");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([2 3],32,"Name","conv_4","Padding","same")
    reluLayer("Name","relu_3")
    convolution2dLayer([2 3],32,"Name","conv_5","Padding","same")
    reluLayer("Name","relu_4")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_2");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([2 3],32,"Name","conv_3","Padding","same")
    reluLayer("Name","relu_5")
    convolution2dLayer([2 3],32,"Name","conv_6","Padding","same")
    reluLayer("Name","relu_6")
    convolution2dLayer([2 3],32,"Name","conv_7","Padding","same")
    reluLayer("Name","relu_7")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_3");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_4")
    maxPooling2dLayer([2 2],"Name","maxpool_1","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_8","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_8")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_9","Padding","same")
    reluLayer("Name","relu_9")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_5");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_11","Padding","same")
    reluLayer("Name","relu_10")
    convolution2dLayer([1 3],32,"Name","conv_12","Padding","same")
    reluLayer("Name","relu_11")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_6");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_10","Padding","same")
    reluLayer("Name","relu_12")
    convolution2dLayer([1 3],32,"Name","conv_13","Padding","same")
    reluLayer("Name","relu_13")
    convolution2dLayer([1 3],32,"Name","conv_14","Padding","same")
    reluLayer("Name","relu_14")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_7");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_8")
    maxPooling2dLayer([1 2],"Name","maxpool_2","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_15","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_15")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_16","Padding","same")
    reluLayer("Name","relu_16")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_9");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_18","Padding","same")
    reluLayer("Name","relu_17")
    convolution2dLayer([1 3],32,"Name","conv_19","Padding","same")
    reluLayer("Name","relu_18")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_10");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_17","Padding","same")
    reluLayer("Name","relu_19")
    convolution2dLayer([1 3],32,"Name","conv_20","Padding","same")
    reluLayer("Name","relu_20")
    convolution2dLayer([1 3],32,"Name","conv_21","Padding","same")
    reluLayer("Name","relu_21")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_11");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_12")
    maxPooling2dLayer([1 2],"Name","maxpool_3","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_22","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_22")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_23","Padding","same")
    reluLayer("Name","relu_23")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_13");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_25","Padding","same")
    reluLayer("Name","relu_24")
    convolution2dLayer([1 3],32,"Name","conv_26","Padding","same")
    reluLayer("Name","relu_25")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_14");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_24","Padding","same")
    reluLayer("Name","relu_26")
    convolution2dLayer([1 3],32,"Name","conv_27","Padding","same")
    reluLayer("Name","relu_27")
    convolution2dLayer([1 3],32,"Name","conv_28","Padding","same")
    reluLayer("Name","relu_28")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_15");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_16")
    maxPooling2dLayer([1 2],"Name","maxpool_4","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_29","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_29")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_30","Padding","same")
    reluLayer("Name","relu_30")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_17");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_32","Padding","same")
    reluLayer("Name","relu_31")
    convolution2dLayer([1 3],32,"Name","conv_33","Padding","same")
    reluLayer("Name","relu_32")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_18");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_31","Padding","same")
    reluLayer("Name","relu_33")
    convolution2dLayer([1 3],32,"Name","conv_34","Padding","same")
    reluLayer("Name","relu_34")
    convolution2dLayer([1 3],32,"Name","conv_35","Padding","same")
    reluLayer("Name","relu_35")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_19");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_20")
    maxPooling2dLayer([1 2],"Name","maxpool_5","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_36","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_36")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_37","Padding","same")
    reluLayer("Name","relu_37")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_21");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_39","Padding","same")
    reluLayer("Name","relu_38")
    convolution2dLayer([1 3],32,"Name","conv_40","Padding","same")
    reluLayer("Name","relu_39")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_22");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_38","Padding","same")
    reluLayer("Name","relu_40")
    convolution2dLayer([1 3],32,"Name","conv_41","Padding","same")
    reluLayer("Name","relu_41")
    convolution2dLayer([1 3],32,"Name","conv_42","Padding","same")
    reluLayer("Name","relu_42")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_23");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_24")
    maxPooling2dLayer([1 2],"Name","maxpool_6","Padding","same")
    convolution2dLayer([1 1],32,"Name","conv_43","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_43")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_44","Padding","same")
    reluLayer("Name","relu_44")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_25");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_46","Padding","same")
    reluLayer("Name","relu_45")
    convolution2dLayer([1 3],32,"Name","conv_47","Padding","same")
    reluLayer("Name","relu_46")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_26");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 3],32,"Name","conv_45","Padding","same")
    reluLayer("Name","relu_47")
    convolution2dLayer([1 3],32,"Name","conv_48","Padding","same")
    reluLayer("Name","relu_48")
    convolution2dLayer([1 3],32,"Name","conv_49","Padding","same")
    reluLayer("Name","relu_49")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = additionLayer(2,"Name","addition_27");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_28")
    maxPooling2dLayer([1 2],"Name","maxpool_7","Padding","same")
    fullyConnectedLayer(64,"Name","fc_1")
    eluLayer(1,"Name","elu")
    fullyConnectedLayer(4,"Name","fc_2")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
lgraph = addLayers(lgraph,tempLayers);

% 헬퍼 변수 정리
clear tempLayers;

lgraph = connectLayers(lgraph,"relu_1","conv_2");
lgraph = connectLayers(lgraph,"relu_1","addition_1/in2");
lgraph = connectLayers(lgraph,"relu_1","addition_4/in2");
lgraph = connectLayers(lgraph,"relu_2","addition_1/in1");
lgraph = connectLayers(lgraph,"addition_1","conv_4");
lgraph = connectLayers(lgraph,"addition_1","addition_2/in2");
lgraph = connectLayers(lgraph,"relu_4","addition_2/in1");
lgraph = connectLayers(lgraph,"addition_2","conv_3");
lgraph = connectLayers(lgraph,"addition_2","addition_3/in2");
lgraph = connectLayers(lgraph,"relu_7","addition_3/in1");
lgraph = connectLayers(lgraph,"addition_3","addition_4/in1");
lgraph = connectLayers(lgraph,"relu_8","conv_9");
lgraph = connectLayers(lgraph,"relu_8","addition_5/in2");
lgraph = connectLayers(lgraph,"relu_8","addition_8/in2");
lgraph = connectLayers(lgraph,"relu_9","addition_5/in1");
lgraph = connectLayers(lgraph,"addition_5","conv_11");
lgraph = connectLayers(lgraph,"addition_5","addition_6/in2");
lgraph = connectLayers(lgraph,"relu_11","addition_6/in1");
lgraph = connectLayers(lgraph,"addition_6","conv_10");
lgraph = connectLayers(lgraph,"addition_6","addition_7/in2");
lgraph = connectLayers(lgraph,"relu_14","addition_7/in1");
lgraph = connectLayers(lgraph,"addition_7","addition_8/in1");
lgraph = connectLayers(lgraph,"relu_15","conv_16");
lgraph = connectLayers(lgraph,"relu_15","addition_9/in2");
lgraph = connectLayers(lgraph,"relu_15","addition_12/in2");
lgraph = connectLayers(lgraph,"relu_16","addition_9/in1");
lgraph = connectLayers(lgraph,"addition_9","conv_18");
lgraph = connectLayers(lgraph,"addition_9","addition_10/in2");
lgraph = connectLayers(lgraph,"relu_18","addition_10/in1");
lgraph = connectLayers(lgraph,"addition_10","conv_17");
lgraph = connectLayers(lgraph,"addition_10","addition_11/in2");
lgraph = connectLayers(lgraph,"relu_21","addition_11/in1");
lgraph = connectLayers(lgraph,"addition_11","addition_12/in1");
lgraph = connectLayers(lgraph,"relu_22","conv_23");
lgraph = connectLayers(lgraph,"relu_22","addition_13/in2");
lgraph = connectLayers(lgraph,"relu_22","addition_16/in2");
lgraph = connectLayers(lgraph,"relu_23","addition_13/in1");
lgraph = connectLayers(lgraph,"addition_13","conv_25");
lgraph = connectLayers(lgraph,"addition_13","addition_14/in2");
lgraph = connectLayers(lgraph,"relu_25","addition_14/in1");
lgraph = connectLayers(lgraph,"addition_14","conv_24");
lgraph = connectLayers(lgraph,"addition_14","addition_15/in2");
lgraph = connectLayers(lgraph,"relu_28","addition_15/in1");
lgraph = connectLayers(lgraph,"addition_15","addition_16/in1");
lgraph = connectLayers(lgraph,"relu_29","conv_30");
lgraph = connectLayers(lgraph,"relu_29","addition_17/in2");
lgraph = connectLayers(lgraph,"relu_29","addition_20/in2");
lgraph = connectLayers(lgraph,"relu_30","addition_17/in1");
lgraph = connectLayers(lgraph,"addition_17","conv_32");
lgraph = connectLayers(lgraph,"addition_17","addition_18/in2");
lgraph = connectLayers(lgraph,"relu_32","addition_18/in1");
lgraph = connectLayers(lgraph,"addition_18","conv_31");
lgraph = connectLayers(lgraph,"addition_18","addition_19/in2");
lgraph = connectLayers(lgraph,"relu_35","addition_19/in1");
lgraph = connectLayers(lgraph,"addition_19","addition_20/in1");
lgraph = connectLayers(lgraph,"relu_36","conv_37");
lgraph = connectLayers(lgraph,"relu_36","addition_21/in2");
lgraph = connectLayers(lgraph,"relu_36","addition_24/in2");
lgraph = connectLayers(lgraph,"relu_37","addition_21/in1");
lgraph = connectLayers(lgraph,"addition_21","conv_39");
lgraph = connectLayers(lgraph,"addition_21","addition_22/in2");
lgraph = connectLayers(lgraph,"relu_39","addition_22/in1");
lgraph = connectLayers(lgraph,"addition_22","conv_38");
lgraph = connectLayers(lgraph,"addition_22","addition_23/in2");
lgraph = connectLayers(lgraph,"relu_42","addition_23/in1");
lgraph = connectLayers(lgraph,"addition_23","addition_24/in1");
lgraph = connectLayers(lgraph,"relu_43","conv_44");
lgraph = connectLayers(lgraph,"relu_43","addition_25/in2");
lgraph = connectLayers(lgraph,"relu_43","addition_28/in2");
lgraph = connectLayers(lgraph,"relu_44","addition_25/in1");
lgraph = connectLayers(lgraph,"addition_25","conv_46");
lgraph = connectLayers(lgraph,"addition_25","addition_26/in2");
lgraph = connectLayers(lgraph,"relu_46","addition_26/in1");
lgraph = connectLayers(lgraph,"addition_26","conv_45");
lgraph = connectLayers(lgraph,"addition_26","addition_27/in2");
lgraph = connectLayers(lgraph,"relu_49","addition_27/in1");
lgraph = connectLayers(lgraph,"addition_27","addition_28/in1");

plot(lgraph);

analyzeNetwork(lgraph);