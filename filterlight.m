function monthsorted = filterlight(month)
G = 6.67300E-11;
M = 5.9736E24;
r = 6378137000;
g = 9.80665;
monthsorted = sortrows(month,1);

%set the orders 1 and 2 to zero
monthsorted(1:6,3:4) = 0;

%Multiply the sin and cos coeffiecents by GM/gr to convert to a geoid
[monthsorted(:,3:4)] = (monthsorted(:,3:4)*G*M)/(g*r);

%Filter the data with a light filter
filterlight = exp(-(monthsorted(:,1)/5).^2);

%Apply Filter (either heavy or light)
[monthsorted(:,3)] = monthsorted(:,3).*filterlight;
[monthsorted(:,4)] = monthsorted(:,4).*filterlight;
end
