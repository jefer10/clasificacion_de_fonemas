clear all;
close all;
[x,fs]=audioread('vozfemenina.wav');
L=length(x);
t=(0:L-1)'/fs;
plot(t,x)
s=x(600+(0:511));
e=x(1650+(0:511));
si=x(17500+(0:511));
ES=s'*s/512;
Ee=e'*e/512;
zs=sum(abs(diff(sign(s))))/512/2;
ze=sum(abs(diff(sign(e))))/512/2;
zsi=sum(abs(diff(sign(si))))/512/2;
WL=256;
WD=8;
NW=floor((L-WL)/WD);%Obtiene numero de Ventanas
E=zeros(NW,1);%Declara arreglo
Z=zeros(NW,1);%Declara arreglo
for i=1:NW
    y=x((i-1)*WD+(1:WL));%asigna la ventana 
    E(i)=y'*y/WL;%saca energia de ventana
    Z(i)=sum(abs(diff(sign(y))))/WL/2;%saca energia de ventana
end

t=(0:L-1)'/fs;
t1=(floor(WL/2)+WD*(0:NW-1)')/fs;%saca las partes en x de ventana
E=10*log10(E);%pasa energia a dB
E=(E-min(E))/(max(E)-min(E));%Ubica en el rango 0 a 1
Z=(Z-min(Z))/(max(Z)-min(Z));
subplot(2,1,1);
plot(t,x,'Color','red')
hold on
plot(t1,E,'Color','blue')
plot(t1,Z,'Color','black')
legend('x','E','Z');

silencio=zeros(length(Z),1);
if((E(1)<0.2)&&(Z(1)>0.33))
    silencio(1)=1;
else
    silencio(1)=0;
end
for j=1:length(Z)-1
    if(E(j)<0.216)
        if((Z(j)>Z(j+1))&&(Z(j+1)<0.18))%anterior mayor que la presente 
            silencio(j+1)=0;%Se apaga
        elseif ((Z(j)<Z(j+1))&&(Z(j+1)>0.33))%la anterior menor que la presente
            silencio(j+1)=1;%prende            
        else
            silencio(j+1)=silencio(j);%mantiene
        end        
    else
        silencio(j)=0;
    end
end
subplot(2,1,2);
plot(t1,silencio,'Color','blue')
hold on;
plot(t,x,'Color','red')
legend('x','Silencios');
ax = gca;
ax.YLim = [0 1.2]; 