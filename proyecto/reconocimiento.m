clc
clear all
red=load('red.mat');%% carga donde esta la red entrenada

%% adquisicion de la se�al
fs=8000;
nBits=24;
nChannel=1;
tiempo=2;
disp('identificar señales');
disp('pronuncie la vocal que desea ser identificadas');
Audio=audiorecorder(fs,nBits,nChannel);
disp('comenzo a grabar');
recordblocking(Audio,tiempo);
disp('finalizo la gravacion');
%%almacenamiento de se�al en un arreglo double
x = getaudiodata(Audio);
%Reproduce el audio que acaba de ser grabado
Reproducir = audioplayer(x,fs);
play(Reproducir);

%% filtro de bajas frecuencias
[N, Fn , A,W] = firpmord([0 30 3950 4000],[0 1 0] ,[1 1 1]/200,fs);
h = firpm(N,Fn,A,W);
x = conv(h,x);
plot(x)
%% calculo LPC
DATOS_ENTRADA=LPCx(x);
%% red neuronal
neuronas=red.net;
%view(neuronas);
y=sim(neuronas,DATOS_ENTRADA)
%% visualizacion de la salida de la neurona. 
if y<99
    disp('la vocal fue "A"');
else
    if (y >=99 && y<103)
        disp('la vocal fue "E"');
    else
        if (y >=103 && y<108 )
            disp('la vocal fue "I"');
        else
            if (y >=108 && y<114 )
                disp('la vocal fue "O"');
            else
                if y>=114
                    disp('la vocal fue "U"');
                else
                    disp('la vocal no fue detectada ');
                end
            end
        end
    end
end


%% funcion de LPC
function a = LPCx (x)
p = 6; %% polos...frecuancias resonancia
L=length(x)
r = zeros(p+1,1);
for k=0:p
    r(k+1) = x((k+1):L)'*x(1:(L-k)); %%vector autocorrelacion "coseno angulo q forman las dos señales"   
end    
R = r(1:p);
r = r(2:(p+1));
%%matriz autocorrelacion
for i=2:p
    R(:,i) = [R(i,1); R(1:p-1,i-1)];
end
a= -inv(R)*r; 
end

