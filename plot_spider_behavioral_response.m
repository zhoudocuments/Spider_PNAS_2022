% This program plot the spider behavior response, Jian Zhou
close all
clc
clear all

%% set plot parameters
ftsize=25;
cl_0=[1 1 1]; % white
%cl_2=[0.9 0.2 0.2]; % D red
cl_1=[0.8 0.8 0.8]; % light grey
cl_2=[0.96 0.31 0.07]; % light red
cp_0=[1 1 1]; % white
cp_1=[0.98 0.82 0.16]; % yellow
cp_2=[0.1 0.56 0.04]; % D green
cp_3=[0.24 0.47 0.81]; % D blue
cp_4=[0.8 0.36 0.91]; % D purple

%% plot spider response percentage to 3m normal incident sound
num_0dB_200_response=0;
num_68dB_200_response=6;
num_88dB_200_response=11;

num_0dB_1000_response=0;
num_68dB_1000_response=3;
num_88dB_1000_response=9;
num_response=12;

p_response = [num_0dB_200_response num_68dB_200_response num_88dB_200_response;...
    num_0dB_1000_response num_68dB_1000_response num_88dB_1000_response]/num_response*100;
figure('name','Response percentage to 3m normal incident sound')
bar_behavior=bar(p_response,'ShowBaseLine','off','BarWidth',0.8,'EdgeColor','k');
set(gca, 'XTickLabel', {'200' '1000'});
xlabel('Frequency (Hz)')
ylabel('Behavioral response (%)')
ylim([-5 105])
%baseline_68dB = get(bar_68dB,'BaseLine');
%set(baseline_68dB,'LineStyle','none');
set(bar_behavior(1),'DisplayName','_0 dB','FaceColor',cl_0);
set(bar_behavior(2),'DisplayName',' 68 dB',...
    'FaceColor',cl_1);
set(bar_behavior(3),'DisplayName',' 88 dB',...
    'FaceColor',cl_2);

legend(['  ','0 dB'],['  ','68 dB'],['  ','88 dB'],'Position',[0.52 0.68 0.23 0.23],'EdgeColor',[1 1 1])
set(gca,'fontsize',ftsize)
%pbaspect([1 0.9 1])
%% plot spider behavioral types at 200 Hz, 68dB and 88 dB
num_68dB_200_no=6;
num_68dB_200_crouch=6;
num_68dB_200_stretch=0;
num_68dB_200_leg=0;
num_68dB_200_turn=0;
num_88dB_200_no=1;
num_88dB_200_crouch=3;
num_88dB_200_stretch=4;
num_88dB_200_leg=3;
num_88dB_200_turn=1;

behavior_68dB = [num_68dB_200_no num_68dB_200_crouch num_68dB_200_stretch num_68dB_200_leg  num_68dB_200_turn]; %
behavior_88dB = [num_88dB_200_no num_88dB_200_crouch num_88dB_200_stretch num_88dB_200_leg  num_88dB_200_turn]; %


L = {'NA','Crouch'};
behavior_68dB = [num_68dB_200_no num_68dB_200_crouch ]; %
figure('name','Response types to 3m normal incident sound at 200 Hz 68 dB')
H = pie(behavior_68dB);
colormap([cp_0;cp_1]);
%
T = H(strcmpi(get(H,'Type'),'text'));
P = cell2mat(get(T,'Position'));
set(T,{'Position'},num2cell(P*0.6,2))
text(P(:,1),P(:,2),L(:))
pbaspect([1 1 1])

L = {'NA','Crouch','stretch','Raise leg','Turn'};
behavior_88dB = [num_88dB_200_no num_88dB_200_crouch num_88dB_200_stretch num_88dB_200_leg  num_88dB_200_turn]; %

figure('name','Response types to 3m normal incident sound at 200 Hz 88 dB')
H = pie(behavior_88dB);
colormap([cp_0;cp_1;cp_2;cp_3;cp_4]);
%
T = H(strcmpi(get(H,'Type'),'text'));
P = cell2mat(get(T,'Position'));
set(T,{'Position'},num2cell(P*0.6,2))
text(P(:,1),P(:,2),L(:))
pbaspect([1 1 1])
%% plot spider behavioral latency to normal sound
x = 1:4;
t_88dB_200_crouch=[1500 1800 2133 2500 1433 4133 3217 3817 1483]/1000;
t_88dB_200_stretch=[34 34 34]/1000; % <2 frame
t_88dB_200_leg=[567 2083 1917]/1000;
t_88dB_200_turn=[34]/1000; 
dt=[34]/1000; % statistic error for frame counting

figure('name','Response latency to 3m normal incident sound at 200 Hz')
ax = axes();
hold(ax);
boxchart(x(1)*ones(size(t_88dB_200_crouch)), t_88dB_200_crouch,'Boxwidth',0.4,'BoxFaceAlpha',1,'BoxFaceColor', cp_1)
boxchart(x(2)*ones(size(t_88dB_200_stretch)), t_88dB_200_stretch,'Boxwidth',0.4,'BoxFaceAlpha',0.6, 'BoxFaceColor', cp_2)
boxchart(x(3)*ones(size(t_88dB_200_leg)), t_88dB_200_leg,'Boxwidth',0.4,'BoxFaceAlpha',1, 'BoxFaceColor', cp_3)
boxchart(x(4)*ones(size(t_88dB_200_turn)), t_88dB_200_turn,'Boxwidth',0.4,'BoxFaceAlpha',1, 'BoxFaceColor', cp_4)
boxchart(x(1)*ones(size(t_88dB_200_crouch)), t_88dB_200_crouch,'Boxwidth',0.4,'BoxFaceAlpha',0,'BoxFaceColor', [0 0 0])
boxchart(x(2)*ones(size(t_88dB_200_stretch)), t_88dB_200_stretch,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor', [0 0 0])
boxchart(x(3)*ones(size(t_88dB_200_leg)), t_88dB_200_leg,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor', [0 0 0])
boxchart(x(4)*ones(size(t_88dB_200_turn)), t_88dB_200_turn,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor',[0 0 0])

for ii=1:length(t_88dB_200_crouch)
    plot(1,t_88dB_200_crouch(ii),'o','color',cl_1,'markersize',7,...
'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',cp_0)
end
for ii=1:length(t_88dB_200_stretch)
    plot(2,t_88dB_200_stretch(ii),'o','color',cl_1,'markersize',7,...
'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',cp_0)
end
for ii=1:length(t_88dB_200_leg)
    plot(3,t_88dB_200_leg(ii),'o','color',cl_1,'markersize',7,...
'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',cp_0)
end
for ii=1:length(t_88dB_200_turn)
    plot(4,t_88dB_200_turn(ii),'o','color',cl_1,'markersize',7,...
'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',cp_0)
end

set(gca,'fontsize',ftsize,'XTick',[1:4],'XTickLabel', {'Crouch','Stretch','Raise leg','Turn'});
xtickangle(0)

%
xlabel('Response type')
ylabel('Response latency (s)')
ylim([-0.25 5]);
xlim([0.5 4.5])
%pbaspect([1 0.9 1])
annotation('textbox',...
    [0.319 0.235 0.227 0.102],...
    'String',{'\leq34 ms'},...
    'FontSize',20,...
    'EdgeColor','none');
annotation('textbox',...
    [0.705 0.235 0.227 0.102],...
    'String',{'\leq34 ms'},...
    'FontSize',20,...
    'EdgeColor','none');
box on
hold off
%% plot spider response to 0.5m directional sound
num_crouch=3;
num_stretch=2;
num_leg=2;
num_turn=5;

behavior_direction = [num_crouch num_stretch num_leg num_turn]; %
L = {'Crouch','stretch','Raise leg','Turn'};
figure('name','Response types to 0.5m oblique incident sound at 200 Hz 88 dB')
H = pie(behavior_direction);
colormap([cp_1;cp_2;cp_3;cp_4]);
%
T = H(strcmpi(get(H,'Type'),'text'));
P = cell2mat(get(T,'Position'));
set(T,{'Position'},num2cell(P*0.6,2))
text(P(:,1),P(:,2),L(:))
pbaspect([1 1 1])



%% plot spider response percentage to minispeaker 
num_m68dB_200_no=8;
num_m68dB_200_crouch=4;
num_m68dB_200_stretch=0;
num_m68dB_200_leg=0;
num_m68dB_200_turn=0;

behavior_m68dB = [num_m68dB_200_no num_m68dB_200_crouch num_m68dB_200_stretch num_m68dB_200_leg  num_m68dB_200_turn]; %
L = {' ','Crouch','stretch','Raise leg','Turn'};
figure('name','Response types to focal sound at 200 Hz <=68 dB')
H = pie(behavior_m68dB);
colormap([cp_0;cp_1;cp_2;cp_3;cp_4]);
pbaspect([1 1 1])


%% plot spider latency to minispeaker
x = 1:4;
t_88dB_200_crouch=[3363.8; 2491.7; 4615.6 ;2092.7]/1000;
t_88dB_200_stretch=[0]/1000; % 1-2 frame
t_88dB_200_leg=[0]/1000;
t_88dB_200_turn=[0]/1000;
dt=[34]/1000; % use as the statistic error for frame counting


figure('name','Response latency to focal sound at 200 Hz <=68 dB')
ax = axes();
hold(ax);
boxchart(x(1)*ones(size(t_88dB_200_crouch)), t_88dB_200_crouch,'Boxwidth',0.4,'BoxFaceAlpha',1,'BoxFaceColor', cp_1)

boxchart(x(2)*ones(size(t_88dB_200_stretch)), t_88dB_200_stretch,'Boxwidth',0.4,'BoxFaceAlpha',0.6, 'BoxFaceColor', cp_2)
boxchart(x(3)*ones(size(t_88dB_200_leg)), t_88dB_200_leg,'Boxwidth',0.4,'BoxFaceAlpha',1, 'BoxFaceColor', cp_3)
boxchart(x(4)*ones(size(t_88dB_200_turn)), t_88dB_200_turn,'Boxwidth',0.4,'BoxFaceAlpha',1, 'BoxFaceColor', cp_4)
boxchart(x(1)*ones(size(t_88dB_200_crouch)), t_88dB_200_crouch,'Boxwidth',0.4,'BoxFaceAlpha',0,'BoxFaceColor', [0 0 0])
boxchart(x(2)*ones(size(t_88dB_200_stretch)), t_88dB_200_stretch,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor', [0 0 0])
boxchart(x(3)*ones(size(t_88dB_200_leg)), t_88dB_200_leg,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor', [0 0 0])
boxchart(x(4)*ones(size(t_88dB_200_turn)), t_88dB_200_turn,'Boxwidth',0.4,'BoxFaceAlpha',0, 'BoxFaceColor',[0 0 0])
set(gca,'fontsize',ftsize,'XTick',[1:4],'XTickLabel', {'Crouch','Stretch','Raise leg','Turn'});
%
for ii=1:length(t_88dB_200_crouch)
    plot(1,t_88dB_200_crouch(ii),'o','color',cl_1,'markersize',7,...
'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',cp_0)
end
xlabel('Response type')
ylabel('Response latency (s)')
ylim([-0.25 5]);
xlim([0.5 4.5])
xtickangle(0)
%% plot directional stimulus signal

load behavior_directional_time_data.mat

ch_mic=alltimedata.ch_laser; % mic signal channel
timeall=alltimedata.timeall; % time data
fs=alltimedata.fs; % signal sampling rate, set same as orignal sampling rate
mic=alltimedata.audioarray(:,ch_mic); % Pa

duration=0.3; % signal duration, s
fade_duration=0.01; % fade durations, s
zero1_duration=10;
FFTCal_start=(zero1_duration)*fs;
FFTCal_end=(zero1_duration+duration)*fs;
FFTCal=mic(FFTCal_start:FFTCal_end);
FFTsignallength=length(FFTCal);

X=FFTCal;
Y = fft(X);
P2 = abs(Y/FFTsignallength);
P1 = P2(1:FFTsignallength/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = (0:(FFTsignallength/2))*(fs/FFTsignallength);

figure('name','Directional signal')
subplot(2,1,1)
plot(timeall,mic);
xlabel('time(s)')
ylabel('Pressure(Pa)')
legend('Mic')

subplot(2,1,2)
semilogx(f,P1)
xlabel('Frequency (Hz)')
xlim([0.5 8400])
ylabel('Sound Pressure (Pa)')
grid on

