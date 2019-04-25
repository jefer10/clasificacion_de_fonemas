clear all;
close all;
%[x1,fs]=audioread('vozjefer.wav');
%x=x1(:,2);
[x,fs]=audioread('vozfemenina.wav');
%sound(x,fs)
L=length(x);
t=(0:L-1)'/fs;
x=x/(abs(max(x)));
WL=256;
WD=8;
NW=floor((L-WL)/WD);%Obtiene numero de Ventanas
E=zeros(NW,1);%Declara arreglo
Z=zeros(NW,1);%Declara arreglo
for i=1:NW
    y=(x((i-1)*WD+(1:WL)));%asigna la ventana
    E(i)=y'*y/WL;
    Z(i)=sum(abs(diff(sign(y))))/WL/2;%saca energia de ventana
end
E=10*log(E);
t=(0:L-1)'/fs;
t1=(floor(WL/2)+WD*(0:NW-1)')/fs;%saca las partes en x de ventana
E=(E-min(E))/(max(E)-min(E));%Ubica en el rango 0 a 1
Z=(Z-min(Z))/(max(Z)-min(Z));
%hold on
%plot(t,x,'Color','red')
%plot(t1,E,'Color','blue')
%plot(t1,Z,'Color','black');
%legend('x','E','Z');
vocalizados=zeros(length(Z),1);
 for k=1:length(Z)
    if(E(k)>0.67)
        vocalizados(k)=1;
    else
        vocalizados(k)=0;
    end
 end
figure('Name','Vocalizados');
hold on;
plot(t1,vocalizados,'Color','blue')
plot(t,x,'Color','magenta')
legend('Vocalizados1','x');
ax = gca;
ax.YLim = [0 1.2];
%%
T=32;
%T=WD;
H=0.54-0.46*cos(2*pi*((1:WL)/WL));
r=zeros(WL+1,1);
my=[];
mx=[];
maximo=zeros(NW,1);
maximo1=zeros(NW,1);

for n=1:NW
if (vocalizados(n)==1)
       s=(x((n-1)*WD+(1:WL)));
       s=s.*H';
       for j=0:T
            r(j+1)=s(j+(1:(WL-T)))'*s(1:(WL-T));
       end
       [pks,locs] = findpeaks(r);
       %r=flipud(r);
       valorx=find(pks==max(pks));
       
       if locs(valorx) < 15
           ii=valorx;
           tt=locs(valorx);
           while ii<=length(locs) %el error es por el while 
               if tt<15
                   tt=locs(ii);
               else
                   valorx=ii;
                   break;
               end
               valorx=ii;
               ii=ii+1;
           end
       end
       
       maximo1(n)=locs(valorx);
       maximo(n)=fs/locs(valorx);
       %break
end
end
% hold on;
%plot(r);
figure('Name','Frecuencia');
%plot(r)
hold on;
subplot(2,1,1);
%figure('Name','Frecuencia_final');
maximo=log10(maximo);
plot(t1,maximo,'o');
subplot(2,1,2);
%figure('name','señal')
plot(t,x);