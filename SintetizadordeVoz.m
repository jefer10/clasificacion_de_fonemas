clc; clear all; close all;

[x,fs] = audioread('vozfemenina.wav');
e = x(1700+(1:400)).*hamming(400);
m = x(11600+(1:400)).*hamming(400);
a = x(27800+(1:400)).*hamming(400);
i = x(22150+(1:400)).*hamming(400);
s = x(3100+(1:400)).*hamming(400);
o = x(30500+(1:400)).*hamming(400);
l = x(3600+(1:400)).*hamming(400);


aa = LPCx(a);
ae = LPCx(e);
ai = LPCx(i);
am = LPCx(m);
as = LPCx(s);
ao = LPCx(o);
al = LPCx(l);

d = (0:2047)'; 
d1 = double(d == 32*floor(d/32));%impulso cada 32 muestras
d2 = double(d == 30*floor(d/30));%impulso cada 30 muestras
d3 = double(d == 34*floor(d/34));%impulso cada 30 muestras


h = [0.1 0.6 1.0 0.9 0.8 0.6 0.4 0.1]; %% impulso glotal 
d1 = conv(d1,h);
d1 = d1(1:2048);
d2 = conv(d2,h);
d2 = d2(1:2048);
d3 = conv(d3,h);
d3 = d3(1:2048);


ya = filter(1,[1;aa]',d1);
ye = filter(1,[1;ae]',d1);
yi = filter(1,[1;ai]',d1);
ym = filter(1,[1;am]',d1);
%%%%
ys = filter(1,[1;as]',d1);
yo = filter(1,[1;ao]',d1);
yl = filter(1,[1;al]',d1);
%%%%%

ya2 = filter(1,[1;aa]',d2);
ye2 = filter(1,[1;ae]',d2);
yi2 = filter(1,[1;ai]',d2);
ym2 = filter(1,[1;am]',d2);

ya3 = filter(1,[1;aa]',d3);


en=[(0:511)'/512; ones(1024,1); (511:-1:0)'/512];

ya = en.*ya/max(abs(ya));
ye = en.*ye/max(abs(ye));
yi = en.*yi/max(abs(yi));
ym = en.*ym/max(abs(ym))/5;
%%%%%%
ys = en.*ys/max(abs(ys));
yo = en.*yo/max(abs(yo));
yl = en.*yl/max(abs(yl));
%%%%%%%%5


ya2 = en.*ya2/max(abs(ya2));
ye2 = en.*ye2/max(abs(ye2));
yi2 = en.*yi2/max(abs(yi2));
ym2 = en.*ym2/max(abs(ym2))/5;

ya3 = en.*ya3/max(abs(ya3));

y = zeros(12*2048,1);

% n =   0; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + yi;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ya;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + 1.5*ya2;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ye;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + yi;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
% n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ya3/1.5;

u=zeros(2048,1);
n =   0; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + yo;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + yl;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ya;

n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + u;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + u;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + u;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ye;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + u;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + u;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + 1.5*ya;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ym;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ya3;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ys*0.5;
n = n+1; y(n*1536+(1:2048)) = y(n*1536 + (1:2048)) + ys*0.50;

y = y(1:(n*1536+2048)); %%recorte
%y = [ym; yi; ym; ya; ym; ya; ym; ye; ym; yi; ym; ya];
%sound(y,fs)
%%¡Hola!¿me amas?

%y = [yo; yl; ya; ym; ye; ya; ym; ya; ys; ys];
sound(y,fs)

