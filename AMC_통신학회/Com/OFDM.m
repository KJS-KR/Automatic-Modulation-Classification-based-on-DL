mod = 64;

rand = randi([0 mod-1], 1000, 1);

sig = qammod(rand, mod, 'UnitAveragePower', true);

awgnSig = awgn(sig, 40);

scatterplot(awgnSig)