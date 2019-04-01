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
zs=sum(abs(diff(sign(e))))/512/2;
zsi=sum(abs(diff(sign(si))))/512;

WL=256;
WD=8;
NW=floor((L-WL)/WD);
for i=1:NW
    y=x((i-1)*WD+(1:WL));
    E(i)=y'*y/WL;
    Z(i)=sum(abs(diff(sign(y))))/WL/2;
end

t=(0:L-1)'/fs;
t1=(floor(WL/2)+WD*(0:NW-1)')/fs;
E=10*log10(E);
E=(E-min(E))/(max(E)-min(E));
Z=(Z-min(Z))/(max(Z)-min(Z));
plot(t,x)
hold on
plot(t1,E)
plot(t1,Z)


silencio=zeros(length(Z),1);
for j=1:length(Z)-1
    if((E(j)<0.2) & (Z(j)>0.3))
        silencio(j)=1;
    else
        silencio(j)=0;
    end
end
plot(t1,silencio)
legend('x','E','Z','silencio')