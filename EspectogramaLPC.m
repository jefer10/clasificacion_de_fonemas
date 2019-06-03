clc ;clear all;close all;
%[x,fs]=audioread('vozfemenina.wav');
[x1,fs]=audioread('AEIOU.wav');
x=x1(:,1);
l = length(x);        % Length of signal
t=(0:l-1)'/fs;
wl=32;
wd=wl/4;
nw=floor((l-wl)/wd);                                                                                                                                                                                         
f = fs*(0:(wl/2))/wl;
%%construccion matriz autocorrelacion y coeficientes de autocorrelacion
p = 4; %% polos...frecuancias resonancia
r = zeros(p+1,1);
for i=1:nw %i en tiempo
%%filtro pre enfasis%%enfatizar frecuencias altas%%mirar frecuencias
%%resonantes
aux=x((i-1)*wd+(1:wl)).*hamming(wl);
%filtro de pre-enfasis
for n=2:wl
    aux(n)= aux(n)-0.625*aux(n-1);
end

for k=0:p
    r(k+1) = aux((k+1):wl)'*aux(1:(wl-k)); %%vector autocorrelacion "coseno angulo q forman las dos señales"
end    
R = r(1:p);
r = r(2:(p+1));
%%matriz autocorrelacion
for j=2:p
    R(:,j) = [R(j,1); R(1:p-1,j-1)];
end
%%estimadores coeficientes filtros digital
a= -inv(R)*r; 
H = freqz(1,[1;a],wl/2+1); %%filtro
H = abs(H);
H = H/max(H); %%ajuste ganancia, asumiendo los picos
H = 20*log10(H);
V(:,i)=H;
end
i=1:nw;
tt=((length(x)/nw)/fs)*i;
figure('Color','White');
subplot(212),plot(t,x);
subplot(211);
mesh(tt,f,V);
view(2)
axis tight
title(['WL= ',num2str(wl)])
xlabel('t[s]')
zlabel('20*log(|P(f)|)');
ylabel('f [Hz]')