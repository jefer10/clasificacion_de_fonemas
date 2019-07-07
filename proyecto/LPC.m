clc ;clear all;close all;
[x1,fs]=audioread('I.wav');

%Parametros para la O

%RI=[1.15e5,1.818e5,3.38e5,3.93e5,5.414e5,8.219e5,1.031e6,1.141e6,1.27e6,6.657e5,2.411e5];
%RD=[1.718e5,2.281e5,3.733e5,4.6e5,6.052e5,8.5e5,1.054e6,1.19e6,1.313e6,7.20e5,2.876e5];

%Parametros para la I
RI=[8.683e4,1.391e5,2.179e5,2.976e5,3.792e5,4.756e5,5.51e5,6.837e5,7.842e5];
RD=[1.000e5,1.600e5,2.624e5,3.311e5,4.100e5,5.150e5,5.845e5,7.117e5,8.2e5];

%Parametros para la E
%RI=[7.565e4,1.262e5,1.888e5,2.532e5,3.184e5,4.265e5,6.001e5,8.34e5,1.037e6,1.118e6,1.187e6];
%RD=[1.037e5,1.525e5,2.21e5,2.786e5,3.534e5,4.69e5,6.789e5,9.038e5,1.076e6,1.145e6,1.235e6];
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
    save BaseI.mat V;%Crea el archivo de la base de datos
else
    load('BaseI.mat','V');%carga la base de datos
    V=[V,V1];% concatena datos
    save('BaseI.mat','-append','V');%guarda nuevos datos
end
end