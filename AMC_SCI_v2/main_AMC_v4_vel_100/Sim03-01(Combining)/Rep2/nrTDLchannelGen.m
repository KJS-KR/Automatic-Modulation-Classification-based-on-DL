function Hout = nrTDLchannelGen(nr_CarrierConfig,sl_ResourcePoolconfig)
    %% Resource grid parameters
    Nsc     = sl_ResourcePoolconfig.Nsc;
    Nsyms   = sl_ResourcePoolconfig.Nsyms;
    ResourcePoolGrid = zeros(Nsc,Nsyms);

    %% Channel parameters
    scs     = nr_CarrierConfig.SCS;
    nfft    = nr_CarrierConfig.Nfft;
    sr      = scs * nfft;
    v       = nr_CarrierConfig.velocity; % UE velocity in km/h
    fc      = nr_CarrierConfig.fc; % UE velocity in km/h
    vc      = physconst('lightspeed'); % speed of light in m/s
    fd      = (v*1000/3600)/vc*fc;     % UE max Doppler frequency in Hz
    
    tdl                     = nrTDLChannel;
    tdl.DelayProfile        = 'TDL-A';
    tdl.DelaySpread         = 10^-8.3;
    tdl.MaximumDopplerShift = fd;
    tdl.SampleRate          = sr;
    tdl.RandomStream        = 'Global stream'; % random seed
    tdl.NumReceiveAntennas  = 1;
    chInfo                  = info(tdl);
    
    % sinc generation
    ResourcePoolGrid(1:Nsc,1:Nsyms) = ones(Nsc,Nsyms);
    
    % OFDM modulation
    carrier = nrCarrierConfig;
    carrier.NCellID = 0;                    % Cell identity
    carrier.SubcarrierSpacing = scs/10^3;         % Carrier/BWP Subcarrier spacing
    carrier.CyclicPrefix = 'normal';        % Cyclic prefix
    carrier.NSlot      = 0;                 % Slot counter
    carrier.NFrame     = 0;                 % Frame counter
    carrier.NStartGrid = 0;                % Carrier offset
    carrier.NSizeGrid  = 50;                % Size of carrier in RB
    
    carrierGrid = ResourcePoolGrid;
    
    [wave,~] = nrOFDMModulate(carrier,carrierGrid,'Windowing',0);
    
    maxChDelay = ceil(max(chInfo.PathDelays*tdl.SampleRate)) +  ...
                 chInfo.ChannelFilterDelay;
    
    txWave = [wave; zeros(maxChDelay, size(wave,2))];  
    
    % channel passing
    rxWave  = tdl(txWave);
    
    % Timing estimate
    offset = 7;
    rxWaveS = rxWave(1+offset:end,:);
    
    % OFDM demodulate the carrier
    Hout = nrOFDMDemodulate(carrier,rxWaveS);  
end

