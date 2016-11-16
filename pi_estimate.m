tic
n = 100000000
x = [];
y = [];
count = 0;
x = rand(n,1);
y = rand(n,1);
count = (x.^2+y.^2 <1);
countsum = sum(count)
pi = countsum/n*4
toc


