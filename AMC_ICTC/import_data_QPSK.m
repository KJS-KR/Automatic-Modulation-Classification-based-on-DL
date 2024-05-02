% clc; clear; close all;
%%
dataDirectory1 = fullfile("DataFiles", "QPSK_5_8PSK_5"); % 부분에서 전체 파일 이름 생성
dataDirectory2 = fullfile("DataFiles", "QPSK_10_8PSK_5");
dataDirectory3 = fullfile("DataFiles", "QPSK_15_8PSK_5");
dataDirectory4 = fullfile("DataFiles", "QPSK_20_8PSK_5");
dataDirectory5 = fullfile("DataFiles", "QPSK_25_8PSK_5");
dataDirectory6 = fullfile("DataFiles", "QPSK_30_8PSK_5");
dataDirectory7 = fullfile("DataFiles", "QPSK_35_8PSK_5");
dataDirectory8 = fullfile("DataFiles", "QPSK_40_8PSK_5");
dataDirectory9 = fullfile("DataFiles", "QPSK_45_8PSK_5");
dataDirectory10 = fullfile("DataFiles", "QPSK_50_8PSK_5");
dataDirectory11 = fullfile("DataFiles", "QPSK_55_8PSK_5");
dataDirectory12 = fullfile("DataFiles", "QPSK_60_8PSK_5");
dataDirectory13 = fullfile("DataFiles", "QPSK_65_8PSK_5");
dataDirectory14 = fullfile("DataFiles", "QPSK_70_8PSK_5");
dataDirectory15 = fullfile("DataFiles", "QPSK_75_8PSK_5");
dataDirectory16 = fullfile("DataFiles", "QPSK_80_8PSK_5");
dataDirectory17 = fullfile("DataFiles", "QPSK_85_8PSK_5");
dataDirectory18 = fullfile("DataFiles", "QPSK_90_8PSK_5");
modulationTypes1 = {'BPSK', 'QPSK', '8PSK', '16QAM', '64QAM'};
modulationTypes2 = {'QPSK', '8PSK'};

figure;
for num = 1:1:18
    make_files = ['files = dir(fullfile(dataDirectory',num2str(num) ,', ''*'' + string(modulationTypes2(1)) + ''*''));'];
    eval(make_files)
    load(fullfile(files(1).folder, files(1).name), 'frame');

    subplot(5, 4, num);
    plot(real(frame), imag(frame), 'x')
    title(string(num*5))
    xline(0)
    yline(0)
end

% files
% load(fullfile(files(1).folder, files(2).name), 'frame');
% plot(real(frame), imag(frame), 'x')