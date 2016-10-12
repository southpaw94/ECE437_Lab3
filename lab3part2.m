clear all
close all
clc
%% load audio signal and plot it
load lab3Audio;
Fs = 22050;
Ts = 1/Fs;

soundsc(lab3Audio,Fs)          %play the noisy audio file
pause(2)
   
time=[1:size(lab3Audio)]; %sample number      
x = lab3Audio';  
figure(1);
plot(time,x);grid on;   %plot signal in time domain
title('Audio signal, x(t)');   %title of the plot

%% Generate Power Spectrum Density plot using fft

n = length(lab3Audio)  %number of samples

power_of_x = sum(x.^2)/n;                 

Xf=fft(x)/Fs;  %Fast Fourier Transform of input

Exf=abs(Xf).^2;         
Pxf=Exf/(n*Ts);  

freq=[0:1:n-1]*Fs/n; 

maxPxf=max(Pxf);            %find max for better plotting

figure(2);                 
plot(freq(1:n/2),Pxf(1:n/2)*100)
axis([0 Fs/2 0 maxPxf])
title('Power spectral Density of x(t)');

%% Periodogram method of generating PSD plot 

figure(3)
periodogram(x,[],'onesided',512,Fs);
title('Power Spectral Density of noisy sudio in dB ')

%% step 3
Xk=fft(x);

%% Choose a low pass filter
Xsize=length(Xk);
Hk=[ones(10000,1);zeros(10000,1); ones(10000,1)];
figure(4)
plot(freq(1:n/2),Hk(1:n/2))
axis([0 Fs/2 -0.2 1.2])
title('Low pass filter chosen for filtering out noise ')
xlabel('Frequency in Hz')
ylabel('H(f) ')

%Filter noisy signal
Xkfilter=Xk.*Hk'; %filter application
xfilter=ifft(Xkfilter); %invert FFT to get signal back

figure(5)
periodogram(real(xfilter),[],'onesided',512,Fs);
title('Power spectral density of filtered audio');

soundsc(real(xfilter),Fs)                      %play the audio file


samples=1:Xsize;     %the data points in t or f domain
figure (6)
subplot(221), plot (samples,real(x)); title('Noisy signal ')
subplot(222), plot (samples,abs(Xk)); title('Spectrum of noisy signal')
subplot(223), plot (samples,real(xfilter)); title('Filtered signal ')
subplot(224), plot (samples,real(Xkfilter)); title('Spectrum of clean signal ')