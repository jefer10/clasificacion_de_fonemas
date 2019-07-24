clc,clear all
A=matfile('A.mat');
E=matfile('E.mat');
I=matfile('I.mat');
O=matfile('O.mat');
U=matfile('U.mat');
A=A.LPC_C;
E=E.LPC_C;
I=I.LPC_C;
O=O.LPC_C;
U=U.LPC_C;
valA=ones(1,25);
valE=ones(1,25);
valI=ones(1,25);
valO=ones(1,25);
valU=ones(1,25);

valA=valA.*'a';
valE=valE.*'e';
valI=valI.*'I';
valO=valO.*'O';
valU=valU.*'U';
x=[A E I O U];

t=[valA valE valI valO valU]
validacion12Q=cat(1,valA,valE);
validacion12Q=cat(1,validacion12Q,valI);
validacion12Q=cat(1,validacion12Q,valO);
validacion12Q=cat(1,validacion12Q,valU);
%t=validacion12Q;