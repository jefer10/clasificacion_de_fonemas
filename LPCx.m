function a = LPCx (x)
p = 12; %% polos...frecuancias resonancia
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

