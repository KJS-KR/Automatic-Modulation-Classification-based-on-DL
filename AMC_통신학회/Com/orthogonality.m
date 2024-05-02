clear; clf

T = 1.6; ND = 1000; nn=0:ND; ts=0.002; tt=nn*ts;
Ts = 0.1; M = round(Ts/ts);
nns = [1:M:ND+1]; tts= (nns-1)*ts;
ks = [1:4 3.9 4]; tds = [0 0 0.1 0.1 0 0.15];
K = length(ks);

for i = 1:K
    k = ks(i); td=tds(i); x(i,:) = exp(j*2*pi*k*(tt-td)/T);
    if i==K, x(K, :) = [x(K, [1:700]) x(K-2, [726:end]) x(K-2, [1:25])]; end
    subplot(K, 2, 2*i-1), plot(tt, real(x(i,:)), 'LineWidth',1),
    hold on, plot(tt([1 end]), [0 0], 'k')
    stem(tts, real(x(i, nns)), '.', 'markersize', 5)
end
N = round(T/Ts); xn = x(:, nns(1:N));
xn*xn'/N
XK = fft(xn.').'; kk = 0:N-1;
for i = 1:K
    k=ks(i); td=tds(i);
    subplot(K, 2, 2*i), stem(kk, abs(XK(i,:)), '.', 'markersize', 5)
end