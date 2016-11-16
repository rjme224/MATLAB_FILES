function excess_water = ESWD(month)
a = 6.378137e6;
rho_e = 5515.3;
rho_w = 1000;
load('love');
sigma(1,:) = 1;
q = 2;
rhoterm = (a/3)*(rho_e/rho_w);
for i = 1:60;
    for j = 1:(i+1);
        sigma(q,:) = (2*((i)+1)./(1+love(i+1,2)));
        q = q+1;

    end
end
[month(:,3:4)] = month(:,3:4).*rhoterm;
% [month(:,4)] = month(:,4).*rhoterm
% 
[month(:,3)] = month(:,3).*sigma;
excess_water = month;
end