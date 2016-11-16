function dydt = odefun(t,y,A,B)
dydt = zeros(2,1);
dydt(1,1) = y(2);
dydt(2,1) = (A/B)*t.*y(1);
end
