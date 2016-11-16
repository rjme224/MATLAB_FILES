% 
% x = rand(100000,1);
% f = (x<.6);
% p = sum(f);
% q = sum(1-f);
% [p/length(x),q/length(x)]*100
f = [];
p = 1/6;
for i = 1:10000;
    n = 0;
    for j = 1:20;
        if (rand() < p);
            n = n+1;
            if (n==1) y(i)=j;
            end
        end
    end
end
for i = 1:20;
    f(i) = sum(y==i);
end
bar(f)
X = [1:20];
sum(X.*f/10000)