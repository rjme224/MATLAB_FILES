% clear, clc
% x1d = linspace(0,1,20);
% y1d = linspace(0,1,20);
% [x2d y2d] = meshgrid(x1d,y1d);
% plot(x2d,y2d,'*k')
% 
% 
% f2d= exp(-5*(x2d.^2+y2d.^2))
% figure(1)
% contour(x2d, y2d, f2d,10)
% figure(2)
% surf(x2d,y2d,f2d)

x3d = linspace(-1,1,40);
y3d = linspace(-1,1,40);
[x4d,y4d] = meshgrid(x3d,y3d);
f4d = exp(-5*(x4d.^2+y4d.^2))

figure(3)
surf(x4d,y4d,f4d)
colormap('winter')
shading interp

