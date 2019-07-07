clc ;clear all;close all;
[x1,fs]=audioread('aaaas.wav');
x=x1((133179:162401),1);
%%plot(x1)
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
%%
save BaseA.mat;%Crea el archivo de la base de datos
BaseAObject = matfile('BaseA.mat','Writable',true);
%%
load('BaseA.mat','V');%carga la base de datos
V=[V,V1];% concatena datos
save('BaseA.mat','-append','V');%guarda nuevos datos
