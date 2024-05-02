clc; clear; close all;

snr = -10:2:20;

%%
trainingProcessingTimeBasicDMRS = [1277.745266800000	1272.234218500000	1272.082119100000	1272.273906400000	1272.118176900000	1275.811235800000	1273.651776000000	1274.283880800000	1280.837317600000	1277.895255400000	1274.222073500000	1274.531660900000	1273.100794100000	1274.851832600000	1.285059556800000e+03	1302.684784200000];
testingProcessingTimeBasicDMRS = [6.69513470000000	6.57033710000000	6.59157110000000	6.47498290000000	6.50362230000000	6.52343620000000	6.50948090000000	6.57901800000000 7.04976750000000	7.11577700000000	7.00878480000000	7.13025830000000	7.09232690000000	7.03970180000000	7.07260570000000	7.05224630000000];
accBasicDMRS = [0.249908333333333	0.250775000000000	0.248541666666667	0.251125000000000	0.323366666666667	0.369200000000000	0.425016666666667	0.473375000000000 0.526816666666667	0.571366666666667	0.616391666666667	0.655741666666667	0.681541666666667	0.719083333333333	0.748425000000000	0.762166666666667];

trainingProceccingTimeBasicNonDMRS = [1239.80208460000	1239.60642630000	1240.60785410000	1242.59578700000	1240.41522220000	1240.17965310000	1240.81185320000	1243.04612470000	1240.73843140000	1242.41659580000    1239.80208460000	1239.60642630000	1240.60785410000	1242.59578700000	1240.41522220000	1240.17965310000	1240.81185320000	1243.04612470000	1240.73843140000	1242.41659580000];
tesingProcessingTimeBasicNonDMRS = [7.75717580000000	6.93877170000000	6.75836030000000	6.75326790000000	6.78473060000000	6.75723800000000	6.88895380000000	6.86200770000000	6.78617390000000	6.74051010000000	6.81985450000000	6.78864860000000	6.75947440000000	6.71387110000000	6.80551520000000	6.91224120000000];
accBasicNonDMRS = [0.251750000000000	0.251741666666667	0.250483333333333	0.254675000000000	0.328616666666667	0.378025000000000	0.430683333333333	0.484500000000000	0.534458333333333	0.581700000000000	0.626750000000000	0.672325000000000	0.696450000000000	0.726650000000000	0.750758333333333	0.799883333333333];

trainingProceccingTimeBasicNewDMRS = [1311.04305760000	1286.85145810000	1285.19737930000	1285.08121830000	1287.52585830000	1286.71554240000	1286.55711590000	1286.72008720000   1341.20531960000   1308.72285160000   1311.11121920000   1308.41875280000   1310.14686930000   1313.72460880000   1326.01881850000   1326.76486080000];
tesingProcessingTimeBasicNewDMRS = [8.10148710000000	7.04040410000000	6.59593650000000	6.57417570000000	6.64093960000000	6.45884880000000	6.48271890000000	6.52518300000000	6.55413550000000	6.49008870000000	6.48645970000000	6.52755630000000	6.46464290000000	6.50867280000000	6.49158470000000	6.56739590000000];
accBasicNewDMRS = [0.474891666666667	0.486158333333333	0.491791666666667	0.502958333333333	0.571700000000000	0.618133333333333	0.670900000000000	0.723816666666667	0.769950000000000	0.810925000000000	0.852258333333333	0.875266666666667	0.912216666666667	0.932550000000000	0.940591666666667	0.980383333333333];

trainingProceccingTimeBasicNewDMRSAdd2 = [1274.532110000   1274.63433810000	  1275.16890110000	1276.64282810000	1275.96370380000	1274.73326590000	1272.77540830000	1275.72177700000	1340.42069910000	1283.00437560000	1283.49568230000	1344.15321460000	1342.09399160000	1342.55243250000	1342.75952850000	1342.62101860000];
tesingProcessingTimeBasicNewDMRSAdd2 = [8.10148710000000	7.04040410000000	6.59593650000000	6.57417570000000	6.64093960000000	6.45884880000000	6.48271890000000	6.52518300000000	6.55413550000000	6.49008870000000	6.48645970000000	6.52755630000000	6.46464290000000	6.50867280000000	6.49158470000000	6.56739590000000];
accBasicNewDMRSAdd2 = [0.486600000000000	0.495350000000000	0.496550000000000	0.512000000000000	0.639700000000000	0.698350000000000	0.741750000000000	0.786450000000000	0.820625000000000	0.849875000000000	0.882975000000000	0.918425000000000	0.929350000000000	0.952100000000000	0.954175000000000	0.961500000000000];

trainingProceccingTimeBasicNewDMRSAdd4 = [1279.31341260000	1304.10524190000	1279.69586370000	1279.15768880000	1277.83386140000	1279.83723670000	1279.06470970000	1304.79171560000	1305.13806850000	1307.09414030000 1313.57257750000	1296.80334050000	1333.39357950000 1335.04140730000   1316.71554880000   1314.43605460000];
tesingProcessingTimeBasicNewDMRSAdd4 = [8.10148710000000	7.04040410000000	6.59593650000000	6.57417570000000	6.64093960000000	6.45884880000000	6.48271890000000	6.52518300000000	6.55413550000000	6.49008870000000	6.48645970000000	6.52755630000000	6.46464290000000	6.50867280000000	6.49158470000000	6.56739590000000];
accBasicNewDMRSAdd4 = [0.497775000000000   0.499250000000000   0.506550000000000   0.531150000000000   0.701825000000000   0.743850000000000   0.788075000000000   0.821900000000000   0.845600000000000   0.885000000000000   0.905150000000000   0.938300000000000   0.995075000000000   0.953150000000000   0.960050000000000   0.961650000000000];

% Comparison of AMC Performance According to DMRS
figure;
plot(snr, accBasicDMRS, '-|'); hold on; grid on;
plot(snr, accBasicNonDMRS, '-*'); hold on;
plot(snr ,accBasicNewDMRS, "-x"); hold on;
title("Comparison of AMC Performance According to DMRS")
legend("Basic|DMRS", "Basic|NonDMRS", "Basic|NewDMRS", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

% Comparison of AMC Performance According to Soft-Combining Method
figure;
plot(snr, accBasicNewDMRS, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRSAdd2, '-*'); hold on;
plot(snr ,accBasicNewDMRSAdd4, "-x"); hold on;
title("Comparison of AMC Performance According to Soft-Combining Method")
legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

%% 2Rep
accBasicNewDMRS_2Rep_NoComb_NoFu = [0.469650000000000	0.483000000000000	0.487575000000000	0.491750000000000	0.504125000000000	0.608300000000000	0.659175000000000	0.709150000000000	0.748800000000000	0.790550000000000	0.828225000000000	0.854825000000000	0.884875000000000	0.900675000000000	0.942000000000000	0.994575000000000];
accBasicNewDMRS_2Rep_NoComb_voting = [0.472137500000000	0.483887500000000	0.489237500000000	0.496025000000000	0.504612500000000	0.607025000000000	0.659000000000000	0.710537500000000	0.751650000000000	0.790862500000000	0.829087500000000	0.854600000000000	0.884562500000000	0.902112500000000	0.942125000000000	0.994862500000000];
accBasicNewDMRS_2Rep_NoComb_confidence = [0.480025000000000	0.489575000000000	0.496075000000000	0.500650000000000	0.511825000000000	0.629975000000000	0.682050000000000	0.736400000000000	0.775025000000000	0.812850000000000	0.847400000000000	0.870175000000000	0.899875000000000	0.915600000000000	0.953175000000000	0.996425000000000];
accBasicNewDMRS_2Rep_NoComb_feature = [0.482125000000000	0.490575000000000	0.496525000000000	0.501075000000000	0.510950000000000	0.634350000000000	0.687025000000000	0.739550000000000	0.778575000000000	0.815325000000000	0.848300000000000	0.871450000000000	0.900325000000000	0.916100000000000	0.953475000000000	0.996450000000000];

accBasicNewDMRS_2Rep_2Comb_NoFu = [0.486600000000000	0.495350000000000	0.496550000000000	0.512000000000000	0.639700000000000	0.698350000000000	0.741750000000000	0.786450000000000	0.820625000000000	0.849875000000000	0.882975000000000	0.918425000000000	0.929350000000000	0.952100000000000	0.954175000000000	0.961500000000000];

% Performance Comparison between Soft-Combining and Fusion Method
figure;
plot(snr, accBasicNewDMRS_2Rep_NoComb_NoFu, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_2Rep_NoComb_voting, '-*'); hold on;
plot(snr ,accBasicNewDMRS_2Rep_NoComb_confidence, "-x"); hold on;
plot(snr ,accBasicNewDMRS_2Rep_NoComb_feature, "-o"); hold on;
plot(snr ,accBasicNewDMRS_2Rep_2Comb_NoFu, "-^"); hold on;
title("AMC Results|2Rep")
legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|NoComb|Voting", "Basic|NewDMRS|NoComb|Confidence", "Basic|NewDMRS|NoComb|Feature", "Basic|NewDMRS|2Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

%% 4Rep
accBasicNewDMRS_4Rep_NoComb_NoFu = [0.473525000000000   0.485550000000000   0.490150000000000   0.494475000000000   0.504375000000000   0.605475000000000   0.660400000000000   0.713475000000000   0.751950000000000   0.788950000000000   0.829025000000000   0.853400000000000   0.884350000000000   0.899850000000000   0.944125000000000   0.994650000000000];
accBasicNewDMRS_4Rep_NoComb_voting = [0.471062500000000   0.481881250000000   0.491025000000000   0.495106250000000   0.504081250000000   0.607593750000000   0.660500000000000   0.712531250000000   0.753875000000000   0.790737500000000   0.828600000000000   0.853875000000000   0.882618750000000   0.900243750000000   0.943150000000000   0.994681250000000];
accBasicNewDMRS_4Rep_NoComb_confidence = [0.489000000000000   0.492725000000000   0.496050000000000   0.502175000000000   0.513450000000000   0.653800000000000   0.709450000000000   0.762225000000000   0.797800000000000   0.831475000000000   0.864775000000000   0.883425000000000   0.910700000000000   0.923200000000000   0.961475000000000   0.997650000000000];
accBasicNewDMRS_4Rep_NoComb_feature = [0.485875000000000   0.490625000000000   0.495800000000000   0.500425000000000   0.511450000000000   0.656025000000000   0.713025000000000   0.768250000000000   0.799800000000000   0.833875000000000   0.865625000000000   0.884550000000000   0.912875000000000   0.923350000000000   0.962125000000000   0.997750000000000];

accBasicNewDMRS_4Rep_2Comb_NoFu = [0.487050000000000   0.494925000000000   0.499400000000000   0.506975000000000   0.638250000000000   0.695225000000000   0.744925000000000   0.785000000000000   0.822225000000000   0.852300000000000   0.881550000000000   0.921900000000000   0.927325000000000   0.953350000000000   0.956325000000000   0.961125000000000];
accBasicNewDMRS_4Rep_2Comb_voting = [0.489600000000000   0.493887500000000   0.500325000000000   0.509375000000000   0.639175000000000   0.695225000000000   0.744950000000000   0.785762500000000   0.823700000000000   0.850750000000000   0.881562500000000   0.921312500000000   0.928675000000000   0.952650000000000   0.955300000000000   0.960800000000000];
accBasicNewDMRS_4Rep_2Comb_confidence = [0.493100000000000   0.496750000000000   0.500250000000000   0.513650000000000   0.663625000000000   0.721025000000000   0.769800000000000   0.809525000000000   0.844850000000000   0.868975000000000   0.898425000000000   0.936825000000000   0.940925000000000   0.962375000000000   0.963875000000000   0.967275000000000];
accBasicNewDMRS_4Rep_2Comb_feature = [0.494125000000000   0.497250000000000   0.501425000000000   0.513950000000000   0.667875000000000   0.724300000000000   0.772800000000000   0.812450000000000   0.845875000000000   0.870300000000000   0.899175000000000   0.936925000000000   0.941275000000000   0.962525000000000   0.963925000000000   0.967300000000000];

accBasicNewDMRS_4Rep_4Comb_NoFu = [0.497775000000000   0.499250000000000   0.506550000000000   0.531150000000000   0.701825000000000   0.743850000000000   0.788075000000000   0.821900000000000   0.845600000000000   0.885000000000000   0.905150000000000   0.938300000000000   0.995075000000000   0.953150000000000   0.960050000000000   0.961650000000000];

figure;
plot(snr, accBasicNewDMRS_4Rep_2Comb_NoFu, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_4Rep_2Comb_voting, '-*'); hold on;
plot(snr ,accBasicNewDMRS_4Rep_2Comb_confidence, "-x"); hold on;
plot(snr ,accBasicNewDMRS_4Rep_2Comb_feature, "-o"); hold on;
plot(snr ,accBasicNewDMRS_4Rep_4Comb_NoFu, "-^"); hold on;
title("AMC Results|4Rep")
legend("Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|2Comb|Voting", "Basic|NewDMRS|2Comb|Confidence", "Basic|NewDMRS|2Comb|Feature", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

%% 8Rep
accBasicNewDMRS_8Rep_NoComb_NoFu = [0.471550000000000	0.483400000000000	0.490925000000000	0.492775000000000	0.504350000000000	0.607075000000000	0.662825000000000	0.711200000000000	0.757000000000000	0.790700000000000	0.829175000000000	0.853400000000000	0.883050000000000	0.901375000000000	0.943350000000000	0.994575000000000];
accBasicNewDMRS_8Rep_NoComb_voting = [0.472812500000000	0.483165625000000	0.489625000000000	0.495346875000000	0.504893750000000	0.608256250000000	0.661287500000000	0.712000000000000	0.754546875000000	0.791121875000000	0.828331250000000	0.854181250000000	0.882956250000000	0.901868750000000	0.942428125000000	0.995028125000000];
accBasicNewDMRS_8Rep_NoComb_confidence = [0.495700000000000	0.493875000000000	0.494350000000000	0.500275000000000	0.517725000000000	0.676800000000000	0.730450000000000	0.782225000000000	0.816350000000000	0.843550000000000	0.870050000000000	0.891125000000000	0.917550000000000	0.928600000000000	0.963575000000000	0.998425000000000];
accBasicNewDMRS_8Rep_NoComb_feature = [0.490100000000000	0.491675000000000	0.495250000000000	0.500625000000000	0.513175000000000	0.676050000000000	0.733225000000000	0.786000000000000	0.816025000000000	0.846050000000000	0.871150000000000	0.891975000000000	0.918525000000000	0.929600000000000	0.964475000000000	0.998450000000000];

accBasicNewDMRS_8Rep_2Comb_NoFu = [0.488175000000000	0.492325000000000	0.497800000000000	0.499875000000000	0.638075000000000	0.686900000000000	0.732450000000000	0.776350000000000	0.815550000000000	0.849875000000000	0.873150000000000	0.890900000000000	0.913175000000000	0.920225000000000	0.934700000000000	0.947225000000000];
accBasicNewDMRS_8Rep_2Comb_voting = [0.488175000000000	0.492325000000000	0.497800000000000	0.499875000000000	0.638075000000000	0.686900000000000	0.732450000000000	0.776350000000000	0.815550000000000	0.849875000000000	0.873150000000000	0.890900000000000	0.913175000000000	0.920225000000000	0.934700000000000	0.947225000000000];
accBasicNewDMRS_8Rep_2Comb_confidence = [0.495200000000000	0.499650000000000	0.501875000000000	0.501000000000000	0.688500000000000	0.736700000000000	0.779650000000000	0.818150000000000	0.850500000000000	0.881475000000000	0.900475000000000	0.915525000000000	0.933525000000000	0.938625000000000	0.946650000000000	0.958175000000000];
accBasicNewDMRS_8Rep_2Comb_feature = [0.493000000000000	0.498625000000000	0.500975000000000	0.501250000000000	0.694150000000000	0.740275000000000	0.783400000000000	0.820425000000000	0.853275000000000	0.882800000000000	0.902675000000000	0.916475000000000	0.934100000000000	0.939025000000000	0.947375000000000	0.958225000000000];

accBasicNewDMRS_8Rep_4Comb_NoFu = [0.496275000000000   0.497225000000000   0.609350000000000   0.660275000000000   0.711375000000000   0.757625000000000   0.794875000000000   0.822975000000000   0.852475000000000   0.889875000000000   0.908075000000000   0.923275000000000   0.924100000000000   0.949050000000000   0.952600000000000   0.954550000000000];
accBasicNewDMRS_8Rep_4Comb_voting = [0.495387500000000   0.500025000000000   0.608862500000000   0.660662500000000   0.712762500000000   0.756850000000000   0.792662500000000   0.821300000000000   0.852887500000000   0.890387500000000   0.908700000000000   0.923325000000000   0.924075000000000   0.949475000000000   0.952925000000000   0.953612500000000];
accBasicNewDMRS_8Rep_4Comb_confidence = [0.497825000000000   0.502350000000000   0.632875000000000   0.686325000000000   0.737750000000000   0.778975000000000   0.812025000000000   0.841800000000000   0.868800000000000   0.906200000000000   0.922250000000000   0.935900000000000   0.932275000000000   0.956300000000000   0.958950000000000   0.957650000000000];
accBasicNewDMRS_8Rep_4Comb_feature = [0.499075000000000   0.501925000000000   0.635325000000000   0.691150000000000   0.741400000000000   0.782825000000000   0.814725000000000   0.843175000000000   0.869400000000000   0.907150000000000   0.922900000000000   0.936125000000000   0.932375000000000   0.956500000000000   0.958900000000000   0.957725000000000];

figure;
plot(snr, accBasicNewDMRS_8Rep_NoComb_NoFu, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_8Rep_NoComb_voting, '-*'); hold on;
plot(snr ,accBasicNewDMRS_8Rep_NoComb_confidence, "-x"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_NoComb_feature, "-o"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_2Comb_NoFu, "-^"); hold on;
title("AMC Results|8Rep")
legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|NoComb|Voting", "Basic|NewDMRS|NoComb|Confidence", "Basic|NewDMRS|NoComb|Feature", "Basic|NewDMRS|2Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

figure;
plot(snr, accBasicNewDMRS_8Rep_2Comb_NoFu, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_8Rep_2Comb_voting, '-*'); hold on;
plot(snr ,accBasicNewDMRS_8Rep_2Comb_confidence, "-x"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_2Comb_feature, "-o"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_4Comb_NoFu, "-^"); hold on;
title("AMC Results|8Rep")
legend("Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|2Comb|Voting", "Basic|NewDMRS|2Comb|Confidence", "Basic|NewDMRS|2Comb|Feature", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

figure;
plot(snr, accBasicNewDMRS_8Rep_4Comb_NoFu, '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_8Rep_4Comb_voting, '-*'); hold on;
plot(snr ,accBasicNewDMRS_8Rep_4Comb_confidence, "-x"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_4Comb_feature, "-o"); hold on;
title("AMC Results|8Rep")
legend("Basic|NewDMRS|4Comb|NoFu", "Basic|NewDMRS|4Comb|Voting", "Basic|NewDMRS|4Comb|Confidence", "Basic|NewDMRS|4Comb|Feature", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")
% 
% % Performance comparison based on Aggregation Level
% figure;
% plot(snr, accBasicNewDMRS_2Rep_NoComb_feature, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRS_4Rep_NoComb_feature, '-*'); hold on; grid on;
% plot(snr, accBasicNewDMRS_8Rep_NoComb_feature, '-x'); hold on; grid on;
% title("AMC Results|Aggregation Level 2 4 8")
% legend("Basic|NewDMRS|NoComb|NoFu|Rep2", "Basic|NewDMRS|NoComb|NoFu|Rep4", "Basic|NewDMRS|NoComb|NoFu|Rep8", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")
