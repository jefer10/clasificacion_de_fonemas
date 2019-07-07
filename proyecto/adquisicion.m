clc
clear all
fs=8000;
nBits=24;
nChannel=1;
tiempo=4;
disp('identificar señales');
disp('pronuncie la vocal que desea ser identificadas');
Audio=audiorecorder(fs,nBits,nChannel);
disp('comenzo a grabar');
recordblocking(Audio,tiempo);
disp('finalizo la gravacion');
%almacenamiento de señal en un arreglo double
x = getaudiodata(Audio);
x = x(3200:length(x));
%Reproduce el audio que acaba de ser grabado
Reproducir = audioplayer(x,fs);
play(Reproducir);
%filtro de bajas frecuencias
[N, Fn , A,W] = firpmord([0 30 3950 4000],[0 1 0] ,[1 1 1]/200,fs);
h = firpm(N,Fn,A,W);
x = conv(h,x);
plot(x)
gg=LPCx(x);




function a = LPCx (x)
p = 12; %% polos...frecuancias resonancia
L=length(x)
r = zeros(p+1,1);
for k=0:p
    r(k+1) = x((k+1):400)'*x(1:(400-k)); %%vector autocorrelacion "coseno angulo q forman las dos señales"   
end    
R = r(1:p);
r = r(2:(p+1));
%%matriz autocorrelacion
for i=2:p
    R(:,i) = [R(i,1); R(1:p-1,i-1)];
end
a= -inv(R)*r; 
end

