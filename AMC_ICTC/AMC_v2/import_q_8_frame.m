clc; clear; close all;

dataDirectory_0dB = fullfile("DataFiles", "SNR_0", "QPSK_0_8PSK_0");
dataDirectory_20dB = fullfile("DataFiles", "SNR_20", "QPSK_0_8PSK_0");

modulationTypes = {'QPSK', '8PSK'};

files_Q_0dB = dir(fullfile(dataDirectory_0dB, '*' + string(modulationTypes(1)) + '*'));
files_8_0dB = dir(fullfile(dataDirectory_0dB, '*' + string(modulationTypes(2)) + '*'));
files_Q_20dB = dir(fullfile(dataDirectory_20dB, '*' + string(modulationTypes(1)) + '*'));
files_8_20dB = dir(fullfile(dataDirectory_20dB, '*' + string(modulationTypes(2)) + '*'));

figure;
for num = 1:1:9
    load(fullfile(files_Q_0dB(num*1000).folder, files_Q_0dB(num*1000).name), 'frame');
    
    subplot(3, 3, num);
    plot(real(frame), imag(frame), 'x')
    title(string(files_Q_0dB(num).name))
end

figure;
for num = 1:1:9
    load(fullfile(files_8_0dB(num*1000).folder, files_8_0dB(num*1000).name), 'frame');
    
    subplot(3, 3, num);
    plot(real(frame), imag(frame), 'x')
    title(string(files_8_0dB(num).name))
end

figure;
for num = 1:1:9
    load(fullfile(files_Q_20dB(num*1000).folder, files_Q_20dB(num*1000).name), 'frame');
    
    subplot(3, 3, num);
    plot(real(frame), imag(frame), 'x')
    title(string(files_Q_20dB(num).name))
end

figure;
for num = 1:1:9
    load(fullfile(files_8_20dB(num*5).folder, files_8_20dB(num*5).name), 'frame');
    
    subplot(3, 3, num);
    plot(real(frame), imag(frame), 'x')
    title(string(files_8_20dB(num).name))
end
