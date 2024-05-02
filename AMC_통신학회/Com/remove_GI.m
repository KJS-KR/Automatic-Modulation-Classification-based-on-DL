function y=remove_GI(Ng, Lsym, NgType, ofdmSym)
if Ng~=0
    if NgType==1, y=ofdmSym(Ng+1:Lsym);
    elseif NgType==2
        y=ofdmSym(1:Lsym-Ng) + [ofdmSym(Lsym-Ng+1:Lsym) zeros(1, Lsym-2*Ng)];
    end
else, y=fodmSym; end
