%% plot spider orb-web mechanics
clear all
close all
clc
%%
load sound_field_24cmX24cm-gap2cm-169points.mat  % 3m sound field mapping
load measure_points_on_web_without_spider.mat % 2D mapping position of web motion without spider
load measured_points_on_web_with_spider.mat % 2D mapping position of web motion with spider
load webfreqresponse_planewave.mat % orb-web frequency responses
load web_time_response.mat % orb-web time responses
load cmap_spectrogram.mat % color map for plot
%%
ftsize=12;
cl=[1 0.6 0.6];
msize=12;
lwidth=1;
cpsize=5;
msize=16;

cl_1=[0.5 0.7 0.2];
cl_2=[0.94 0.42 0.42];
cl_3=[0  0.5 0.8];
cl_4=[0.5 0.5 0.5];

pref=20e-6;
meanamp=mean(amplitudemicall,2);
maxamp=max(amplitudemicall,[],2);
minamp=min(amplitudemicall,[],2);
dbamp=20*log10(amplitudemicall/pref).';
dBmeanamp=20*log10(meanamp/pref).';
dBmaxamp=20*log10(maxamp/pref).';
dBminamp=20*log10(minamp/pref).';
Freq_planewave=[freqtotal,  fliplr(freqtotal)];
SPL_planewave=[dBminamp,  fliplr(dBmaxamp)];
%% plot measured position without spider on web
figure('name','Orb-web without spider')
imshow('spider web.jpg');
hold on 
plot(X1,Y1,'yx','MarkerSize',3);

%% plot measured position with spider on web
figure('name','Orb-web with spider')
imshow('spider web with spider.jpg');
measure_body=[1,15];
measure_leg=[19:22,24:25,27:28,31:32,34:39];
measure_radii=[65:67,69:71,73:75,77:79,81:104,106:108,110:112,114:116,118:120];
measure_hub=[40:46,52:54,56:63];
measure_other=[47:51,55,64,68,72,76,80,105,109,113,117];
hold on 
plot(X1([measure_body measure_radii measure_hub measure_other]),...
    Y1([measure_body measure_radii measure_hub measure_other]),'yx','MarkerSize',6)

%% figure 3D sound field
freqplot=200; % select a freq want to plot (Hz)

tmp = abs(freqplot-freqtotal);
[freqindex freqindex] = min(tmp); %index of closest value
[x,y]=meshgrid(Xpositions,Ypositions);
pp=amplitudemicall(freqindex,:);

index=0;
for idy=1:length(Ypositions)
    for idx=1:length(Xpositions)
        index=index+1;
    soundpressure(idy,idx)= pp(index);   
    end
end
%
dBsoundpressure=20*log10(soundpressure/pref);

figure('name','SPL in dB')
surf(x,y,dBsoundpressure)
shading interp
colorbar
view (2)
view ([43.2 51.6])
xlabel('X (mm)')
ylabel('Y (mm)')
zlabel('SPL (dB)')
zlim([95 98])
caxis([95 98])
colormap (cmap)
%title(['SPL (dB) at ' num2str(freqplot) 'Hz'])
set(gca,'FontSize',22,'XMinorGrid','on','XMinorTick','on','XTick',...
    [0 50 100 150 200 250],'YMinorGrid','on','YMinorTick','on','YTick',...
    [0 50 100 150 200 250])

%% plot sound field at various frequencies and locations
freq_plot=[];
idx_plot=[];
freq_select=logspace(2,4,31);% plot less data for a clean figure with errorbar 
for idx_freq=1:length(freq_select)
tmp = abs(freq_select(idx_freq)-freqtotal);
[M,I] = min(tmp); %index of closest value
idx_plot(idx_freq)=I;
end
freq_plot=freqtotal(idx_plot);
dbamp_plot=dbamp(:,idx_plot);
dBmaxamp_plot=dBmaxamp(:,idx_plot);
dBminamp_plot=dBminamp(:,idx_plot);
%
figure('name','Broadband SPL at different locations')
hold on
fplot(1)=errorbar(freq_plot,mean(dbamp_plot),dBminamp_plot-mean(dbamp_plot),dBmaxamp_plot-mean(dbamp_plot));
set(gca,'Xscale','log','fontsize',22)
xlabel('Frequency (Hz)')
ylabel('SPL (dB)')
box on
ylim([90 100])
xlim([90 11000])


set(fplot(1),'MarkerSize',msize,...
    'MarkerFaceColor',cl_3,...
    'MarkerEdgeColor',cl_3,...
    'Marker','square',...
    'Color',cl_3);

%% plot frequency response of orb-web
freq_plot=[];
idx_plot=[];
freq_select=logspace(2,4,21);% plot less freq data for a clean figure with error bar
for idx_freq=1:length(freq_select)
tmp = abs(freq_select(idx_freq)-freq);
[M,I] = min(tmp); %index of closest value
idx_plot(idx_freq)=I;
end
freq_plot=freq(idx_plot);
withspider=[3,5:19,21:48];
body=[1,3,4,6:12];
base=[1,2,6:9,11,12];
nospider=[1:21,23,25:43,45:60];

t_base=transferfnforplot_base(base,idx_plot);
t_body=transferfnforplot_body(body,idx_plot);
t_webnospider=transferfnforplot_nospider(nospider,idx_plot);
t_webspider=transferfnforplot_withspider(withspider,idx_plot);


figure('name','Orb-web frequency response')
hold on
fplot(1)=errorbar(freq_plot,mean(abs(t_webnospider),1))
hold on
fplot(1)=errorbar(freq_plot,mean(abs(t_webnospider),1),std(abs(t_webnospider),[],1));
fplot(2)=errorbar(freq_plot,mean(abs(t_webspider),1),std(abs(t_webnospider),[],1));
fplot(3)=errorbar(freq_plot,mean(abs(t_body),1),std(abs(t_body),[],1));
fplot(4)=errorbar(freq_plot,mean(abs(t_base),1),std(abs(t_base),[],1));

set(gca,'Xscale','log','Yscale','log','fontsize',24)
xlabel('Frequency (Hz)')
xlim([min(freq_plot) max(freq_plot)])
legend('Orb-web only','Orb-web with spider','Spider body','Base','EdgeColor','none','Color','none',...
    'Position',[0.2 0.56 0.43 0.26])
ylabel('V/V_a_i_r')
ylim([1e-4 2])
box on


set(fplot(4),'MarkerSize',msize,...
    'MarkerFaceColor',[1 1 1],...
    'MarkerEdgeColor',cl_4,...
    'Marker','o',...
    'Color',cl_4);
set(fplot(3),'MarkerSize',msize,...
    'MarkerFaceColor',cl_3,...
    'MarkerEdgeColor',cl_3,...
    'Marker','o',...
    'Color',cl_3);
set(fplot(2),'MarkerSize',msize,...
    'MarkerFaceColor','none',...
    'MarkerEdgeColor',cl_2,...
    'Marker','square',...
    'Color',cl_2);
set(fplot(1),'MarkerSize',msize,...
    'MarkerFaceColor',cl_1,...
    'MarkerEdgeColor',cl_1,...
    'Marker','square',...
    'Color',cl_1);

%% plot data without spider
figure('name','Spectrogram without spider')

subplot(2,1,1)
spectrogram(mic_norm_nospider,1024,[],4096*2^4,fs,'MinThreshold',-90,'yaxis')
xlabel('Time (s)')
ylabel('Frequency (kHz)');
colormap (cmap)
% Create xlabel
xlabel('Time (s)');
ylim([0 10])
xlim([0 3])
%colorbar 
set(gca,'fontsize',ftsize);
subplot(2,1,2)
spectrogram(laser_norm_nospider,1024,[],4096,fs,'MinThreshold',-90,'yaxis')
xlabel('Time (s)')
ylim([0 10])
xlim([0 3])
colormap (cmap)
set(gca,'fontsize',ftsize);

figure('name','Time response without spider')
subplot(2,1,1)
plot(tselect,mic_norm_nospider,'color',[0 0.45 0.74]);
set(gca,'Visible','off')
subplot(2,1,2)
plot(tselect, -laser_norm_nospider,'color',[0.96 0.42 0.42]);
set(gca,'Visible','off')
%% plot data with spider
figure('name','Spectrogram with spider')
subplot(2,1,1)
spectrogram(mic_norm_spider,1024,[],4096*2^4,fs,'MinThreshold',-90,'yaxis')
xlabel('Time (s)')
ylabel('Frequency (kHz)');
xlim([0 3])
% Create xlabel
xlabel('Time (s)');
ylim([0 10])
colormap (cmap)
set(gca,'fontsize',ftsize);

subplot(2,1,2)
spectrogram(laser_norm_spider,1024,[],4096,fs,'MinThreshold',-90,'yaxis')
xlabel('Time (s)')
ylim([0 10])
%colorbar
set(gca,'fontsize',ftsize);
xlim([0 3])
colormap (cmap)

figure('name','Time response with spider')
subplot(2,1,1)
plot(tselect,mic_norm_spider,'color',[0 0.45 0.74]);
set(gca,'Visible','off')
subplot(2,1,2)
plot(tselect, -laser_norm_spider,'color',[0.96 0.42 0.42]);
set(gca,'Visible','off')

%% plot vibration attenuation on spider orb-web


spl_min=-60;
spl_max=30;
d=0:10:40; %mm

cl_1=[0.5 0.7 0.2];
cl_2=[0.94 0.42 0.42];
cl_3=[0  0.5 0.8];
cl_4=[0.5 0.5 0.5];

spl_plane_spider=...
    [82 82 81 76 69;
    82 81 80 77 72;
    83 83 83 83 82;
    82 81 79 76 71;
    83 83 81 80 71;
    83 83 81 78 73;
    84 84 84 82 79;
    83 83 82 79 75;
    81 81 81 78 70;
    82 83 82 80 75;
    83 83 83 81 76;
    82 82 81 78 73];
spl_point_spider=...
    [92 89 85 74 61;
    86 83 80 76 69;
    88 85 82 78 71;
    82 79 76 72 65;
    90 87 84 82 72;
    86 83 81 78 71;
    91 86 80 72 63;
    87 84 81 77 69;
    92 88 84 79 69;
    90 86 82 77 69;
    92 89 84 80 73;
    89 83 79 74 67];
spl_plane_no_spider=...
    [83 83 83 83 83;
    82 82 82 82 82;
    81 83 84 84 84;
    83 83 83 83 83;
    83 84 84 84 84;
    83 84 84 84 84;
    83 84 85 85 85;
    84 85 84 85 85;
    81 83 84 84 84;
    80 82 83 83 82;
    82 83 83 82 81;
    82 82 82 82 81];
spl_point_no_spider=...
    [86 83 80 75 64;
    86 83 80 76 69;
    82 79 76 73 64;
    83 80 77 73 63;
    91 87 84 80 72;
    87 85 82 79 72;
    84 77 69 63 54;
    86 80 76 73 67;
    95 88 83 77 70;
    89 86 82 77 70;
    93 89 83 79 71;
    90 84 80 76 67];

spl_minispeaker=[89.29 64.97 54.73 54.26 52.3]; % from 2D scan

% plot data with errorbar

Y1=spl_plane_no_spider-spl_plane_no_spider(:,1);
Y2=spl_point_no_spider-spl_point_no_spider(:,1);
Y3=spl_plane_spider-spl_plane_spider(:,1);
Y4=spl_point_spider-spl_point_spider(:,1);

figure('name','vibration attenuation')
hold on
fplot(1)=errorbar(d,mean(Y2),std(abs(Y2),[],1));
fplot(2)=errorbar(d,mean(Y4),std(abs(Y4),[],1));
fplot(3)=plot(d,spl_minispeaker(1:5)-spl_minispeaker(1));
set(gca,'fontsize',24)
ylabel('Attenuation (dB)')
xlabel('d (mm)')
box on


set(fplot(3),'MarkerSize',10,...
    'MarkerFaceColor',cl_3,...
    'MarkerEdgeColor',cl_3,...
    'Marker','o',...
    'Color',cl_3);
set(fplot(2),'MarkerSize',msize,...
    'MarkerFaceColor','none',...
    'MarkerEdgeColor',cl_2,...
    'Marker','square',...
    'Color',cl_2);
set(fplot(1),'MarkerSize',msize,...
    'MarkerFaceColor',cl_1,...
    'MarkerEdgeColor',cl_1,...
    'Marker','square',...
    'Color',cl_1);
xlim([-2 42])
ylim([-50 5])
legend('Orb-web only','Orb-web with spider','Airborne','EdgeColor','none','Color','none',...
    'Position',[0.16 0.18 0.43 0.20])

