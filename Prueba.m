H=tf([1/(2*pi*3000) 0],[1/(2*pi*3000) 1])
Hd=c2d(H,1/8000)
step(Hd,H)
%%
H = tf([1/0.625 0],[1/0.625 1],1/8000)
Hc = d2c(H)
figure
h=bodeplot(H);
setoptions(h,'FreqUnits','Hz','PhaseVisible','off');
figure
h=bodeplot(Hc);
setoptions(h,'FreqUnits','Hz','PhaseVisible','off');
%%
u=ones(512,1);
%u(20)=1;
x=zeros(512,1);
for n=2:512
    x(n)= (u(n-1)-x(n-1))*0.625;
end
plot(x);