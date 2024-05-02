    modClassNet = [
          imageInputLayer([512 2 1], 'Normalization', 'none', 'Name', 'Input Layer')
        
          convolution2dLayer([21 2], 256, 'Padding', 'same', 'Name', 'CNN1')
          batchNormalizationLayer('Name', 'BN1')
          reluLayer('Name', 'ReLU1')
          dropoutLayer(0.6, 'Name', "Drop1")
          maxPooling2dLayer(poolSize, 'Stride', [2 1], 'Name', 'MaxPool1')
          
        
          convolution2dLayer([21 2], 80, 'Padding', 'same', 'Name', 'CNN2')
          batchNormalizationLayer('Name', 'BN2')
          reluLayer('Name', 'ReLU2')
          dropoutLayer(0.6, 'Name', "Drop2")
          maxPooling2dLayer(poolSize, 'Stride', [2 1], 'Name', 'MaxPool2')
    
          fullyConnectedLayer(256, 'Name', 'FC1')
          reluLayer('Name', 'ReLU3')
          dropoutLayer(0.6, 'Name', "Drop3")
    
          fullyConnectedLayer(numModTypes, 'Name', 'FC2')
          softmaxLayer('Name', 'SoftMax')
        
          classificationLayer('Name', 'Output') ];