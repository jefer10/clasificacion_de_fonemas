clc,clear all
A=matfile('BaseA12.mat');
E=matfile('BaseE12.mat');
I=matfile('BaseI12.mat');
O=matfile('BaseO12.mat');
U=matfile('BaseU12.mat');
valA=matfile('val_A.mat');
valE=matfile('val_E.mat');
valI=matfile('val_I.mat');
valO=matfile('val_O.mat');
valU=matfile('val_U.mat');
A=A.V;
E=E.V;
I=I.V;
O=O.V;
U=U.V;

valA=valA.val;
valE=valE.val;
valI=valI.val;
valO=valO.val;
valU=valU.val;

% valA=valA';
% valE=valE';
% valI=valI';
% valO=valO';
% valU=valU';
entreno=[A E I O U];

entreno12=[A(:,(length(A)-1000:end)) E(:,(length(E)-1000:end)) I(:,(length(I)-1000:end)) O(:,(length(O)-1000:end)) U(:,(length(U)-1000:end))];
validacion12=cat(1,valA(length(A)-1000:end),valE(length(E)-1000:end));
validacion12=cat(1,validacion12,valI(length(I)-1000:end));
validacion12=cat(1,validacion12,valO(length(O)-1000:end));
validacion12=cat(1,validacion12,valU(length(U)-1000:end));

entreno=entreno';
etiquetas=cat(1,valA,valE);
etiquetas=cat(1,etiquetas,valI);
etiquetas=cat(1,etiquetas,valO);
etiquetas=cat(1,etiquetas,valU);
validacion=etiquetas;
