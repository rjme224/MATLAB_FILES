function varargout=plm2xyz(lmcosi,degres)
% [r,lon,lat]=PLM2XYZ(lmcosi,degres)

% Modified by Dr. David Bailey, Proff, UofT, January 2007
% Modified by fjsimons@alum.mit.edu, MIT, January 2004

% Inverse spherical harmonic transform.
%
% Compute a gridded field from spherical harmonic coefficients as:
% [l m Ccos Csin] (not necessarily starting from zero, but sorted),
% with degree resolution 'degres' [default: Nyquist degree]
% Spatial grid is contained in [0 360 -90 90].
% Using Schmidt-normalized spherical harmonics now normalized to 4pi.
%
% INPUT:
%
% lmcosi        Matrix listing l,m,cosine and sine coefficients
% degres        Longitude and latitude spacing, in degrees
% 
% OUTPUT:
%
% r             The field
% lon,lat       The grid, in degrees
% 
% EXAMPLE:
%
% plm2xyz('demo1')
% plm2xyz('demo2',fra) % with 'fra' a data fraction
%
% See also XYZ2PLM, PLM2SPEC, TH2PL, PL2TH

if ~isstr(lmcosi)
  t0=clock;
  lmin=lmcosi(1);
  % L=min(lmcosi(end,1),255);
  L=lmcosi(end,1);
  % if L>255  % out by rcb
  if L>400 % in by rcb
    disp('Using Libbrecht algorithm');
    libb=1;
  else 
    libb=0;
  end
  % Default resolution is the Nyquist degree; return equal sampling in
  % longitude and latitude; sqrt(L*(L+1)) is equivalent wavelength
  degN=180/sqrt(L*(L+1));
  defval('degres',degN);
  if degres>degN
    warning('Function undersampled. Aliasing will occur.')
  end
  nlon=ceil(360/degres+1);
  nlat=ceil(180/degres+1);
  % Longitude: Assumed to be complete
  phi=linspace(0,2*pi,nlon);
  % Colatitude: Assumed to be complete
  theta=linspace(0,pi,nlat);

  % Initialize grid
  r=repmat(0,nlat,nlon); r2=r;

  % Get Legendre function values
  fnpl=sprintf('%s/LSSM-%i-%i.mat',...
	       fullfile(getenv('IFILES'),'LEGENDRE'),L,nlat);
  
if exist(fnpl,'file')==2
    eval(sprintf('load %s',fnpl))
  else  
    % Evaluate Legendre polynomials at selected points
    Plm=repmat(NaN,length(theta),addmup(L));
    h=waitbar(0,'Evaluating all Legendre polynomials');
    in1=0;
    in2=1;
    % Always start from the beginning
    for l=0:L
      if libb==0
	Plm(:,in1+1:in2)=(legendre(l,cos(theta(:)'),'sch')*sqrt(2*l+1))';
      else
	Plm(:,in1+1:in2)=(libbrecht(l,cos(theta(:)'),'sch')*sqrt(2*l+1))';
      end
      in1=in2;
      in2=in1+l+2;
      waitbar((l+1)/(L+1),h)
    end
    delete(h)
    savefile = [fullfile(getenv('IFILES'),'LEGENDRE') num2str(L) num2str(length(theta))];  % RCBailey mod
    save(savefile);  % RCBailey mod
    clear savefile;  % RCBailey mod
%     eval(sprintf('save %s\LSSM-%i-%i Plm ',...  % RCBailey mod
% 		 fullfile(getenv('IFILES'),'LEGENDRE'),L,length(theta)))  % RCBailey mod
  end
  
  % Loop over the degrees
  more off
  disp(sprintf('PLM2XYZ Expansion from %i to %i',lmin,L))
  for l=lmin:L
    % Compute Schmidt-normalized Legendre functions at 
    % the cosine of the colatitude (=sin(lat)) and 
    % renormalize them to the area of the unit sphere
    
    % Always start from the beginning
    b=addmup(l-1)+1;
    e=addmup(l);

    plm=Plm(:,b:e)';

    m=0:l;
    mphi=m(:)*phi(:)';
    
    % Normalization of the harmonics is to 4\ pi, the area of the unit
    % sphere: $\int_{0}^{\pi}\int_{0}^{2\pi}
    % |P_l^m(\cos\theta)\cos(m\phi)|^2\sin\theta\,d\theta d\phi=4\pi$.
    % Note the |cos(m\phi)|^2 d\phi contributes exactly \pi for m~=0
    % and 2\pi for m==0 which explains the absence of sqrt(2) there;
    % that fully normalized Legendre polynomials integrate to 1/2/pi
    % that regular Legendre polynomials integrate to 2/(2l+1),
    % Schmidt polynomials to 4/(2l+1) for m>0 and 2/(2l+1) for m==0,
    % and Schmidt*sqrt(2l+1) to 4 or 2. Note that for the integration of
    % the harmonics you get either 2pi for m==0 or pi+pi for cosine and
    % sine squared (cross terms drop out). This makes the fully
    % normalized spherical harmonics the only ones that consistently give
    % 1 for the normalization of the spherical harmonics.
    % Test normalization as follows (using inaccurate Simpson's rule):
    % Note this is using the cosines only; the "spherical harmonics" are
    % actually only semi-normalized.
    defval('tst',0);
    if tst
      f=(plm.*plm)'.*repmat(sin(theta(:)),1,l+1);
      c=(cos(mphi).*cos(mphi))';
      ntest=simpson(theta,f).*simpson(phi,c)/4/pi;
      disp(sprintf('Mean Normalization Error l= %3.3i: %8.3e',...
		   l,(sum(abs(1-ntest)))/(l+1)))
      % For a decent test you would use "legendreprodint"
    end

    % Find the cosine and sine coefficients for this degree
    clm=shcos(lmcosi,l);
    slm=shsin(lmcosi,l);
    
    fac1=repmat(clm,1,nlon).*cos(mphi)+...
	 repmat(slm,1,nlon).*sin(mphi);
  
    fac2=repmat(clm,1,nlon);
    
    % Sum over all orders and (through loop) over all degrees
    % These are the real spherical harmonics:
    ylm=plm'*fac1;
    ylm2=plm'*fac2;
    r=r+ylm;
    r2=r2+ylm2;;
  end
  
  lon=phi*180/pi;
  lat=90-theta*180/pi;
  
  vars={'r','lon','lat'};
  for index=1:nargout
    varargout{index}=eval(vars{index});
  end
  
  disp(sprintf('PLM2XYZ (Synthesis) took %8.4f s',etime(clock,t0)));

elseif strcmp(lmcosi,'demo1')
  lmax=30; [m,l,mzero]=addmon(lmax);
  c=randn(addmup(lmax),2).*([l l].^(-1)); 
  c(1)=3; c(mzero,2)=0; lmcosi=[l m c];
  L=30;
  [r,lon,lat]=plm2xyz(lmcosi,180/sqrt(L*(L+1)));
  C1=xyz2plm(r,L,'simpson');
  C2=xyz2plm(r,L,'gl');
  C3=xyz2plm(r,L,'im');
  lat=linspace(90,-90,size(r,1));
  C4=xyz2plm(r,L,'im',lat);
  C5=xyz2plm(r,L,'irr');
  clf
  ah(1)=subplot(211);
  p1(1)=plot(abs(lmcosi(:,3)-C1(1:addmup(lmax),3)),'b+-'); hold on
  p1(2)=plot(abs(lmcosi(:,3)-C2(1:addmup(lmax),3)),'rv-')
  p1(3)=plot(abs(lmcosi(:,3)-C3(1:addmup(lmax),3)),'kx-');
  p1(4)=plot(abs(lmcosi(:,3)-C4(1:addmup(lmax),3)),'go-'); 
  p1(5)=plot(abs(lmcosi(:,3)-C5(1:addmup(lmax),3)),'mo-'); hold off 
  legend('simpson','gl','im','imlat','irr')
  ylim([-0.1 1]*1e-14)
  yl(1)=ylabel('Absolute error');
  xl(1)=xlabel('Cumulative degree and order');
  ah(2)=subplot(212);
  p2(1)=plot(abs(lmcosi(:,3)-C1(1:addmup(lmax),3)),'b+-'); hold on
  p2(2)=plot(abs(lmcosi(:,3)-C2(1:addmup(lmax),3)),'rv-')
  p2(3)=plot(abs(lmcosi(:,3)-C3(1:addmup(lmax),3)),'kx-');
  p2(4)=plot(abs(lmcosi(:,3)-C4(1:addmup(lmax),3)),'go-'); 
  p2(5)=plot(abs(lmcosi(:,3)-C5(1:addmup(lmax),3)),'mo-'); hold off 
  yl(2)=ylabel('Absolute error');
  xl(2)=xlabel('Cumulative degree and order');
  longticks(ah)
  set([p1 p2],'MarkerS',4)
  set([xl yl],'FontS',15)
  axis tight
  legend('simpson','gl','im','imlat','irr')
  fig2print(gcf,'landscape')
  figdisp
elseif strcmp(lmcosi,'demo2')
  lmax=10; L=10;
  [m,l,mzero]=addmon(lmax);
  c=randn(addmup(lmax),2).*([l l].^(-1)); 
  c(1)=3; c(mzero,2)=0; lmcosi=[l m c];
  [r,lon,lat]=plm2xyz(lmcosi,180/sqrt(L*(L+1)));
  tol=length(lon)*length(lat);
  defval('degres',0.4)
  fra=degres;
  unform=2;
  [LON,LAT]=meshgrid(lon,lat);
  if unform==1
    % Not really uniform
    indo=indeks(shuffle([1:tol]'),1:ceil(fra*tol));
    lonr=LON(indo);
    latr=LAT(indo);
  else 
    % Really uniform on the sphere
    [lonr,latr]=randsphere(ceil(fra*tol));
    indo=sub2ind(size(r),ceil(scale(latr,[1 length(lat)])),...
		 ceil(scale(lonr,[1 length(lon)])));
    lonr=LON(indo);
    latr=LAT(indo);
  end
  C6=xyz2plm(r(indo),L,'irr',latr,lonr);
  clf
  ah(1)=subplot(221);
  plotplm(r,lon*pi/180,lat*pi/180,1)
  xl(1)=title('Input');
  hold on
  [x,y]=mollweide(lonr*pi/180,latr*pi/180);
  p1=plot(x,y,'o');
  ck=caxis;
  cb(1)=colorbar('hor');
  ah(2)=subplot(222);
  rec=plm2xyz(C6);
  plotplm(rec,lon*pi/180,lat*pi/180,1)
  hold on
  p4=plot(x,y,'o');
  xl(2)=title('Reconstruction');
  caxis(ck)
  cb(2)=colorbar('hor');
  ah(3)=subplot(223);
  ps(1)=plot([0:L],plm2spec(lmcosi),'bo-');
  hold on
  ps(2)=plot([0:L],plm2spec(C6),'rv-');
  set(ps(1),'MarkerE','b','MarkerF','r','LineW',2,'MarkerS',4)
  set(ps(2),'MarkerE','r','MarkerF','r','LineW',2,'MarkerS',4)
  set(gca,'Yscale','log'); grid
  xl(3)=xlabel('Degree');
  yl(1)=ylabel('Power');
  xl(5)=title(sprintf('Spectral comparison, %s=%3.1f','\alpha',fra));
  lg=legend('Input','Recovered');
  ah(4)=subplot(224);
  difo=abs(r-rec);
  difo(difo<1e-12)=NaN;
  plotplm(difo,lon*pi/180,lat*pi/180,1)
  hold on
  p3=plot(x,y,'o');
  set([p3 p1 p4],'MarkerE','k','MarkerF','k','MarkerS',2)
  xl(4)=title('Difference > 10^{-12}');
  caxis(ck)
  cb(3)=colorbar('hor');
  set([xl yl],'FontS',15)
  longticks(ah)
  movev(cb,-.03)
  kelicol
  fig2print(gcf,'landscape')
  figdisp('plm2xyz_demo')
end

