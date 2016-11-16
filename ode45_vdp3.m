u = 1;
tspan = [0 20];
y0 = [2 0];
[t,y] = ode45(@(t,y) vdp2(t,y,u), tspan, y0);

plot(t,y(:,1), '-o',t,y(:,2), '-')