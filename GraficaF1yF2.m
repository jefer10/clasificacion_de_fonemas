clc ;clear all;close all;
%[x,fs]=audioread('vozfemenina.wav');
figure('Color','White');
subplot(211)
hold on;
[x1,fs]=audioread('A.wav');
stri=' Señal A';
x=x1(10000+(1:7000),1);
l = length(x);        % Length of signal
t=(0:l-1)'/fs;
wl=128;
wd=wl/4;
nw=floor((l-wl)/wd);                                                                                                                                                                                         
f = fs*(0:(wl/2))/wl;
%%construccion matriz autocorrelacion y coeficientes de autocorrelacion
p = 6; %% polos...frecuancias resonancia
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
    P = pole(tf(1,[1;a]'));
    f1=[abs(fs*angle(P(1))/(2*pi)) abs(fs*angle(P(3))/(2*pi)) abs(fs*angle(P(5))/(2*pi))];
    f1 = sort(f1);%ordena f1
    plot(f1(1),f1(2),'*');
end
title(stri);
xlabel('f1 [Hz]');
ylabel('f2 [Hz]');
subplot(212),plot(t,x);
title(stri);
ylabel('V ');
xlabel('t [s]');