x = [0 3 6 11]
y = [20 65 92 97]

plot(x,y, '*')
interp = interp1(x,y,-1:12,'pchip', 'extrap')

hold on
plot(-1:12,interp,'-')
