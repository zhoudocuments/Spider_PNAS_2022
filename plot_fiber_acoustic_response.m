%% This program plot the silk frequency responses under a given tension

close all
clear all
clc
%% set frequency range
freqlow=10;
freqhigh=2e4;
numfreq=1000;
freq=logspace(log10(freqlow),log10(freqhigh),numfreq)';
omega=2*pi*freq;
%% set parameters
L=0.03; %The length of the fiber in meters
xloc=0.5*L; %Evaluate the response at the middle position of afiber strand
d=1e-6; % The fiber diameter (meters)

N=0;
%N=1e-3;
%N=0.098e-3;
%N=0.21e-3; % fiber tension, N=0 represents a loose fiber, N=mg for tension measurement
%N=0.5e-3

mu=1.8205e-5; % dynamic viscosity of air at 20 ˆC
rho0=1.2047; % air density at 20 ˆC
c=343.21; % the speed of sound at 20 ˆC
% spider silk
E=0e9;
rho=1100;

A=pi*(d/2)^2; %Mass per unit length of wire kg/m
Q=N*L/(E*A); % axial displacement
r=d/2;
I=pi*r^4/2;
omega=2*pi*freq;
k=omega/c;
m=sqrt(1i*omega*rho0/mu);
forceperunitlength=rho0*r*1i*pi*omega./m.*(4*besselk(1, m*r)./...
besselk(0, m*r)+m*r);
predictedtransferfn=forceperunitlength./...
(rho*A*1i*omega+forceperunitlength);

nummodes=500; % make sure this is enough

p=(1:nummodes)'*pi/L;
phi=sin(p*xloc);
phiaverage=-(1./(L*p)).*(cos(p*L)-1);
phiintegrated=-(2/L)*(cos(p*L)-1)./p;
B=zeros(nummodes,numfreq);
for jj=1:nummodes
B(jj,:)=phiintegrated(jj)*forceperunitlength./...
(E*I*p(jj)^4./(1i*omega)+N*p(jj)^2./...
(1i*omega)+1i*A*rho*omega+forceperunitlength);
end

 %% The modal expansion for the response
WdotoverUa=sum(B(:,:).*repmat(phi,[1 length(omega)]));
WdotoverUaaverage=sum(B(:,:).*repmat(phiaverage,[1 length(omega)]));
%% Plot velocity response
figure('name','Velocity response transfer function')
ha(1)=subplot(2,1,1);
loglog(freq,abs(predictedtransferfn),'--',freq,abs(WdotoverUa),...
freq,abs(WdotoverUaaverage),'-.','linewidth',2)
title(['Fiber diameter = ' num2str(d) ' m'])
xlabel('Frequency (Hz)')
xlim([freqlow freqhigh])
ylabel('V_{silk}/V_{air}')
ylim([0.01 100])
legend('neglect modes','with modes','spatial average')
grid on
ha(2)=subplot(2,1,2);
semilogx(freq,angle(predictedtransferfn)*180/pi,'--',...
freq,angle(WdotoverUa)*180/pi,...
freq,angle(WdotoverUaaverage)*180/pi,'-.','linewidth',2)
xlabel('Frequency (Hz)')
xlim([freqlow freqhigh])
ylabel('Phase (\circ)')
ylim([-180 180])
linkaxes(ha,'x');
grid on
%% 
figure('name','Velocity response for tension measurement')
loglog(freq,abs(WdotoverUa),'linewidth',2)
title(['d = ' num2str(d) ' m'])
xlabel('Frequency (Hz)')
xlim([freqlow freqhigh])
ylabel('V_{silk}/V_{air}')
ylim([0.01 100])
grid on