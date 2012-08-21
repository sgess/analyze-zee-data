clear all;
%plot_dir = '~/Desktop/plots/shake_data/';
plot_dir = '~/Desktop/FACET/PLOTS/shake_data/';


chan_list{1} = 'LODCM BEAM X';
chan_list{2} = 'LODCM BEAM Y';
chan_list{3} = 'LODCM BEAM Z';
chan_list{4} = 'Split & Delay BEAM X';
chan_list{5} = 'Split & Delay BEAM Y';
chan_list{6} = 'Split & Delay BEAM Z';
chan_list{7} = 'XCS BEAM Y';
chan_list{8} = 'XCS BEAM Z';
chan_list{9} = 'XCS BEAM X';

chan_handle{1} = 'LODCM_X';
chan_handle{2} = 'LODCM_Y';
chan_handle{3} = 'LODCM_Z';
chan_handle{4} = 'SandD_X';
chan_handle{5} = 'SandD_Y';
chan_handle{6} = 'SandD_Z';
chan_handle{7} = 'XCS_Y';
chan_handle{8} = 'XCS_Z';
chan_handle{9} = 'XCS_X';

set_list{1} = 'FEE Routed Truck 1';
set_list{2} = 'FEE Routed Truck 2';
set_list{3} = 'FEE Road Header 1';
set_list{4} = 'FEE Road Header 2';
set_list{5} = 'FEE Concret Drill';
set_list{6} = 'FEE Backhoe';
set_list{7} = 'FEE Jackhammer';
set_list{8} = 'FEE Concrete Vibrator';
set_list{9} = 'XRT Routed Truck';
set_list{10} = 'XRT Jackhammer';
set_list{11} = 'XRT Concret Drill';
set_list{12} = 'XRT Concrete Vibrator';
set_list{13} = 'XRT Backhoe';
set_list{14} = 'XRT Road Header';
set_list{15} = 'BG 12:00 8/1';
set_list{16} = 'BG 10:00 8/2';
set_list{17} = 'BG 16:00 8/2';
set_list{18} = 'BG (unclipped) 16:30 8/2';
set_list{19} = 'Spencer Jumping';

set_handle{1} = 'FEE_truck1';
set_handle{2} = 'FEE_truck2';
set_handle{3} = 'FEE_roadHeader1';
set_handle{4} = 'FEE_roadHeader2';
set_handle{5} = 'FEE_concreteDrill';
set_handle{6} = 'FEE_backhoe';
set_handle{7} = 'FEE_jackhammer';
set_handle{8} = 'FEE_concreteVib';
set_handle{9} = 'XRT_truck';
set_handle{10} = 'XRT_jackhammer';
set_handle{11} = 'XRT_concreteDrill';
set_handle{12} = 'XRT_concreteVib';
set_handle{13} = 'XRT_backhoe';
set_handle{14} = 'XRT_roadHeader';
set_handle{15} = 'BG1';
set_handle{16} = 'BG2';
set_handle{17} = 'BG3';
set_handle{18} = 'BG4';
set_handle{19} = 'jump';

STD_table = zeros(19,9);
V_STD_tab = zeros(19,9);
D_STD_tab = zeros(19,9);

x = load('BG17.mat');

%Filter Stuff
L = 4096;
FS = 512;
T = 1/FS;
df = FS/L;
lb = 10;

f = (FS-df)*linspace(0,1,L);
t = (0:L-1)*T;
[m, low_pass] = min(abs(f-lb));
[m, high_pass] = min(abs(f-(FS-lb)));

cdf3 = (erf((f-lb)/1.00)+erf((-f+FS-lb)/1.00))/2;

%Load Data
for f=1:length(set_list)
    cd(['~/Desktop/shake data/XCS_start_0840.aps/mat/MAT' num2str(f) '/']);
    if ~exist([plot_dir set_handle{f} '/'],'dir');
        mkdir([plot_dir set_handle{f} '/']);
    end
    
    n_files = length(dir('DPsv*'));
    n_chan = 9;
    
    BG_PS = zeros(1601,2,n_files,n_chan);
    BG_TS = zeros(4096,2,n_files,n_chan);
    PS_FT = zeros(4096,n_files,n_chan);
    FILTR = zeros(4096,n_files,n_chan);
    FIFFT = zeros(4096,n_files,n_chan);
    
    BGAVG = zeros(1601,n_chan);

    TS_STD = zeros(n_files,n_chan);
    TS_AVG = zeros(n_files,n_chan);
    TS_RMS = zeros(n_files,n_chan);
    TS_MIN = zeros(n_files,n_chan);
    TS_MAX = zeros(n_files,n_chan);

    for i=0:(n_files-1)
        
        BG1_0 = load(['DPsv0000' num2str(i) '.mat']);
        
        BG_PS(:,:,i+1,1) = BG1_0.G1_1;
        BG_TS(:,:,i+1,1) = BG1_0.X1;
        BG_PS(:,:,i+1,2) = BG1_0.G2_2;
        BG_TS(:,:,i+1,2) = BG1_0.X2;
        BG_PS(:,:,i+1,3) = BG1_0.G3_3;
        BG_TS(:,:,i+1,3) = BG1_0.X3;
        BG_PS(:,:,i+1,4) = BG1_0.G4_4;
        BG_TS(:,:,i+1,4) = BG1_0.X4;
        BG_PS(:,:,i+1,5) = BG1_0.G5_5;
        BG_TS(:,:,i+1,5) = BG1_0.X5;
        BG_PS(:,:,i+1,6) = BG1_0.G6_6;
        BG_TS(:,:,i+1,6) = BG1_0.X6;
        BG_PS(:,:,i+1,7) = BG1_0.G7_7;
        BG_TS(:,:,i+1,7) = BG1_0.X7;
        BG_PS(:,:,i+1,8) = BG1_0.G8_8;
        BG_TS(:,:,i+1,8) = BG1_0.X8;
        BG_PS(:,:,i+1,9) = BG1_0.G9_9;
        BG_TS(:,:,i+1,9) = BG1_0.X9;
        
    end

for i=1:n_chan
        
        if n_files == 1
            BGAVG(:,i) = BG_PS(:,2,1,i); 
        else
            BGAVG(:,i) = sum(BG_PS(:,2,:,i),3)/n_files;
        end
        
         
        semilogy(BG_PS(:,1,1,i),BGAVG(:,i));
        xlabel('Frequency (Hz)');
        ylabel('Acceleration (g)');
        title([chan_list{i} ' spectrum for ' set_list{f}]);
        %saveas(gcf,['../plots/' set_handle{f} '/PS_' chan_handle{i} '.pdf']);
         
    end
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,1),BG_PS(:,1,1,i),BGAVG(:,2),BG_PS(:,1,1,i),BGAVG(:,3))
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['LODCM Spectra for ' set_list{f}]);
    legend(chan_list{1},chan_list{2},chan_list{3});
    %saveas(gcf,['../plots/' set_handle{f} '/LODCM_PS_avg.pdf']);
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,4),BG_PS(:,1,1,i),BGAVG(:,5),BG_PS(:,1,1,i),BGAVG(:,6));
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['Split & Delay Spectra for ' set_list{f}]);
    legend(chan_list{4},chan_list{5},chan_list{6});
    %saveas(gcf,['../plots/' set_handle{f} '/SandD_PS_avg.pdf']);
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,7),BG_PS(:,1,1,i),BGAVG(:,9),BG_PS(:,1,1,i),BGAVG(:,8));
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['XCS Spectra for ' set_list{f}]);
    legend(chan_list{7},chan_list{9},chan_list{8});
    %saveas(gcf,['../plots/' set_handle{f} '/XCS_PS_avg.pdf']);
    
    
    
    
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,1)-x.BGAVG(:,1),BG_PS(:,1,1,i),BGAVG(:,2)-x.BGAVG(:,2),BG_PS(:,1,1,i),BGAVG(:,3)-x.BGAVG(:,3))
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['LODCM Spectra for ' set_list{f} ' with background subtraction']);
    legend(chan_list{1},chan_list{2},chan_list{3});
    %saveas(gcf,['../plots/' set_handle{f} '/LODCM_PSwBG_avg.pdf']);
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,4)-x.BGAVG(:,4),BG_PS(:,1,1,i),BGAVG(:,5)-x.BGAVG(:,5),BG_PS(:,1,1,i),BGAVG(:,6)-x.BGAVG(:,6));
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['Split & Delay Spectra for ' set_list{f} ' with background subtraction']);
    legend(chan_list{4},chan_list{5},chan_list{6});
    %saveas(gcf,['../plots/' set_handle{f} '/SandD_PSwBG_avg.pdf']);
    
    semilogy(BG_PS(:,1,1,i),BGAVG(:,7)-x.BGAVG(:,7),BG_PS(:,1,1,i),BGAVG(:,9)-x.BGAVG(:,9),BG_PS(:,1,1,i),BGAVG(:,8)-x.BGAVG(:,8));
    xlabel('Frequency (Hz)');
    ylabel('Acceleration (g)');
    title(['XCS Spectra for ' set_list{f} ' with background subtraction']);
    legend(chan_list{7},chan_list{9},chan_list{8});
    %saveas(gcf,['../plots/' set_handle{f} '/XCS_PSwBG_avg.pdf']);
    
end