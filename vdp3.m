function dydt = vdp3(t,y,u)

dydt = zeros(2,1);
dydt(1,1) = y(2);
dydt(2,1) = u*(1-y(1)^2)*y(2)-y(1);
end