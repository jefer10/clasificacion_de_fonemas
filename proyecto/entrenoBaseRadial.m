x = entreno12;
t = validacion12';

error=0;
separacion=0.1;%separacion de las base radial de las neuronas
neuronas=10;%numero maximo de neuronas
df=1;%numero de neuronas que se adicionan
net = newrb(x,t,error,separacion,neuronas,df);
view(net)
save('red_base_radial.mat')