fs=8000;
nBits=24;
nChannel=1;
tiempo=3;
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