function output = tripleResNet(spf, modTypeNum)

    network = layerGraph();
    
    tempLayers = [
        imageInputLayer([1 spf 2],"Name","imageinput","Normalization","none")
        convolution2dLayer([2 3],32,"Name","conv_1","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_1")
        reluLayer("Name","relu_1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([2 3],32,"Name","conv_2","Padding","same")
        batchNormalizationLayer("Name","batchnorm_2")
        reluLayer("Name","relu_2")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_1");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([2 3],32,"Name","conv_3","Padding","same")
        batchNormalizationLayer("Name","batchnorm_3")
        reluLayer("Name","relu_3")
        convolution2dLayer([2 3],32,"Name","conv_4","Padding","same")
        batchNormalizationLayer("Name","batchnorm_4")
        reluLayer("Name","relu_4")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_2");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([2 3],32,"Name","conv_5","Padding","same")
        batchNormalizationLayer("Name","batchnorm_5")
        reluLayer("Name","relu_5")
        convolution2dLayer([2 3],32,"Name","conv_6","Padding","same")
        batchNormalizationLayer("Name","batchnorm_6")
        reluLayer("Name","relu_6")
        convolution2dLayer([3 3],32,"Name","conv_7","Padding","same")
        batchNormalizationLayer("Name","batchnorm_7")
        reluLayer("Name","relu_7")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_3");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_4")
        maxPooling2dLayer([2 2],"Name","maxpool_1","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_8","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_8")
        reluLayer("Name","relu_8")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_9","Padding","same")
        batchNormalizationLayer("Name","batchnorm_9")
        reluLayer("Name","relu_9")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_5");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_10","Padding","same")
        batchNormalizationLayer("Name","batchnorm_10")
        reluLayer("Name","relu_10")
        convolution2dLayer([1 3],32,"Name","conv_11","Padding","same")
        batchNormalizationLayer("Name","batchnorm_11")
        reluLayer("Name","relu_11")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_6");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_12","Padding","same")
        batchNormalizationLayer("Name","batchnorm_12")
        reluLayer("Name","relu_12")
        convolution2dLayer([1 3],32,"Name","conv_13","Padding","same")
        batchNormalizationLayer("Name","batchnorm_13")
        reluLayer("Name","relu_13")
        convolution2dLayer([1 3],32,"Name","conv_14","Padding","same")
        batchNormalizationLayer("Name","batchnorm_14")
        reluLayer("Name","relu_14")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_7");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_8")
        maxPooling2dLayer([1 2],"Name","maxpool_2","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_15","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_15")
        reluLayer("Name","relu_15")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_16","Padding","same")
        batchNormalizationLayer("Name","batchnorm_16")
        reluLayer("Name","relu_16")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_9");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_17","Padding","same")
        batchNormalizationLayer("Name","batchnorm_17")
        reluLayer("Name","relu_17")
        convolution2dLayer([1 3],32,"Name","conv_18","Padding","same")
        batchNormalizationLayer("Name","batchnorm_18")
        reluLayer("Name","relu_18")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_10");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_19","Padding","same")
        batchNormalizationLayer("Name","batchnorm_19")
        reluLayer("Name","relu_19")
        convolution2dLayer([1 3],32,"Name","conv_20","Padding","same")
        batchNormalizationLayer("Name","batchnorm_20")
        reluLayer("Name","relu_20")
        convolution2dLayer([1 3],32,"Name","conv_21","Padding","same")
        batchNormalizationLayer("Name","batchnorm_21")
        reluLayer("Name","relu_21")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_11");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_12")
        maxPooling2dLayer([1 2],"Name","maxpool_3","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_22","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_22")
        reluLayer("Name","relu_22")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_23","Padding","same")
        batchNormalizationLayer("Name","batchnorm_23")
        reluLayer("Name","relu_23")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_13");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_24","Padding","same")
        batchNormalizationLayer("Name","batchnorm_24")
        reluLayer("Name","relu_24")
        convolution2dLayer([1 3],32,"Name","conv_25","Padding","same")
        batchNormalizationLayer("Name","batchnorm_25")
        reluLayer("Name","relu_25")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_14");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_26","Padding","same")
        batchNormalizationLayer("Name","batchnorm_26")
        reluLayer("Name","relu_26")
        convolution2dLayer([1 3],32,"Name","conv_27","Padding","same")
        batchNormalizationLayer("Name","batchnorm_27")
        reluLayer("Name","relu_27")
        convolution2dLayer([1 3],32,"Name","conv_28","Padding","same")
        batchNormalizationLayer("Name","batchnorm_28")
        reluLayer("Name","relu_28")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_15");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_16")
        maxPooling2dLayer([1 2],"Name","maxpool_4","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_29","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_29")
        reluLayer("Name","relu_29")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_30","Padding","same")
        batchNormalizationLayer("Name","batchnorm_30")
        reluLayer("Name","relu_30")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_17");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_31","Padding","same")
        batchNormalizationLayer("Name","batchnorm_31")
        reluLayer("Name","relu_31")
        convolution2dLayer([1 3],32,"Name","conv_32","Padding","same")
        batchNormalizationLayer("Name","batchnorm_32")
        reluLayer("Name","relu_32")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_18");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_33","Padding","same")
        batchNormalizationLayer("Name","batchnorm_33")
        reluLayer("Name","relu_33")
        convolution2dLayer([1 3],32,"Name","conv_34","Padding","same")
        batchNormalizationLayer("Name","batchnorm_34")
        reluLayer("Name","relu_34")
        convolution2dLayer([1 3],32,"Name","conv_35","Padding","same")
        batchNormalizationLayer("Name","batchnorm_35")
        reluLayer("Name","relu_35")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_19");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_20")
        maxPooling2dLayer([1 2],"Name","maxpool_5","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_36","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_36")
        reluLayer("Name","relu_36")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_37","Padding","same")
        batchNormalizationLayer("Name","batchnorm_37")
        reluLayer("Name","relu_37")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_21");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_38","Padding","same")
        batchNormalizationLayer("Name","batchnorm_38")
        reluLayer("Name","relu_38")
        convolution2dLayer([1 3],32,"Name","conv_39","Padding","same")
        batchNormalizationLayer("Name","batchnorm_39")
        reluLayer("Name","relu_39")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_22");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_40","Padding","same")
        batchNormalizationLayer("Name","batchnorm_40")
        reluLayer("Name","relu_40")
        convolution2dLayer([1 3],32,"Name","conv_41","Padding","same")
        batchNormalizationLayer("Name","batchnorm_41")
        reluLayer("Name","relu_41")
        convolution2dLayer([1 3],32,"Name","conv_42","Padding","same")
        batchNormalizationLayer("Name","batchnorm_42")
        reluLayer("Name","relu_42")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_23");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_24")
        maxPooling2dLayer([1 2],"Name","maxpool_6","Padding","same")
        convolution2dLayer([1 3],32,"Name","conv_43","Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","batchnorm_43")
        reluLayer("Name","relu_43")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_44","Padding","same")
        batchNormalizationLayer("Name","batchnorm_44")
        reluLayer("Name","relu_44")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_25");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_45","Padding","same")
        batchNormalizationLayer("Name","batchnorm_45")
        reluLayer("Name","relu_45")
        convolution2dLayer([1 3],32,"Name","conv_46","Padding","same")
        batchNormalizationLayer("Name","batchnorm_46")
        reluLayer("Name","relu_46")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_26");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 3],32,"Name","conv_47","Padding","same")
        batchNormalizationLayer("Name","batchnorm_47")
        reluLayer("Name","relu_47")
        convolution2dLayer([1 3],32,"Name","conv_48","Padding","same")
        batchNormalizationLayer("Name","batchnorm_48")
        reluLayer("Name","relu_48")
        convolution2dLayer([1 3],32,"Name","conv_49","Padding","same")
        batchNormalizationLayer("Name","batchnorm_49")
        reluLayer("Name","relu_49")];
    network = addLayers(network,tempLayers);
    
    tempLayers = additionLayer(2,"Name","addition_27");
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","addition_28")
        maxPooling2dLayer([1 2],"Name","maxpool_7","Padding","same")
        fullyConnectedLayer(128,"Name","fc_1")
        eluLayer(1,"Name","elu")
        fullyConnectedLayer(modTypeNum,"Name","fc_2")
        softmaxLayer("Name","softmax")
        classificationLayer("Name","classoutput")];
    network = addLayers(network,tempLayers);
    
    % 헬퍼 변수 정리
    clear tempLayers;
    
    network = connectLayers(network,"relu_1","conv_2");
    network = connectLayers(network,"relu_1","addition_1/in2");
    network = connectLayers(network,"relu_1","addition_4/in1");
    network = connectLayers(network,"relu_2","addition_1/in1");
    network = connectLayers(network,"addition_1","conv_3");
    network = connectLayers(network,"addition_1","addition_2/in2");
    network = connectLayers(network,"relu_4","addition_2/in1");
    network = connectLayers(network,"addition_2","conv_5");
    network = connectLayers(network,"addition_2","addition_3/in1");
    network = connectLayers(network,"relu_7","addition_3/in2");
    network = connectLayers(network,"addition_3","addition_4/in2");
    network = connectLayers(network,"relu_8","conv_9");
    network = connectLayers(network,"relu_8","addition_5/in2");
    network = connectLayers(network,"relu_8","addition_8/in1");
    network = connectLayers(network,"relu_9","addition_5/in1");
    network = connectLayers(network,"addition_5","conv_10");
    network = connectLayers(network,"addition_5","addition_6/in2");
    network = connectLayers(network,"relu_11","addition_6/in1");
    network = connectLayers(network,"addition_6","conv_12");
    network = connectLayers(network,"addition_6","addition_7/in1");
    network = connectLayers(network,"relu_14","addition_7/in2");
    network = connectLayers(network,"addition_7","addition_8/in2");
    network = connectLayers(network,"relu_15","conv_16");
    network = connectLayers(network,"relu_15","addition_9/in2");
    network = connectLayers(network,"relu_15","addition_12/in1");
    network = connectLayers(network,"relu_16","addition_9/in1");
    network = connectLayers(network,"addition_9","conv_17");
    network = connectLayers(network,"addition_9","addition_10/in2");
    network = connectLayers(network,"relu_18","addition_10/in1");
    network = connectLayers(network,"addition_10","conv_19");
    network = connectLayers(network,"addition_10","addition_11/in1");
    network = connectLayers(network,"relu_21","addition_11/in2");
    network = connectLayers(network,"addition_11","addition_12/in2");
    network = connectLayers(network,"relu_22","conv_23");
    network = connectLayers(network,"relu_22","addition_13/in2");
    network = connectLayers(network,"relu_22","addition_16/in1");
    network = connectLayers(network,"relu_23","addition_13/in1");
    network = connectLayers(network,"addition_13","conv_24");
    network = connectLayers(network,"addition_13","addition_14/in2");
    network = connectLayers(network,"relu_25","addition_14/in1");
    network = connectLayers(network,"addition_14","conv_26");
    network = connectLayers(network,"addition_14","addition_15/in1");
    network = connectLayers(network,"relu_28","addition_15/in2");
    network = connectLayers(network,"addition_15","addition_16/in2");
    network = connectLayers(network,"relu_29","conv_30");
    network = connectLayers(network,"relu_29","addition_17/in2");
    network = connectLayers(network,"relu_29","addition_20/in1");
    network = connectLayers(network,"relu_30","addition_17/in1");
    network = connectLayers(network,"addition_17","conv_31");
    network = connectLayers(network,"addition_17","addition_18/in2");
    network = connectLayers(network,"relu_32","addition_18/in1");
    network = connectLayers(network,"addition_18","conv_33");
    network = connectLayers(network,"addition_18","addition_19/in1");
    network = connectLayers(network,"relu_35","addition_19/in2");
    network = connectLayers(network,"addition_19","addition_20/in2");
    network = connectLayers(network,"relu_36","conv_37");
    network = connectLayers(network,"relu_36","addition_21/in2");
    network = connectLayers(network,"relu_36","addition_24/in1");
    network = connectLayers(network,"relu_37","addition_21/in1");
    network = connectLayers(network,"addition_21","conv_38");
    network = connectLayers(network,"addition_21","addition_22/in2");
    network = connectLayers(network,"relu_39","addition_22/in1");
    network = connectLayers(network,"addition_22","conv_40");
    network = connectLayers(network,"addition_22","addition_23/in1");
    network = connectLayers(network,"relu_42","addition_23/in2");
    network = connectLayers(network,"addition_23","addition_24/in2");
    network = connectLayers(network,"relu_43","conv_44");
    network = connectLayers(network,"relu_43","addition_25/in2");
    network = connectLayers(network,"relu_43","addition_28/in1");
    network = connectLayers(network,"relu_44","addition_25/in1");
    network = connectLayers(network,"addition_25","conv_45");
    network = connectLayers(network,"addition_25","addition_26/in2");
    network = connectLayers(network,"relu_46","addition_26/in1");
    network = connectLayers(network,"addition_26","conv_47");
    network = connectLayers(network,"addition_26","addition_27/in1");
    network = connectLayers(network,"relu_49","addition_27/in2");
    network = connectLayers(network,"addition_27","addition_28/in2");

    output = network;
end

