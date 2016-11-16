function [S,b,e]=shsin(lmcosi,l)
% [S,b,e]=SHSIN(lmcosi,l)

% Modified by Dr. David Bailey, Proff, UofT, January 2007
% Modified by fjsimons@alum.mit.edu, MIT, February 2004

% Retrieves the sine coefficients from a matrix listing
% a matrix (or vector) listing
% (l m Ccos) Csin  (sorted but can start anywhere)
% Csin             (sorted and starting at zero)
%
% OUTPUT
% 
% S     The relevant coefficients
% b     Row number of the first one in lmcosi
% e     Row number of the last one in lmcosi
%
% See also SHCOS

if size(lmcosi,2)==1
  lmin=0;
else
  lmin=min(lmcosi(:,1));
end

b=addmup(l-1)+1-addmup(lmin-1);
e=addmup(l)-addmup(lmin-1);

if size(lmcosi,2)==1
  S=lmcosi(b:e,1);
else
  S=lmcosi(b:e,4);
end

