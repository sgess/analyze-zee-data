clear all;
plot_dir = '~/Desktop/plots/shake_data/';

L = 4096;
FS = 512;
T = 1/FS;
df = FS/L;
lb = 10;

f = (FS-df)*linspace(0,1,L);
t = (0:L-1)*T;
[m, low_pass] = min(abs(f-lb));
[m, high_pass] = min(abs(f-(FS-lb)));

cdf0 = [zeros(1,low_pass) ones(1,high_pass-low_pass-1) zeros(1,L-high_pass+1)];
cdf1 = (erf((f-lb)/0.25)+erf((-f+FS-lb)/0.25))/2;
cdf2 = (erf((f-lb)/0.50)+erf((-f+FS-lb)/0.50))/2;
cdf3 = (erf((f-lb)/1.00)+erf((-f+FS-lb)/1.00))/2;
cdf4 = (erf((f-lb)/2.00)+erf((-f+FS-lb)/2.00))/2;
cdf5 = (erf((f-lb)/4.00)+erf((-f+FS-lb)/4.00))/2;
cdf6 = (erf((f-lb)/8.00)+erf((-f+FS-lb)/8.00))/2;

figure;
hold all;
plot(f,cdf0);
plot(f,cdf1);
plot(f,cdf2);
plot(f,cdf3,'-s');
plot(f,cdf4);
plot(f,cdf5);
plot(f,cdf6);

axis([0 2*lb 0 1]);
legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Frequency (Hz)');
title('Filters, Frequency Domain');
%saveas(gcf,[plot_dir 'freq_filt.pdf']);


i0 = ifft(cdf0,L);
i1 = ifft(cdf1,L);
i2 = ifft(cdf2,L);
i3 = ifft(cdf3,L);
i4 = ifft(cdf4,L);
i5 = ifft(cdf5,L);
i6 = ifft(cdf6,L);

figure;
hold all;
plot(t,i0);
plot(t,i1);
plot(t,i2);
plot(t,i3,'-s');
plot(t,i4);
plot(t,i5);
plot(t,i6);

axis([0 8 -0.001 0.001]);
legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Time (s)');
title('Filters, Time Domain');
%saveas(gcf,[plot_dir 'time_filt.pdf']);



load('MAT6/FEE_backhoe_ws.mat');

TD = BG_TS(:,2,1,7)';
%TD = TD0 - mean(TD0);

figure;
plot(t,TD);
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('FEE Backhoe, XCS Y Channel, Time Domain');

FD = fft(TD,L);

figure;
plot(f(1:L/2),log(abs(FD(1:L/2))));
xlabel('Frequency (Hz)');
title('FEE Backhoe, XCS Y Channel, Frequency Domain');
axis([0 200 -11 -2]);

f0 = cdf0.*FD;
f1 = cdf1.*FD;
f2 = cdf2.*FD;
f3 = cdf3.*FD;
f4 = cdf4.*FD;
f5 = cdf5.*FD;
f6 = cdf6.*FD;

figure;
hold all;
plot(f(1:L/2),log(abs(f0(1:L/2))));
plot(f(1:L/2),log(abs(f1(1:L/2))));
plot(f(1:L/2),log(abs(f2(1:L/2))));
plot(f(1:L/2),log(abs(f3(1:L/2))),'-s');
plot(f(1:L/2),log(abs(f4(1:L/2))));
plot(f(1:L/2),log(abs(f5(1:L/2))));
plot(f(1:L/2),log(abs(f6(1:L/2))));

axis([0 200 -15 -2]);
legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Frequency (Hz)');
title('FEE Backhoe, XCS Y Channel, Frequency Domain, With Filter');
%saveas(gcf,[plot_dir 'sig_wfreq_filt.pdf']);


tf0 = ifft(f0,L);
tf1 = ifft(f1,L);
tf2 = ifft(f2,L);
tf3 = ifft(f3,L);
tf4 = ifft(f4,L);
tf5 = ifft(f5,L);
tf6 = ifft(f6,L);

figure;
%plot(t,tf0);
%plot(t,tf1);
%plot(t,tf2);
plot(t,TD,':',t,tf3,'--');
%plot(t,tf4);
%plot(t,tf5);
%plot(t,tf6);

legend('No filter',[num2str(lb) ' Hz filter']);
%legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('FEE Backhoe, XCS Y Channel, Time Domain Acceleration');
%saveas(gcf,[plot_dir 'acc_filt.pdf']);

VD = cumsum(9.8*(TD-mean(TD)))*1/FS;
figure;
plot(t,VD);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title(['Time domain velocity with no filter']);

%vf0 = cumsum(9.8*tf0)*1/FS;
%vf1 = cumsum(9.8*tf1)*1/FS;
%vf2 = cumsum(9.8*tf2)*1/FS;
vf3 = cumsum(9.8*tf3)*1/FS;
%vf4 = cumsum(9.8*tf4)*1/FS;
%vf5 = cumsum(9.8*tf5)*1/FS;
%vf6 = cumsum(9.8*(tf6-mean(tf6)))*1/FS;

figure;
%hold all;
%plot(t,VD);
%plot(t,vf0);
%plot(t,VD-vf0,'*');
%plot(t,vf1);
%plot(t,vf2);
plot(t,VD,':',t,vf3,'--');
%plot(t,vf4);
%plot(t,vf5);
%plot(t,vf6);

legend('No filter',[num2str(lb) ' Hz filter']);
%legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
%title(['Time domain velocity with ' num2str(lb) ' Hz high pass filter']);
title('FEE Backhoe, XCS Y Channel, Time Domain Velocity');
%saveas(gcf,[plot_dir 'vel_filt.pdf']);


DD = cumsum(VD)*1/FS;
figure;
plot(t,DD);
xlabel('Time (s)');ylabel('Displacement (m)');
title(['Time domain displacement with no filter']);
%saveas(gcf,[plot_dir 'dis_nofilt.pdf']);

%title('FEE Backhoe, XCS Y Channel, Time Domain');

%df0 = cumsum(vf0-mean(vf0))*1/FS;
%df1 = cumsum(vf1-mean(vf1))*1/FS;
%df2 = cumsum(vf2-mean(vf2))*1/FS;
df3 = cumsum(vf3-mean(vf3))*1/FS;
%df4 = cumsum(vf4-mean(vf4))*1/FS;
%df5 = cumsum(vf5-mean(vf5))*1/FS;
%df6 = cumsum(vf6-mean(vf6))*1/FS;

figure;
%hold all;
%plot(t,VD);
%plot(t,df0);
%plot(t,VD-vf0,'*');
%plot(t,df1);
%plot(t,df2);
plot(t,df3-mean(df3));
%plot(t,df4);
%plot(t,df5);
%plot(t,df6);

%legend('\Theta','\sigma = 0.25','\sigma = 0.5','\sigma = 1','\sigma = 2','\sigma = 4','\sigma = 8');
xlabel('Time (s)');
ylabel('Displacement (m)');
title(['Time domain displacement with ' num2str(lb) ' Hz high pass filter']);
%saveas(gcf,[plot_dir 'dis_wfilt.pdf']);




