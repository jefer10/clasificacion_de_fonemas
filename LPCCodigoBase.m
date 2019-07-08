clc ;clear all;
%close all;
x = audioread('vozfemenina.wav');
x = x(1650+(1:512)).*hamming(512);%%e%%
%%filtro pre enfasis%%enfatizar frecuencias altas%%mirar frecuencias
%%resonantes
for n=2:512
    x(n)= x(n) -0.625*x(n-1);
end
%%construccion matriz autocorrelacion y coeficientes de autocorrelacion
p = 6; %% polos...frecuancias resonancia
r = zeros(p+1,1);

for k=0:p
    r(k+1) = x((k+1):512)'*x(1:(512-k)); %%vector autocorrelacion "coseno angulo q forman las dos señales"
end    

R = r(1:p);
r = r(2:(p+1));
%%matriz autocorrelacion
for i=2:p
    R(:,i) = [R(i,1); R(1:p-1,i-1)];
end
%%estimadores coeficientes filtros digital
a= -inv(R)*r; 

X = fft(x,2048) ; X = abs(X(1:1024));

H = freqz(1,[1;a],1024); %%filtro
H = abs(H);
H = H*max(X)/max(H); %%ajuste ganancia, asumiendo los picos
X = 20*log10(X);
H = 20*log10(H);
w = (0:1023)'*pi/1024%%rad/muestra
figure;
plot(w,X,'b-',w,H,'r');