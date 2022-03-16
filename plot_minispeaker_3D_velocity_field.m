% plot minispeaker 2D field, Jian Zhou
clear all
close all
clc
%load minispeaker_acoustic_field.mat 
load minispeakerdata.mat
load cmap_spectrogram.mat % color map
load('MinispeakerWebMotionModelCoord073020.mat')

%% set parameters
spl_min=20;
spl_max=90;
ftsize=12;
y=0:10:80; % mm
x=-40:10:40; % mm
[X,Y]=meshgrid(x,y);
xvec=5; % x position for time data
yvec=1; % y position for  time data

%%
SPL_V=10*log10(10.^(SPL_laser_x_cf/10)+10.^(SPL_laser_y_cf/10)+10.^(SPL_laser_z_cf/10)); % take summary of three velocity vectors
SPL_P=SPL_mic_cf; % take average of three pressure measurement


%% plot for paper

figure
subplot(2,2,1)
surf(X,Y,SPL_P)
hold on
yline(50,'w--','linewidth',2)
shading interp
colorbar
caxis([50 90])
view (2)
grid off
ylim([0 65])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 65/60 1])
title('SPL (dB)')
colormap (cmap)
set(gca,'fontsize',ftsize,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',...
    {'-30','20','-10','0','10','20','30'},'XTickLabelRotation',0)

subplot(2,2,2)
surf(X,Y,SPL_laser_x_cf)
hold on
yline(50,'w--','linewidth',2)
shading interp
colorbar
caxis([50 90])
view (2)
grid off
ylim([0 65])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 65/60 1])
title('SVL_x (dB)')
colormap (cmap)
set(gca,'fontsize',ftsize,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',...
    {'-30','20','-10','0','10','20','30'},'XTickLabelRotation',0)

subplot(2,2,3)
surf(X,Y,SPL_laser_y_cf)
hold on
yline(50,'w--','linewidth',2)
shading interp
colorbar
caxis([50 90])
view (2)
grid off
ylim([0 65])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 65/60 1])
title('SVL_y (dB)')
colormap (cmap)
set(gca,'fontsize',ftsize,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',...
    {'-30','20','-10','0','10','20','30'},'XTickLabelRotation',0)

subplot(2,2,4)
surf(X,Y,SPL_laser_z_cf)
hold on
yline(50,'w--','linewidth',2)
shading interp
colorbar
caxis([50 90])
view (2)
grid off
ylim([0 65])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 65/60 1])
title('SVL_z (dB)')
colormap (cmap)
set(gca,'fontsize',ftsize,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',...
    {'-30','20','-10','0','10','20','30'},'XTickLabelRotation',0)

%%
figure
subplot(1,2,1)
hold on
yline(50,'w--','linewidth',2)
surf(X,Y,SPL_P)
shading interp
%colormap(cmap)
colorbar
caxis([50 90])
view (2)
grid off
ymax=63;
ylim([0 ymax])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 ymax/60 1])
set(gca,'FontSize',20,'XTick',[-30:10:30],'YTick',[0:10:60]);
box on
colormap (cmap)
title('SPL (dB)');

% colormap plot
subplot(1,2,2)
for ii=1:length(LineComb(:,1))
surf([LineCombCoordx(ii,:)-27; LineCombCoordx(ii,:)-27],...
    [LineCombCoordy(ii,:)+2; LineCombCoordy(ii,:)+2],...
    [LineCombCoordz(ii,:); LineCombCoordz(ii,:)],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2)
    hold all
end
hold on
yline(50,'w--','linewidth',2)
surf(X,Y,SPL_V)
shading interp
%colormap(cmap)
colorbar
caxis([50 90])
view (2)
grid off
ymax=63;
ylim([0 ymax])
xlim([-30 30])
xlabel('x (mm)')
ylabel('y (mm)')
pbaspect([1 ymax/60 1])
set(gca,'FontSize',20,'XTick',[-30:10:30],'YTick',[0:10:60]);
box on
colormap (cmap)
title('SVL (dB)')
