% clc; clear; close all;
%%
dataDirectory1 = fullfile("DataFiles", "SNR_0", "3Channel_on_QPSK_0_8PSK_5"); % 부분에서 전체 파일 이름 생성
% dataDirectory2 = fullfile("DataFiles", "SNR_0", "QPSK_0_8PSK_10");
% dataDirectory3 = fullfile("DataFiles", "QPSK_0_8PSK_15");
% dataDirectory4 = fullfile("DataFiles", "QPSK_0_8PSK_20");
% dataDirectory5 = fullfile("DataFiles", "QPSK_0_8PSK_25");
% dataDirectory6 = fullfile("DataFiles", "QPSK_0_8PSK_30");
% dataDirectory7 = fullfile("DataFiles", "QPSK_0_8PSK_35");
% dataDirectory8 = fullfile("DataFiles", "QPSK_0_8PSK_40");
% dataDirectory9 = fullfile("DataFiles", "QPSK_0_8PSK_45");

% dataDirectory1 = fullfile("DataFiles", "QPSK_1_8PSK_5"); % 부분에서 전체 파일 이름 생성
% dataDirectory2 = fullfile("DataFiles", "QPSK_1_8PSK_10");
% dataDirectory3 = fullfile("DataFiles", "QPSK_1_8PSK_15");
% dataDirectory4 = fullfile("DataFiles", "QPSK_1_8PSK_20");
% dataDirectory5 = fullfile("DataFiles", "QPSK_1_8PSK_25");
% dataDirectory6 = fullfile("DataFiles", "QPSK_1_8PSK_30");
% dataDirectory7 = fullfile("DataFiles", "QPSK_1_8PSK_35");
% dataDirectory8 = fullfile("DataFiles", "QPSK_1_8PSK_40");
% dataDirectory9 = fullfile("DataFiles", "QPSK_1_8PSK_45");

modulationTypes1 = {'BPSK', 'QPSK', '8PSK', '16QAM', '64QAM'};
modulationTypes2 = {'QPSK', '8PSK'};

figure;
for num = 1:1:2
    make_files = ['files = dir(fullfile(dataDirectory1, ''*'' + string(modulationTypes2(', num2str(num),')) + ''*''));'];
    eval(make_files)
    load(fullfile(files(1).folder, files(1).name), 'frame');

    subplot(3, 3, num);
    title(files(1).name)
    plot(real(frame), imag(frame), 'x')
    title(files(1).name)
    xline(0)
    yline(0)
end

% files
% load(fullfile(files(1).folder, files(2).name), 'frame');
% plot(real(frame), imag(frame), 'x')