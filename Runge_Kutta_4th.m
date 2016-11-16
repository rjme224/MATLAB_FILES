clear, clc
h = 0.2
u = 1
x = 0
for i = x
    k1 = h*RK4(x,u);
    k2 = h*RK4((x+h/2),(u+k1/2));
    k3 = h*RK4((x+h/2), (u+k2/2));
    k4 = h*RK4((x+h), (u+k3));
    u = u+(k1/6)+(k2/3)+(k3/3)+(k4/6)
end
    