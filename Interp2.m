x = [-2 -1 2]';
A = [x.^2 x ones(size(x))]
Y = [-2; 1; -1]

interp1(x,Y,-2:2,'linear') 
