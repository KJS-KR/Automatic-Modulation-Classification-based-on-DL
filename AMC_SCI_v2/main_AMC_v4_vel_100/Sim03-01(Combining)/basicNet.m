function output = basicNet(spf, modTypeNum)

    netWidth    = 1;
    filterSize  = [1 8];
    poolSize    = [1 2];
    
    network = [
        imageInputLayer([1 spf 2], 'Normalization', 'none', 'Name', 'Input Layer')
        
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
        
        averagePooling2dLayer([1 15], 'Name', 'AP1')
        
        fullyConnectedLayer(modTypeNum, 'Name', 'FC1')
        softmaxLayer('Name', 'SoftMax')
        
        classificationLayer('Name', 'Output') ];

    output = network;
end

