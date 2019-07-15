clc ;clear all;close all;
%[x1,fs]=audioread('U.wav');
%x1=x1(:,1);
%plot(x1);
%sound(x1,fs)
m=matfile('BaseU.mat');
tt=m.V;
tam=size(tt);
val=ones(tam(2),1);
etiquetas='u';
for i=1:1:tam(2)
    val(i)=etiquetas;
end
save('val_U.mat','val')
