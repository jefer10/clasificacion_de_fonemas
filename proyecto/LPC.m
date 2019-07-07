clc ;clear all;close all;
[x1,fs]=audioread('eeeees.wav');
RI=[7.565e4,1.262e5,1.888e5,2.532e5,3.184e5,4.265e5,6.001e5,8.34e5,1.037e6,1.118e6,1.187e6];
RD=[1.037e5,1.525e5,2.21e5,2.786e5,3.534e5,4.69e5,6.789e5,9.038e5,1.076e6,1.145e6,1.235e6];
m=length(RI);
for y=1:m %i en tiempo
x=x1((RI(y):RD(y)),1);
l = length(x);        % Length of signal
t=(0:l-1)'/fs;
wl=128;
wd=wl/4;
tiempo_total=length(t);
nw=floor((l-wl)/wd);
tiempo_ventana=(tiempo_total/nw)/fs;
f = fs*(0:(wl/2))/wl;
%%construccion matriz autocorrelacion y coeficientes de autocorrelacion
p = 6; %% polos...frecuancias resonancia
r = zeros(p+1,1);
V1=zeros(6,nw);
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
V1(:,i)=a;
end
if(y<2)
    V=V1; %Se corre la primera vez
    save BaseE.mat V;%Crea el archivo de la base de datos
else
    load('BaseE.mat','V');%carga la base de datos
    V=[V,V1];% concatena datos
    save('BaseE.mat','-append','V');%guarda nuevos datos
end
end