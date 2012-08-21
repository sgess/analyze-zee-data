clear all;

data_dir = '~/Desktop/FACET/analyze-zee-data/shake_data/';

%plot_dir = '~/Desktop/plots/shake_data/';
plot_dir = '~/Desktop/FACET/PLOTS/shake_data/';

data_names;

STD_table = zeros(19,9);
VEL_table = zeros(19,9);
DIS_table = zeros(19,9);

%x = load('BG17.mat');

%Filter Stuff
L = 4096;
FS = 512;
T = 1/FS;
df = FS/L;
lb = 10;

f = (FS-df)*linspace(0,1,L);
t = (0:L-1)*T;
[m1, low_pass] = min(abs(f-lb));
[m2, high_pass] = min(abs(f-(FS-lb)));

cdf3 = (erf((f-lb)/1.00)+erf((-f+FS-lb)/1.00))/2;

%Load Data
for f=1:length(set_list)
    %cd(['~/Desktop/shake data/XCS_start_0840.aps/mat/MAT' num2str(f) '/']);
    cd([data_dir 'MAT' num2str(f) '/']);
    if ~exist([plot_dir set_handle{f} '/'],'dir');
        mkdir([plot_dir set_handle{f} '/']);
    end
    
    n_files = length(dir('DPsv*'));
    n_chan = 9;
    
    BG_TS = zeros(4096,2,n_files,n_chan);
    PS_FT = zeros(4096,n_files,n_chan);
    FILTR = zeros(4096,n_files,n_chan);
    FIFFT = zeros(4096,n_files,n_chan);
    VEL   = zeros(4096,n_files,n_chan);
    DIS   = zeros(4096,n_files,n_chan);

    
    TS_STD = zeros(n_files,n_chan);
    TS_AVG = zeros(n_files,n_chan);
    TS_RMS = zeros(n_files,n_chan);
    TS_MIN = zeros(n_files,n_chan);
    TS_MAX = zeros(n_files,n_chan);
    
    VEL_STD = zeros(n_files,n_chan);
    VEL_AVG = zeros(n_files,n_chan);
    VEL_RMS = zeros(n_files,n_chan);
    VEL_MIN = zeros(n_files,n_chan);
    VEL_MAX = zeros(n_files,n_chan);
    
    DIS_STD = zeros(n_files,n_chan);
    DIS_AVG = zeros(n_files,n_chan);
    DIS_RMS = zeros(n_files,n_chan);
    DIS_MIN = zeros(n_files,n_chan);
    DIS_MAX = zeros(n_files,n_chan);

    for i=0:(n_files-1)
        
        BG1_0 = load(['DPsv0000' num2str(i) '.mat']);
        
        BG_TS(:,:,i+1,1) = BG1_0.X1;
        BG_TS(:,:,i+1,2) = BG1_0.X2;
        BG_TS(:,:,i+1,3) = BG1_0.X3;
        BG_TS(:,:,i+1,4) = BG1_0.X4;
        BG_TS(:,:,i+1,5) = BG1_0.X5;
        BG_TS(:,:,i+1,6) = BG1_0.X6;
        BG_TS(:,:,i+1,7) = BG1_0.X7;
        BG_TS(:,:,i+1,8) = BG1_0.X8;
        BG_TS(:,:,i+1,9) = BG1_0.X9;
        
    end

    for i=1:n_files
        for j=1:n_chan
            
            %Create new power spectrum
            PS_FT(:,i,j)= fft(BG_TS(:,2,i,j),L);
            
            %Apply filter
            FILTR(:,i,j)= cdf3.*(PS_FT(:,i,j)');
            
            %IFFT to get high freq time domain
            FIFFT(:,i,j)= ifft(FILTR(:,i,j),L);
            
            TS_STD(i,j) = std(FIFFT(:,i,j));
            TS_AVG(i,j) = mean(FIFFT(:,i,j));
            TS_RMS(i,j) = sqrt(sum(FIFFT(:,i,j).*FIFFT(:,i,j))/4096);
            TS_MIN(i,j) = min(FIFFT(:,i,j));
            TS_MAX(i,j) = max(FIFFT(:,i,j));
            
            %Subtract off DC
            FIFFT(:,i,j)= FIFFT(:,i,j) - TS_AVG(i,j);
            
            %Integrate to get velocity
            VEL(:,i,j) = cumtrapz(9.8*FIFFT(:,i,j)) * T;
            
            VEL_STD(i,j) = std(VEL(:,i,j));
            VEL_AVG(i,j) = mean(VEL(:,i,j));
            VEL_RMS(i,j) = sqrt(sum(VEL(:,i,j).*VEL(:,i,j))/4096);
            VEL_MIN(i,j) = min(VEL(:,i,j));
            VEL_MAX(i,j) = max(VEL(:,i,j));
            
            %Subtract off DC
            VEL(:,i,j) = VEL(:,i,j) - VEL_AVG(i,j);
            
            %Integrate to get displacement
            DIS(:,i,j) = cumtrapz(VEL(:,i,j)) * T;
            
            DIS_STD(i,j) = std(DIS(:,i,j));
            DIS_AVG(i,j) = mean(DIS(:,i,j));
            DIS_RMS(i,j) = sqrt(sum(DIS(:,i,j).*DIS(:,i,j))/4096);
            DIS_MIN(i,j) = min(DIS(:,i,j));
            DIS_MAX(i,j) = max(DIS(:,i,j));
            
            %Subtract off DC
            DIS(:,i,j) = DIS(:,i,j) - DIS_AVG(i,j);
            
            %Store dists            
            STD_table(f,j) = TS_STD(i,j);
            VEL_table(f,j) = VEL_STD(i,j);
            DIS_table(f,j) = DIS_STD(i,j);
            
            save([set_handle{f} '_' num2str(i) '_ws.mat'],'BG_TS','FIFFT','VEL','DIS',...
                'TS_STD','TS_AVG','TS_RMS','TS_MIN','TS_MAX',...
                'VEL_STD','VEL_AVG','VEL_RMS','VEL_MIN','VEL_MAX',...
                'DIS_STD','DIS_AVG','DIS_RMS','DIS_MIN','DIS_MAX');
            
            plot(BG_TS(:,1,i,j),FIFFT(:,i,j),':');

            xlabel('Time (s)');
            ylabel('Acceleration (g)');
            title([chan_list{j} ' sample for ' set_list{f}]);
            v = axis;
            str1(1) = {['Sample STD: ' num2str(TS_STD(i,j),'%10.4e')]};
            text(0.5,v(3) + (v(4) -  v(3))/5, str1, 'FontSize', 18);
            
            %saveas(gcf,[plot_dir set_handle{f} '/TS_' chan_handle{j} '_' num2str(i) '.pdf']);
            
            plot(BG_TS(:,1,i,j),VEL(:,i,j),':');
            xlabel('Time (s)');
            ylabel('Velocity (m/s)');
            title([chan_list{j} ' velocity sample for ' set_list{f}]);
            v = axis;
            str1(1) = {['Sample STD: ' num2str(VEL_STD(i,j),'%10.4e')]};
            text(0.5,v(3) + (v(4) -  v(3))/5, str1, 'FontSize', 18);
            
            %saveas(gcf,[plot_dir set_handle{f} '/VEL_' chan_handle{j} '_' num2str(i) '.pdf']);

            plot(BG_TS(:,1,i,j),DIS(:,i,j),':');
            xlabel('Time (s)');
            ylabel('Displacement (m)');
            title([chan_list{j} ' displacement sample for ' set_list{f}]);
            v = axis;
            str1(1) = {['Sample STD: ' num2str(DIS_STD(i,j),'%10.4e')]};
            text(0.5,v(3) + (v(4) -  v(3))/5, str1, 'FontSize', 18);
                        
            %saveas(gcf,[plot_dir set_handle{f} '/DIS_' chan_handle{j} '_' num2str(i) '.pdf']);
            
        end
    end
end

save([data_dir 'table'],'STD_table','VEL_table','DIS_table');