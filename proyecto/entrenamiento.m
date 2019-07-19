clc,clear all
A=matfile('BaseA.mat');
E=matfile('BaseE.mat');
I=matfile('BaseI.mat');
O=matfile('BaseO.mat');
U=matfile('BaseU.mat');
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
entreno=entreno';
etiquetas=cat(1,valA,valE);
etiquetas=cat(1,etiquetas,valI);
etiquetas=cat(1,etiquetas,valO);
etiquetas=cat(1,etiquetas,valU);
validacion=etiquetas;

%etiquetas=[valA valE valI valO valU];
% entreno=cat(2,A,E);
% entreno=cat(2,entreno,I);
% entreno=cat(2,entreno,0);
% entreno=cat(2,entreno,U);
etiquetas=zeros(5,59076);
etiquetas(1,1:9589)=1;%A
etiquetas(2,(9589+1):(9589+14077))=1;%E
etiquetas(3,(9589+14077+1):(9589+14077+8696))=1;%I
etiquetas(4,(9589+14077+8696+1):(9589+14077+8696+15985))=1;%O
etiquetas(5,(9589+14077+8696+15985+1):end)=1;%U
etiquetas=etiquetas';
% etiquetas=cat(1,valA,valE);
% etiquetas=cat(1,etiquetas,valI);
% etiquetas=cat(1,etiquetas,valO);
% etiquetas=cat(1,etiquetas,valU);
% etiquetas=etiquetas;

%% RED NEURONAL 
x = entreno';
%t = etiquetas';
t=validacion';
nn=min(min(x));
NN=max(max(x));
%x= x/norm(x);
%x=(x -nn)/(NN-nn);
%x=normalized;
%nn=0;
%NN=1;

f=[nn NN;nn NN;nn NN;nn NN;nn NN;nn NN];
arquitectura=[10 2 1];
net=newff(f,arquitectura,{'tansig' 'tansig' 'tansig'},'trainlm','learngdm','mse');    % Se genera la red neuronal a entrenar y se asignan los parametros de la misma

% net.trainParam.epochs = 10000;
% %net.trainParam.max_fail=1000;
% net.trainParam.min_grad=0;
% net.trainParam.time=100;
% net.trainParam.goal=1000;

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
for i=0:5
[net,tr] = train(net,x,t);
% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)
end
% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)
