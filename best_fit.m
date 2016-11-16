x = [0,3,6, 11];
x2 = linspace(-2,15,50);
y = [20, 65, 92, 97];
a = polyfit(x,y,2)
b = polyval(a,x2);


figure
plot(x,y,'*')
hold on
plot(x2,b,'-b')
text(5,15,'f(x) = -x+18x+20')