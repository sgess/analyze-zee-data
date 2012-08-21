clear all;

%plot_dir = '~/Desktop/plots/shake_data/';
plot_dir = '~/Desktop/FACET/PLOTS/shake_data/';

data_names;

xrt = load('MAT13/XRT_backhoe_1_ws.mat');
bg = load('MAT16/BG2_6_ws.mat');

for j=1:9
    
    plot(bg.BG_TS(:,1,1,j),10^9*bg.DIS(:,1,j),':',bg.BG_TS(:,1,1,j),10^9*xrt.DIS(:,1,j),'-');
    xlabel('Time (s)');
    ylabel('Displacement (nm)');
    title([chan_list{j} ' displacement']);
    v = axis;
    str1(1) = {['Background STD: ' num2str(bg.DIS_STD(1,j),'%10.4e')]};
    str1(2) = {['XRT Backhoe STD: ' num2str(xrt.DIS_STD(1,j),'%10.4e')]};

    text(0.5,v(3) + (v(4) -  v(3))/8, str1, 'FontSize', 18);
    legend('Background','XRT Backhoe');

    saveas(gcf,[plot_dir 'DISwBG_' chan_handle{j} '.pdf']);

end