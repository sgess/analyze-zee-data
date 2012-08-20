clear all;

chan_list{1} = 'LODCM BEAM X';
chan_list{2} = 'LODCM BEAM Y';
chan_list{3} = 'LODCM BEAM Z';
chan_list{4} = 'Split & Delay BEAM X';
chan_list{5} = 'Split & Delay BEAM y';
chan_list{6} = 'Split & Delay BEAM Z';
chan_list{7} = 'XCS BEAM Y';
chan_list{8} = 'XCS BEAM Z';
chan_list{9} = 'XCS BEAM X';

BG_PS = zeros(9,1601,2);
BG_TS = zeros(9,4096,2);

%Load BGs

%BG from noon - day of
BG1_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT15/DPsv00000.mat');

BG_PS(1,:,:) = BG1_0.G1_1;
BG_TS(1,:,:) = BG1_0.X1;
BG_PS(2,:,:) = BG1_0.G2_2;
BG_TS(2,:,:) = BG1_0.X2;
BG_PS(3,:,:) = BG1_0.G3_3;
BG_TS(3,:,:) = BG1_0.X3;
BG_PS(4,:,:) = BG1_0.G4_4;
BG_TS(4,:,:) = BG1_0.X4;
BG_PS(5,:,:) = BG1_0.G5_5;
BG_TS(5,:,:) = BG1_0.X5;
BG_PS(6,:,:) = BG1_0.G6_6;
BG_TS(6,:,:) = BG1_0.X6;
BG_PS(7,:,:) = BG1_0.G7_7;
BG_TS(7,:,:) = BG1_0.X7;
BG_PS(8,:,:) = BG1_0.G8_8;
BG_TS(8,:,:) = BG1_0.X8;
BG_PS(9,:,:) = BG1_0.G9_9;
BG_TS(9,:,:) = BG1_0.X9;

for i=1:9
    
    x_s = BG_PS(i,:,1);
    y_s = BG_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/BG_1_PS_chan_' num2str(i) '.png']);
    
    x_t = BG_TS(i,:,1);
    y_t = BG_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/BG_1_TS_chan_' num2str(i) '.png']);
    
end
    
DAT_PS = zeros(9,1601,2);
DAT_TS = zeros(9,4096,2);

%Load Data

%Data from Road header at XRT
DAT14_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT14/DPsv00000.mat');

DAT_PS(1,:,:) = DAT14_0.G1_1;
DAT_TS(1,:,:) = DAT14_0.X1;
DAT_PS(2,:,:) = DAT14_0.G2_2;
DAT_TS(2,:,:) = DAT14_0.X2;
DAT_PS(3,:,:) = DAT14_0.G3_3;
DAT_TS(3,:,:) = DAT14_0.X3;
DAT_PS(4,:,:) = DAT14_0.G4_4;
DAT_TS(4,:,:) = DAT14_0.X4;
DAT_PS(5,:,:) = DAT14_0.G5_5;
DAT_TS(5,:,:) = DAT14_0.X5;
DAT_PS(6,:,:) = DAT14_0.G6_6;
DAT_TS(6,:,:) = DAT14_0.X6;
DAT_PS(7,:,:) = DAT14_0.G7_7;
DAT_TS(7,:,:) = DAT14_0.X7;
DAT_PS(8,:,:) = DAT14_0.G8_8;
DAT_TS(8,:,:) = DAT14_0.X8;
DAT_PS(9,:,:) = DAT14_0.G9_9;
DAT_TS(9,:,:) = DAT14_0.X9;

for i=1:9
    
    x_s = DAT_PS(i,:,1);
    y_s = DAT_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/DAT_14_PS_chan_' num2str(i) '.png']);
    
    x_t = DAT_TS(i,:,1);
    y_t = DAT_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/DAT_14_TS_chan_' num2str(i) '.png']);
    
end

DAT_PS = zeros(9,1601,2);
DAT_TS = zeros(9,4096,2);

%Data from backhoe at XRT
DAT13_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT13/DPsv00000.mat');

DAT_PS(1,:,:) = DAT13_0.G1_1;
DAT_TS(1,:,:) = DAT13_0.X1;
DAT_PS(2,:,:) = DAT13_0.G2_2;
DAT_TS(2,:,:) = DAT13_0.X2;
DAT_PS(3,:,:) = DAT13_0.G3_3;
DAT_TS(3,:,:) = DAT13_0.X3;
DAT_PS(4,:,:) = DAT13_0.G4_4;
DAT_TS(4,:,:) = DAT13_0.X4;
DAT_PS(5,:,:) = DAT13_0.G5_5;
DAT_TS(5,:,:) = DAT13_0.X5;
DAT_PS(6,:,:) = DAT13_0.G6_6;
DAT_TS(6,:,:) = DAT13_0.X6;
DAT_PS(7,:,:) = DAT13_0.G7_7;
DAT_TS(7,:,:) = DAT13_0.X7;
DAT_PS(8,:,:) = DAT13_0.G8_8;
DAT_TS(8,:,:) = DAT13_0.X8;
DAT_PS(9,:,:) = DAT13_0.G9_9;
DAT_TS(9,:,:) = DAT13_0.X9;

for i=1:9
    
    x_s = DAT_PS(i,:,1);
    y_s = DAT_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/DAT_13_PS_chan_' num2str(i) '.png']);
    
    x_t = DAT_TS(i,:,1);
    y_t = DAT_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/DAT_13_TS_chan_' num2str(i) '.png']);
    
end

DAT_PS = zeros(9,1601,2);
DAT_TS = zeros(9,4096,2);

%Data from vibrator at XRT
DAT12_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT12/DPsv00000.mat');

DAT_PS(1,:,:) = DAT12_0.G1_1;
DAT_TS(1,:,:) = DAT12_0.X1;
DAT_PS(2,:,:) = DAT12_0.G2_2;
DAT_TS(2,:,:) = DAT12_0.X2;
DAT_PS(3,:,:) = DAT12_0.G3_3;
DAT_TS(3,:,:) = DAT12_0.X3;
DAT_PS(4,:,:) = DAT12_0.G4_4;
DAT_TS(4,:,:) = DAT12_0.X4;
DAT_PS(5,:,:) = DAT12_0.G5_5;
DAT_TS(5,:,:) = DAT12_0.X5;
DAT_PS(6,:,:) = DAT12_0.G6_6;
DAT_TS(6,:,:) = DAT12_0.X6;
DAT_PS(7,:,:) = DAT12_0.G7_7;
DAT_TS(7,:,:) = DAT12_0.X7;
DAT_PS(8,:,:) = DAT12_0.G8_8;
DAT_TS(8,:,:) = DAT12_0.X8;
DAT_PS(9,:,:) = DAT12_0.G9_9;
DAT_TS(9,:,:) = DAT12_0.X9;

for i=1:9
    
    x_s = DAT_PS(i,:,1);
    y_s = DAT_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/DAT_12_PS_chan_' num2str(i) '.png']);
    
    x_t = DAT_TS(i,:,1);
    y_t = DAT_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/DAT_12_TS_chan_' num2str(i) '.png']);
    
end

DAT_PS = zeros(9,1601,2);
DAT_TS = zeros(9,4096,2);

%Data from me jumping
DAT19_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT19/DPsv00000.mat');

DAT_PS(1,:,:) = DAT19_0.G1_1;
DAT_TS(1,:,:) = DAT19_0.X1;
DAT_PS(2,:,:) = DAT19_0.G2_2;
DAT_TS(2,:,:) = DAT19_0.X2;
DAT_PS(3,:,:) = DAT19_0.G3_3;
DAT_TS(3,:,:) = DAT19_0.X3;
DAT_PS(4,:,:) = DAT19_0.G4_4;
DAT_TS(4,:,:) = DAT19_0.X4;
DAT_PS(5,:,:) = DAT19_0.G5_5;
DAT_TS(5,:,:) = DAT19_0.X5;
DAT_PS(6,:,:) = DAT19_0.G6_6;
DAT_TS(6,:,:) = DAT19_0.X6;
DAT_PS(7,:,:) = DAT19_0.G7_7;
DAT_TS(7,:,:) = DAT19_0.X7;
DAT_PS(8,:,:) = DAT19_0.G8_8;
DAT_TS(8,:,:) = DAT19_0.X8;
DAT_PS(9,:,:) = DAT19_0.G9_9;
DAT_TS(9,:,:) = DAT19_0.X9;

for i=1:9
    
    x_s = DAT_PS(i,:,1);
    y_s = DAT_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/DAT_19_PS_chan_' num2str(i) '.png']);
    
    x_t = DAT_TS(i,:,1);
    y_t = DAT_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/DAT_19_TS_chan_' num2str(i) '.png']);
    
end

DAT_PS = zeros(9,1601,2);
DAT_TS = zeros(9,4096,2);

%Data from unclipped
DAT18_0 = load('~/Desktop/shake data/XCS_start_0840.aps/mat/MAT18/DPsv00000.mat');

DAT_PS(1,:,:) = DAT18_0.G1_1;
DAT_TS(1,:,:) = DAT18_0.X1;
DAT_PS(2,:,:) = DAT18_0.G2_2;
DAT_TS(2,:,:) = DAT18_0.X2;
DAT_PS(3,:,:) = DAT18_0.G3_3;
DAT_TS(3,:,:) = DAT18_0.X3;
DAT_PS(4,:,:) = DAT18_0.G4_4;
DAT_TS(4,:,:) = DAT18_0.X4;
DAT_PS(5,:,:) = DAT18_0.G5_5;
DAT_TS(5,:,:) = DAT18_0.X5;
DAT_PS(6,:,:) = DAT18_0.G6_6;
DAT_TS(6,:,:) = DAT18_0.X6;
DAT_PS(7,:,:) = DAT18_0.G7_7;
DAT_TS(7,:,:) = DAT18_0.X7;
DAT_PS(8,:,:) = DAT18_0.G8_8;
DAT_TS(8,:,:) = DAT18_0.X8;
DAT_PS(9,:,:) = DAT18_0.G9_9;
DAT_TS(9,:,:) = DAT18_0.X9;

for i=1:9
    
    x_s = DAT_PS(i,:,1);
    y_s = DAT_PS(i,:,2);
    
    s = semilogy(x_s,y_s);
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(s,['plots/DAT_18_PS_chan_' num2str(i) '.png']);
    
    x_t = DAT_TS(i,:,1);
    y_t = DAT_TS(i,:,2);
    
    t = plot(x_t,y_t);
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    title(chan_list{i});
    
    saveas(t,['plots/DAT_18_TS_chan_' num2str(i) '.png']);
    
end