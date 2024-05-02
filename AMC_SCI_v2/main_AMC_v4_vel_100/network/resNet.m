function output = resNet(spf, modTypeNum)

    network = layerGraph();

    tempLayers = [
        imageInputLayer([1 spf 2],"Name","data","Normalization","zscore")
        convolution2dLayer([7 7],32,"Name","conv1","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn_conv1")
        reluLayer("Name","conv1_relu")
        maxPooling2dLayer([3 3],"Name","pool1","Padding","same")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res2a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn2a_branch2a")
        reluLayer("Name","res2a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res2a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn2a_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res2a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn2a_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res2a")
        reluLayer("Name","res2a_relu")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res2b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn2b_branch2a")
        reluLayer("Name","res2b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res2b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn2b_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res2b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn2b_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res2b")
        reluLayer("Name","res2b_relu")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res3a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch2a")
        reluLayer("Name","res3a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res3a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn3a_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res3a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res3a")
        reluLayer("Name","res3a_relu")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res3b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn3b_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res3b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn3b_branch2a")
        reluLayer("Name","res3b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res3b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn3b_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res3b")
        reluLayer("Name","res3b_relu")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res4a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res4a_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch2a")
        reluLayer("Name","res4a_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res4a_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn4a_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res4a")
        reluLayer("Name","res4a_relu")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([1 1],32,"Name","res4b_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn4b_branch1")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        convolution2dLayer([3 3],32,"Name","res4b_branch2a","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
        batchNormalizationLayer("Name","bn4b_branch2a")
        reluLayer("Name","res4b_branch2a_relu")
        convolution2dLayer([3 3],32,"Name","res4b_branch2b","BiasLearnRateFactor",0,"Padding","same")
        batchNormalizationLayer("Name","bn4b_branch2b")];
    network = addLayers(network,tempLayers);
    
    tempLayers = [
        additionLayer(2,"Name","res4b")
        reluLayer("Name","res4b_relu")
        globalAveragePooling2dLayer("Name","gapool")
        fullyConnectedLayer(modTypeNum,"Name","fc")
        softmaxLayer("Name","softmax")
        classificationLayer("Name","classoutput")];
    network = addLayers(network,tempLayers);
    
    % 헬퍼 변수 정리
    clear tempLayers;
    
    network = connectLayers(network,"pool1","res2a_branch2a");
    network = connectLayers(network,"pool1","res2a_branch1");
    network = connectLayers(network,"bn2a_branch2b","res2a/in1");
    network = connectLayers(network,"bn2a_branch1","res2a/in2");
    network = connectLayers(network,"res2a_relu","res2b_branch2a");
    network = connectLayers(network,"res2a_relu","res2b_branch1");
    network = connectLayers(network,"bn2b_branch1","res2b/in2");
    network = connectLayers(network,"bn2b_branch2b","res2b/in1");
    network = connectLayers(network,"res2b_relu","res3a_branch2a");
    network = connectLayers(network,"res2b_relu","res3a_branch1");
    network = connectLayers(network,"bn3a_branch1","res3a/in2");
    network = connectLayers(network,"bn3a_branch2b","res3a/in1");
    network = connectLayers(network,"res3a_relu","res3b_branch1");
    network = connectLayers(network,"res3a_relu","res3b_branch2a");
    network = connectLayers(network,"bn3b_branch1","res3b/in2");
    network = connectLayers(network,"bn3b_branch2b","res3b/in1");
    network = connectLayers(network,"res3b_relu","res4a_branch1");
    network = connectLayers(network,"res3b_relu","res4a_branch2a");
    network = connectLayers(network,"bn4a_branch1","res4a/in2");
    network = connectLayers(network,"bn4a_branch2b","res4a/in1");
    network = connectLayers(network,"res4a_relu","res4b_branch1");
    network = connectLayers(network,"res4a_relu","res4b_branch2a");
    network = connectLayers(network,"bn4b_branch1","res4b/in2");
    network = connectLayers(network,"bn4b_branch2b","res4b/in1");

    output = network;
end

