clear all;

chan_list{1} = 'LODCM BEAM X';
chan_list{2} = 'LODCM BEAM Y';
chan_list{3} = 'LODCM BEAM Z';
chan_list{4} = 'Split & Delay BEAM X';
chan_list{5} = 'Split & Delay BEAM Y';
chan_list{6} = 'Split & Delay BEAM Z';
chan_list{7} = 'XCS BEAM Y';
chan_list{8} = 'XCS BEAM Z';
chan_list{9} = 'XCS BEAM X';

BG_PS = zeros(1601,2,6,9);
BG_TS = zeros(4096,2,6,9);
BGAVG = zeros(1601,9);

TS_STD = zeros(5,9);
TS_AVG = zeros(5,9);
TS_RMS = zeros(5,9);
TS_MIN = zeros(5,9);
TS_MAX = zeros(5,9);

%Load BGs

%BG from afternoon - day after
for i=0:5

    BG1_0 = load(['~/Desktop/shake data/XCS_start_0840.aps/mat/MAT17/DPsv0000' num2str(i) '.mat']);

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

for i=1:5
    for j=1:9
        
        TS_STD(i,j) = std(BG_TS(:,2,i,j));
        TS_AVG(i,j) = mean(BG_TS(:,2,i,j));
        TS_RMS(i,j) = sqrt(sum(BG_TS(:,2,i,j).*BG_TS(:,2,i,j))/4096);
        TS_MIN(i,j) = min(BG_TS(:,2,i,j));
        TS_MAX(i,j) = max(BG_TS(:,2,i,j));
        
        %disp(TS_RMS(i,j)^2 - TS_STD(i,j)^2 - TS_AVG(i,j)^2);
    
    end
end

for i=1:9
    
    BGPS = BG_PS(:,2,1,i) + BG_PS(:,2,2,i) + BG_PS(:,2,3,i) + BG_PS(:,2,4,i) + BG_PS(:,2,5,i) + BG_PS(:,2,6,i);
    BGAVG(:,i) = BGPS/6;
    save('BG17','BGAVG');
    
%     figure;
%     semilogy(BG_PS(:,1,1,i),BG_PS(:,2,1,i),'r.',BG_PS(:,1,2,i),BG_PS(:,2,2,i),'b.',BG_PS(:,1,3,i),BG_PS(:,2,3,i),'m.',...
%         BG_PS(:,1,4,i),BG_PS(:,2,4,i),'y.',BG_PS(:,1,5,i),BG_PS(:,2,5,i),'g.',BG_PS(:,1,6,i),BG_PS(:,2,6,i),'c.',BG_PS(:,1,1,i),BGAVG(:,i),'k');
%     xlabel('Frequency (Hz)');
%     ylabel('Acceleration (g)');
%     title(chan_list{i});
%     legend('Set 1','Set 2','Set 3','Set 4','Set 5','Set 6','Avg');
%     saveas(gcf,['plots/BG17/Chan_' num2str(i) '.pdf']);
end
% 
% figure;
% semilogy(BG_PS(:,1,1,i),BGAVG(:,1),BG_PS(:,1,1,i),BGAVG(:,2),BG_PS(:,1,1,i),BGAVG(:,3))
% xlabel('Frequency (Hz)');
% ylabel('Acceleration (g)');
% title('LODCM BG Average');
% legend(chan_list{1},chan_list{2},chan_list{3});
% saveas(gcf,'plots/BG17/LODCM_.pdf');
% 
% figure;
% semilogy(BG_PS(:,1,1,i),BGAVG(:,4),BG_PS(:,1,1,i),BGAVG(:,5),BG_PS(:,1,1,i),BGAVG(:,6));
% xlabel('Frequency (Hz)');
% ylabel('Acceleration (g)');
% title('Split & Delay BG Average');
% legend(chan_list{4},chan_list{5},chan_list{6});
% saveas(gcf,'plots/BG17/SD.pdf');
% 
% figure;
% semilogy(BG_PS(:,1,1,i),BGAVG(:,7),BG_PS(:,1,1,i),BGAVG(:,9),BG_PS(:,1,1,i),BGAVG(:,8));
% xlabel('Frequency (Hz)');
% ylabel('Acceleration (g)');
% title('XCS BG Average');
% legend(chan_list{7},chan_list{9},chan_list{8});
% saveas(gcf,'plots/BG17/XCS.pdf');