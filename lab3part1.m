clear all
close all
clc
%% generate square wave 
Fs = 10000;
Ts = 1/Fs;
signalLength = 1;       
time = 0:Ts:signalLength;  
f = 1000/(2*pi);        
x = square(1000*time);  %Generate square wave of frequency, w = 2*pi*f = 1000
figure(1);
plot(time,x);grid on;   %plot signal in time domain
axis([0 .05 -1.2 1.2]);  %adjust axis of the plot
title('First few cycles of the wave form, x(t)');   

%% Generate Power Spectrum Density plot using fft

n = signalLength*Fs;    %number of samples

power_of_x = sum(x.^2)/n;                 

XF=fft(x)/Fs;  

XFs=fftshift(XF);       

Exf=abs(XFs).^2;         

Pxf=Exf/signalLength;  

freq=[-(n/2):1:n/2]*Fs/n; 

maxPxf=max(Pxf);            %find max for better plotting

figure(2);                 
plot(freq,Pxf)
axis([-2500 2500 -0.025 maxPxf+0.025])
title('Two-sided Power spectral Density of x(t)');
xlabel('Frequency in Hz ')
ylabel('PSD of x(t) ')

figure(3)
plot(freq,10*log10(Pxf/maxPxf))
axis([-2500 2500 -100 0])
grid
title('Two-sided Power spectral Density of x(t) in db');
xlabel('Frequency in Hz ')

%% Periodogram method of generating PSD plot 

figure(4)
periodogram(x,[],'onesided',512,Fs);