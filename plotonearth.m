function varargout=plotonearth(data,conts,proj,lon,lat)
% PLOTONEARTH(data)  % No longer RCB
% PLOTONEARTH(data,1) with continents
% PLOTONEARTH(data,1,'mercator') in 'mercator' rather than 'globe' projection
% PLOTONEARTH(data,1,lon,lat) if it matters where

% Modified by Dr. David Bailey, Proff, UofT, January 2007
% Modified by fjsimons@alum.mit.edu, MIT, June 2003

% h=PLOTONEARTH returns axis handle to the continents
%
% Plots data on a globe, with continents or not.
% Without relief but with optional continents, and with
% the possibility of an absolute coordinate frame.
%
% See also PLOTONSPHERE, PLOTPLM

defval('conts',1);
defval('proj','globe');
defval('lon',[]);
defval('lat',[]);

if ~isempty(lon)
  if size(data)~=size(lon) | size(data)~=size(lat)
    error('Error in plotonearth1: Wrong size arrays')
  end
end

[nlats,nlons] = size(data);

if isempty(lon)
  % Make sphere for the data
  lons=linspace(0,360,nlons);
  lats=linspace(90,-90,nlats);
  [lons,lats]=meshgrid(lons,lats);
else
  lons=lon;
  lats=lat;
end

rads=ones(size(lats));

if(strcmp('mercator',proj))
    pcolor(lons,lats,data);
else
    lons=lons/180*pi;
    lats=lats/180*pi;
    [x,y,z]=sph2cart(lons,lats,rads);
    size(x);

    surface(x,y,z,'FaceColor','texture','Cdata',data);
end;
axis image;
shading flat;
hold on;

if conts==1
    % Plot the continents
    load coast;
    if(strcmp('mercator',proj))
        coast(:,1) = mod(coast(:,1),360);
        plot(coast(:,1),coast(:,2),'.k','MarkerSize',1);
        box on
    else
        lonc=coast(:,1)/180*pi;
        latc=coast(:,2)/180*pi;
        rad=repmat(1.001,size(latc));
        [xx,yy,zz]=sph2cart(lonc,latc,rad);
        pc=plot3(xx,yy,zz,'k-','LineWidth',1);
        box on
    end;
end

nargs={'pc'};
for ind=1:nargout
  varargout{ind}=eval(nargs{ind});
end

hold off;