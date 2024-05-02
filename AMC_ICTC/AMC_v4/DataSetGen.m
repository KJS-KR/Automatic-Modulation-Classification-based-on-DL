function [rxTrainFrames, rxTrainLabels] = DataSetGen(N_train,N_frame,modTypes)
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
    epskSig  = reshape(epskSig,N_frame,N_train);
    epskSig_real(:,1,:) = real(epskSig);
    epskSig_real(:,2,:) = imag(epskSig);
    
    % total training set
    data_tr(:,:,1:N_train) = qpskSig_real;
    data_tr(:,:,N_train+1:N_train*numModTypes) = epskSig_real;
    
    for n = 1:N_train * numModTypes 
        rxTrainFrames(1,:,:,n) = data_tr(:,:,n);
        if n <=N_train
            rxTrainLabels(n) = modTypes(1);
        elseif n>N_train
            rxTrainLabels(n) = modTypes(2);
        end
    end
end
