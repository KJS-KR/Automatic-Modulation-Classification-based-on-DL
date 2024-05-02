clear all;

NgType = 1;
if NgType == 1, nt='CP'; elseif NgType == 2, nt='ZP'; end
Ch = 1;
if Ch == 0, chType = 'AWGN'; else chType='CH'; end

PowerdB = [0 -8 -17 -21 -25];
Delay = [0 3 5 6 8];
Power = 10.^(PowerdB/10);
Ntap = length(PowerdB);
Lch = Delay(end) + 1;

bps = 4;
Nfft = 64;
Ng = Nfft / 4;
Lsym = Nfft + Ng;
Nvc = Nfft / 4;
Nused = Nfft - Nvc;

EbN0 = [0:5:30];
N_iter = 10;
Nframe = 3;
sigPow = 0;

for i=0:length(EbN0)
    rand('state', 0); rand('state', 0); ber2 = ber();
    norm = [1 sqrt(2) 0 sqrt(10) 0 sqrt(42)];
    for m=1:N_iter
        bit = randi(1, Nused*Nframe, 2^bps);
        qamSym = qammod(bit, 2^bps, 'gray')/norm(bps);
        if NgType ~= 2, ofdmSym2 = zeros(1, Nframe * Lsym);
         elseif NgType == 2, ofdmSym2 = zeros(1, Nframe * Lsym + Ng);
        end
        kk1 = [1:Nused/2]; kk2 = [Nused/2+1:Nused]; kk3=1:Nfft; kk4=1:Lsym;
        for k=1:Nframe
            if Nvc~=0, qamSym2= [0 qamSym(kk2) zeros(1,Nvc-1) qamSym(kk1)];
             else qamSym2 = [qamSym(kk2) qamSym(kk1)];
            end
            ofdmSym(kk3) = ifft(qamSym2);
            ofdmSym2(kk4) = guard_interval(Ng, Nfft, NgType, ofdmSym(kk3));
            kk1 = kk1 + Nused; kk2 = kk2 + Nused; kk3 = kk3 + Nfft; kk4 = kk4 + Lsym;
        end
        if Ch==0, ofdmSym3= ofdmSym2;
        else
            channel = (randn(1, Ntap)+1j*randn(1,Ntap))./ sqrt(2);
            channel = sqrt(Power).*channel;
            cir = zeros(1,Lch); cir(Delay+1)=channel;
            ofdmSym3 = conv(ofdmSym2, cir);
        end
        if i==0
            for k=1:Nframe
                kk= 1 + (k-1) * Lsym:k * Lsym;
                sigPow = sigPow + ofdmSym3(kk) * ofdmSym3(kk)';
            end
            continue;
        end
        snr = EbN0(i) + 10*log(bps*(Nused/Nfft));
        noise_mag = sqrt((10.^(-snr/10))*sigPow/2);
        ofdmSym3 = ofdmSym3 + noise_mag * (randn(size(ofdmSym3)) + 1j*randn(size(ofdmSym3)));
        
        kk1= (NgType==2) * Ng+[1:Lsym]; kk2 = 1:Nfft;
        kk3 = 1:Nused; kk4 = Nused/2 + Nvc+1:Nfft; kk5 = (Nvc~=0) + [1:Nused/2];
        if Ch==1
            cfr = fft([cir zeros(1, Nfft-Lch)]);
            cfr2(kk3) = [cfr(kk4) cfr(kk5)];
        end
        for k=1:Nframe
            ofdmSymRx(kk2) = fft(remove_GI(Ng, Lsym, NgType, ofdmSym3(kk1)));
            ofdmSymRx2(kk3) = [ofdmSymRx(kk4) ofdmSymRx(kk5)];
            if Ch~=0
                ofdmSymRx2(kk3) = ofdmSymRx2(kk3)./cfr2;
            end
            kk1 = kk1 + Lsym; kk2 = kk2 + Nfft; kk3 = kk3 + Nused;
            kk4 = kk4 + Nfft; kk5 = kk5 + Nfft;
        end
        bit_Rx = qamdemod(ofdmSymRx2*norm(bps), 2^bps, 'gray');
        ber2 = ber(bit_Rx, bit, bps);
    end
    if i==0, sigPow = sigPow/Lsym/Nframe/N_iter;
    else if (ber2<1e-6), break; end
    end
end

plot(real(ofdmSymRx), imag(ofdmSymRx), 'x')
axis([-3 3 -3 3])

       