x = [-1,-2, 2];
y = [2,4,1];
x2 = linspace(-3,3,30)
a = polyfit(x,y,2);
b = polyval(a,x2);
plot(x2,b,'-r')
title('Interpolation using "polyfit"')
hold on
plot(x,y,'*k')
