clc; clear; close all;

snr = -10:2:14;

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
accBasicNewDMRSAdd2 = [0.476041666666667	0.526758333333333	0.492083333333333	0.501825000000000	0.570916666666667	0.620391666666667	0.672058333333333	0.723558333333333	0.768133333333333	0.810008333333333	0.846575000000000	0.886625000000000	0.906791666666667	0.931816666666667	0.942400000000000	0.948550000000000];

trainingProceccingTimeBasicNewDMRSAdd4 = [1279.31341260000	1304.10524190000	1279.69586370000	1279.15768880000	1277.83386140000	1279.83723670000	1279.06470970000	1304.79171560000	1305.13806850000	1307.09414030000 1313.57257750000	1296.80334050000	1333.39357950000 1335.04140730000   1316.71554880000   1314.43605460000];
tesingProcessingTimeBasicNewDMRSAdd4 = [8.10148710000000	7.04040410000000	6.59593650000000	6.57417570000000	6.64093960000000	6.45884880000000	6.48271890000000	6.52518300000000	6.55413550000000	6.49008870000000	6.48645970000000	6.52755630000000	6.46464290000000	6.50867280000000	6.49158470000000	6.56739590000000];
accBasicNewDMRSAdd4 = [0.473991666666667   0.487558333333333   0.492683333333333   0.501250000000000   0.573858333333333   0.619866666666667   0.673241666666667   0.724950000000000   0.771058333333333   0.810791666666667   0.852241666666667   0.875000000000000   0.912541666666667   0.931025000000000   0.940591666666667   0.980800000000000];

% % Comparison of AMC Performance According to DMRS
% figure;
% plot(snr, accBasicDMRS, '-|'); hold on; grid on;
% plot(snr, accBasicNonDMRS, '-*'); hold on;
% plot(snr ,accBasicNewDMRS, "-x"); hold on;
% title("Comparison of AMC Performance According to DMRS")
% legend("Basic|DMRS", "Basic|NonDMRS", "Basic|NewDMRS", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")

% % Comparison of AMC Performance According to Soft-Combining Method
% figure;
% plot(snr, accBasicNewDMRS, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRSAdd2, '-*'); hold on;
% plot(snr ,accBasicNewDMRSAdd4, "-x"); hold on;
% title("Comparison of AMC Performance According to Soft-Combining Method")
% legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")

%% 2Rep
accBasicNewDMRS_2Rep_NoComb_NoFu = [0.478266666666667	0.484400000000000	0.493658333333333	0.500666666666667	0.571316666666667	0.620525000000000	0.671025000000000	0.724008333333333	0.770208333333333	0.809900000000000	0.851566666666667	0.875750000000000	0.911883333333333	0.935016666666667	0.941691666666667	0.981150000000000];
accBasicNewDMRS_2Rep_NoComb_voting = [0.476608333333333	0.484825000000000	0.494366666666667	0.501350000000000	0.572266666666667	0.619300000000000	0.670779166666667	0.724095833333333	0.770112500000000	0.809950000000000	0.853175000000000	0.875320833333333	0.911754166666667	0.934729166666667	0.941075000000000	0.981004166666667];
accBasicNewDMRS_2Rep_NoComb_confidence = [0.494250000000000	0.494666666666667	0.500208333333333	0.507475000000000	0.619958333333333	0.681058333333333	0.741558333333333	0.793300000000000	0.831525000000000	0.863516666666667	0.904025000000000	0.917250000000000	0.952658333333333	0.968200000000000	0.971666666666667	0.996516666666667];
accBasicNewDMRS_2Rep_NoComb_feature = [0.497925000000000	0.497575000000000	0.501766666666667	0.508666666666667	0.621358333333333	0.683400000000000	0.745708333333333	0.798000000000000	0.835725000000000	0.866600000000000	0.905125000000000	0.918183333333333	0.952983333333333	0.968325000000000	0.971766666666667	0.996500000000000];

accBasicNewDMRS_2Rep_2Comb_NoFu = [0.476041666666667	0.526758333333333	0.492083333333333	0.501825000000000	0.570916666666667	0.620391666666667	0.672058333333333	0.723558333333333	0.768133333333333	0.810008333333333	0.846575000000000	0.886625000000000	0.906791666666667	0.931816666666667	0.942400000000000	0.948550000000000];

% Performance Comparison between Soft-Combining and Fusion Method
figure;
plot(snr, accBasicNewDMRS_2Rep_NoComb_NoFu(1:13), '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_2Rep_NoComb_voting(1:13), '-*'); hold on;
plot(snr ,accBasicNewDMRS_2Rep_NoComb_confidence(1:13), "-x"); hold on;
plot(snr ,accBasicNewDMRS_2Rep_NoComb_feature(1:13), "-o"); hold on;
plot(snr ,accBasicNewDMRS_2Rep_2Comb_NoFu(1:13), "-^"); hold on;
title("AMC Results|2Rep")
legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|NoComb|Voting", "Basic|NewDMRS|NoComb|Confidence", "Basic|NewDMRS|NoComb|Feature", "Basic|NewDMRS|2Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

%% 4Rep
accBasicNewDMRS_4Rep_NoComb_NoFu = [0.473991666666667   0.487558333333333   0.492683333333333   0.501250000000000   0.573858333333333   0.619866666666667   0.673241666666667   0.724950000000000   0.771058333333333   0.810791666666667   0.852241666666667   0.875000000000000   0.912541666666667   0.931025000000000   0.940591666666667   0.980800000000000];
accBasicNewDMRS_4Rep_NoComb_voting = [0.475156250000000   0.486360416666667   0.492447916666667   0.500718750000000   0.573522916666667   0.619143750000000   0.671939583333333   0.723618750000000   0.770308333333333   0.810506250000000   0.852535416666667   0.876070833333333   0.912041666666667   0.932485416666667   0.940650000000000   0.980960416666667];
accBasicNewDMRS_4Rep_NoComb_confidence = [0.497483333333333   0.500941666666667   0.502683333333333   0.511850000000000   0.678050000000000   0.747650000000000   0.800833333333333   0.841250000000000   0.872783333333333   0.897450000000000   0.934491666666667   0.942433333333333   0.972083333333333   0.981858333333333   0.982833333333333   0.999000000000000];
accBasicNewDMRS_4Rep_NoComb_feature = [0.498441666666667   0.501566666666667   0.502491666666667   0.511316666666667   0.681975000000000   0.754291666666667   0.808183333333333   0.844975000000000   0.874933333333333   0.898841666666667   0.936091666666667   0.943516666666667   0.973525000000000   0.983550000000000   0.984116666666667   0.999400000000000];

accBasicNewDMRS_4Rep_2Comb_NoFu = [0.487725000000000   0.493175000000000   0.501600000000000   0.510400000000000   0.639625000000000   0.695900000000000   0.746575000000000   0.787875000000000   0.820725000000000   0.851425000000000   0.880250000000000   0.921200000000000   0.931925000000000   0.951225000000000   0.953475000000000   0.959775000000000];
accBasicNewDMRS_4Rep_2Comb_voting = [];
accBasicNewDMRS_4Rep_2Comb_confidence = [];
accBasicNewDMRS_4Rep_2Comb_feature = [];

accBasicNewDMRS_4Rep_4Comb_NoFu = [0.510416666666667   0.484641666666667   0.493100000000000   0.505925000000000   0.570908333333333   0.619983333333333   0.674508333333333   0.726316666666667   0.768041666666667   0.812475000000000   0.849958333333333   0.894466666666667   0.984366666666667  0.936850000000000   0.939741666666667   0.959958333333333];

figure;
plot(snr, accBasicNewDMRS_4Rep_NoComb_NoFu(1:13), '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_4Rep_NoComb_voting(1:13), '-*'); hold on;
plot(snr ,accBasicNewDMRS_4Rep_NoComb_confidence(1:13), "-x"); hold on;
plot(snr ,accBasicNewDMRS_4Rep_NoComb_feature(1:13), "-o"); hold on;
plot(snr ,accBasicNewDMRS_4Rep_2Comb_NoFu(1:13), "-^"); hold on;
title("AMC Results|4Rep")
legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|NoComb|Voting", "Basic|NewDMRS|NoComb|Confidence", "Basic|NewDMRS|NoComb|Feature", "Basic|NewDMRS|2Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

% figure;
% plot(snr, accBasicNewDMRS_4Rep_2Comb_NoFu, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRS_4Rep_2Comb_voting, '-*'); hold on;
% plot(snr ,accBasicNewDMRS_4Rep_2Comb_confidence, "-x"); hold on;
% plot(snr ,accBasicNewDMRS_4Rep_2Comb_feature, "-o"); hold on;
% plot(snr ,accBasicNewDMRS_4Rep_4Comb_NoFu, "-^"); hold on;
% title("AMC Results|4Rep")
% legend("Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|2Comb|Voting", "Basic|NewDMRS|2Comb|Confidence", "Basic|NewDMRS|2Comb|Feature", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")

%% 8Rep
accBasicNewDMRS_8Rep_NoComb_NoFu = [0.475350000000000	0.486591666666667	0.493266666666667	0.500550000000000	0.571875000000000	0.618250000000000	0.670883333333333	0.723441666666667	0.771275000000000	0.810758333333333	0.850841666666667	0.875683333333333	0.911558333333333	0.932400000000000	0.940433333333333	0.981958333333333];
accBasicNewDMRS_8Rep_NoComb_voting = [0.475025000000000	0.485650000000000	0.492972916666667	0.500569791666667	0.572390625000000	0.619323958333333	0.671923958333333	0.723817708333333	0.770391666666667	0.810187500000000	0.851871875000000	0.875320833333333	0.911054166666667	0.932581250000000	0.940604166666667	0.981308333333333];
accBasicNewDMRS_8Rep_NoComb_confidence = [0.496541666666667	0.501941666666667	0.502833333333333	0.516858333333333	0.732650000000000	0.796000000000000	0.838633333333333	0.870091666666667	0.894541666666667	0.915750000000000	0.948050000000000	0.953875000000000	0.980516666666667	0.987158333333333	0.988241666666667	0.999791666666667];
accBasicNewDMRS_8Rep_NoComb_feature = [0.497316666666667	0.501666666666667	0.502891666666667	0.515033333333333	0.737508333333333	0.805125000000000	0.846808333333333	0.872733333333333	0.896216666666667	0.917100000000000	0.949891666666667	0.955741666666667	0.982041666666667	0.988975000000000	0.989241666666667	0.999858333333333];

accBasicNewDMRS_8Rep_2Comb_NoFu = [0.476283333333333	0.486683333333333	0.493408333333333	0.499625000000000	0.573641666666667	0.619516666666667	0.675516666666667	0.725233333333333	0.768525000000000	0.807666666666667	0.845875000000000	0.888833333333333	0.905175000000000	0.931833333333333	0.941583333333333	0.950000000000000];
accBasicNewDMRS_8Rep_2Comb_voting = [0.476197916666667	0.485722916666667	0.493208333333333	0.500268750000000	0.572800000000000	0.620347916666667	0.673039583333333	0.725464583333333	0.770035416666667	0.807741666666667	0.846104166666667	0.888560416666667	0.906410416666667	0.931812500000000	0.942006250000000	0.950122916666667];
accBasicNewDMRS_8Rep_2Comb_confidence = [0.499358333333333	0.502358333333333	0.501841666666667	0.510433333333333	0.677216666666667	0.748716666666667	0.802716666666667	0.846075000000000	0.872941666666667	0.893591666666667	0.924683333333333	0.959991666666667	0.967500000000000	0.980833333333333	0.984075000000000	0.985583333333333];
accBasicNewDMRS_8Rep_2Comb_feature = [0.500758333333333	0.502458333333333	0.501550000000000	0.510558333333333	0.682233333333333	0.755708333333333	0.811100000000000	0.850408333333333	0.874900000000000	0.894616666666667	0.925641666666667	0.961800000000000	0.969008333333333	0.982675000000000	0.985725000000000	0.986741666666667];

accBasicNewDMRS_8Rep_4Comb_NoFu = [0.263758333333333	0.315666666666667	0.410950000000000	0.432366666666667	0.383966666666667	0.390850000000000	0.455800000000000	0.508150000000000	0.566350000000000	0.615291666666667	0.663308333333333	0.713550000000000	0.761325000000000	0.810641666666667	0.863516666666667	0.901350000000000];
accBasicNewDMRS_8Rep_4Comb_voting = [0.263987500000000	0.316637500000000	0.411879166666667	0.431883333333333	0.384075000000000	0.390379166666667	0.455479166666667	0.508312500000000	0.566687500000000	0.614837500000000	0.662870833333333	0.714300000000000	0.761304166666667	0.811279166666667	0.863504166666667	0.901216666666667];
accBasicNewDMRS_8Rep_4Comb_confidence = [0.272658333333333	0.341766666666667	0.458058333333333	0.477275000000000	0.416000000000000	0.419950000000000	0.490050000000000	0.542841666666667	0.595716666666667	0.637925000000000	0.689175000000000	0.743266666666667	0.790775000000000	0.843358333333333	0.894550000000000	0.929891666666667];
accBasicNewDMRS_8Rep_4Comb_feature = [0.253908333333333	0.293916666666667	0.409458333333333	0.439708333333333	0.378358333333333	0.389416666666667	0.463775000000000	0.500641666666667	0.539116666666667	0.575783333333333	0.632125000000000	0.688591666666667	0.755908333333333	0.823558333333333	0.889558333333333	0.928675000000000];

% figure;
% plot(snr, accBasicNewDMRS_8Rep_NoComb_NoFu, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRS_8Rep_NoComb_voting, '-*'); hold on;
% plot(snr ,accBasicNewDMRS_8Rep_NoComb_confidence, "-x"); hold on;
% plot(snr ,accBasicNewDMRS_8Rep_NoComb_feature, "-o"); hold on;
% plot(snr ,accBasicNewDMRS_8Rep_2Comb_NoFu, "-^"); hold on;
% title("AMC Results|8Rep")
% legend("Basic|NewDMRS|NoComb|NoFu", "Basic|NewDMRS|NoComb|Voting", "Basic|NewDMRS|NoComb|Confidence", "Basic|NewDMRS|NoComb|Feature", "Basic|NewDMRS|2Comb|NoFu", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")

figure;
plot(snr, accBasicNewDMRS_8Rep_2Comb_NoFu(1:13), '-|'); hold on; grid on;
plot(snr, accBasicNewDMRS_8Rep_2Comb_voting(1:13), '-*'); hold on;
plot(snr ,accBasicNewDMRS_8Rep_2Comb_confidence(1:13), "-x"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_2Comb_feature(1:13), "-o"); hold on;
plot(snr ,accBasicNewDMRS_8Rep_4Comb_NoFu(1:13), "-^"); hold on;
title("AMC Results|8Rep")
legend("Basic|NewDMRS|2Comb|NoFu", "Basic|NewDMRS|2Comb|Voting", "Basic|NewDMRS|2Comb|Confidence", "Basic|NewDMRS|2Comb|Feature", "Basic|NewDMRS|4Comb|NoFu", 'Location', 'southeast')
xlabel("Signal-to-Noise(dB)")
ylabel("Accuracy(%)")

% figure;
% plot(snr, accBasicNewDMRS_8Rep_4Comb_NoFu, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRS_8Rep_4Comb_voting, '-*'); hold on;
% plot(snr ,accBasicNewDMRS_8Rep_4Comb_confidence, "-x"); hold on;
% plot(snr ,accBasicNewDMRS_8Rep_4Comb_feature, "-o"); hold on;
% title("AMC Results|8Rep")
% legend("Basic|NewDMRS|4Comb|NoFu", "Basic|NewDMRS|4Comb|Voting", "Basic|NewDMRS|4Comb|Confidence", "Basic|NewDMRS|4Comb|Feature", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")

% Performance comparison based on Aggregation Level
% figure;
% plot(snr, accBasicNewDMRS_2Rep_NoComb_feature, '-|'); hold on; grid on;
% plot(snr, accBasicNewDMRS_4Rep_NoComb_feature, '-*'); hold on; grid on;
% plot(snr, accBasicNewDMRS_8Rep_NoComb_feature, '-x'); hold on; grid on;
% title("AMC Results|Aggregation Level 2 4 8")
% legend("Basic|NewDMRS|NoComb|NoFu|Rep2", "Basic|NewDMRS|NoComb|NoFu|Rep4", "Basic|NewDMRS|NoComb|NoFu|Rep8", 'Location', 'southeast')
% xlabel("Signal-to-Noise(dB)")
% ylabel("Accuracy(%)")
