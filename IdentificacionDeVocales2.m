clc ;clear all;close all;
[x,fs]=audioread('vozfemenina.wav');
x = x(1650+(1:512)).*hamming(512);%%e%%
l=length(x);
%%filtro pre enfasis%%enfatizar frecuencias altas%%mirar frecuencias
%%resonantes
for n=2:512
    x(n)= x(n)-0.625*x(n-1);
end
%%construccion matriz autocorrelacion y coeficientes de autocorrelacion
p = 4; %% polos...frecuancias resonancia
r = zeros(p+1,1);

for k=0:p
    r(k+1) = x((k+1):512)'*x(1:(512-k)); %%vector autocorrelacion "coseno angulo q forman las dos señales"
end    
R = r(1:p);%forma la matriz de autocorrelacio
r = r(2:(p+1));%r_1,r_2...r_p
%%matriz autocorrelacion
for i=2:p
    R(:,i) = [R(i,1); R(1:p-1,i-1)];
end
%%estimadores coeficientes filtros digital
a= -inv(R)*r; 
f = fs*(0:(l/2))/l;
P2 = abs(fft(x)/l);
X = P2(1:l/2+1);
X(2:end-1) = 2*X(2:end-1);%Transformada tal cual como hacen en las sugerencias de mathlab
H = freqz(1,[1;a],l/2+1); %%filtro
H = abs(H);
H = H*max(X)/max(H); %%ajuste ganancia, asumiendo los picos
H = 20*log10(H);
X = 20*log10(X);
figure('Color','White');
plot(f,X,'b-',f,H,'r');
title(['Respuesta de la cavidad resonante y filtro con p =' ,num2str(p)])
xlabel('f [Hz]')
ylabel('20*log(|P(f)|)');
figure('Color','White');
zplane(1,[1;a]');
title('Polos del sistema en el plano Z')
xlabel('Parte Real');
ylabel('Parte Imaginaria');
P = pole(tf(1,[1;a]'));
f1=fs*angle(P(1))/(2*pi);
f2=fs*angle(P(3))/(2*pi);
