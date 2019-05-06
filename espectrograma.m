clear all;
close all;
[x,fs]=audioread('vozfemenina.wav');
% n=(0:19999)';
% T=[4*ones(4000,1); 40*ones(4000,1)];
% T=[T; T; 4*ones(4000,1)];
% x=cos(2*pi*n./T);
L=length(x);
t=(0:L-1)'/fs;
subplot(212),plot(t,x)
ax=gca;
ax.YLim=[-1.5 1.5]
l=length(x);
wl=512;
wd=wl/4;
nw=floor((l-wl)/wd)                                                                                                                                                                                         
%fs=1;
f = (fs*((1:(wl/2))/wl))';
for i=1:nw %i en tiempo
    y=x((i-1)*wd+(1:wl)).*hamming(wl);
    y=20*log10(abs(fftshift(fft(y)/wl)));%densidad espectral de potencia
    y=y(1:wl/2);%solo para tomar la mitad del espectro por ser par 
    V(:,i)=y;
end
i=1:nw;
subplot(211);
mesh(i,f,V);
view(2)
axis tight
title(['WL= ',num2str(wl)])