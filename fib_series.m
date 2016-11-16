clear all
format shortEng
clc
a = 1
b = 1
f = [a b];
for m = 3:100;
    c = a+b;
    a = b;
    b = c;
    f(m) = c;
    
end
f(50)

