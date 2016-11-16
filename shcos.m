function [C,b,e]=shcos(lmcosi,l)
% [C,b,e]=SHCOS(lmcosi,l)

% Modified by Dr. David Bailey, Proff, UofT, January 2007
% Modified by fjsimons@alum.mit.edu, MIT, February 2004

% Retrieves cosine coefficients of degree l from 
% a matrix (or vector) listing
% (l m) Ccos (Csin)  (sorted but can start anywhere)
% Ccos               (sorted and starting at zero)
%
% OUTPUT
% 
% C     The relevant coefficients
% b     Row number of the first one in lmcosi
% e     Row number of the last one in lmcosi
%
% See also SHSIN

if size(lmcosi,2)==1
  lmin=0;
else
  lmin=min(lmcosi(:,1));
end

b=addmup(l-1)+1-addmup(lmin-1);
e=addmup(l)-addmup(lmin-1);

if size(lmcosi,2)==1
  C=lmcosi(b:e,1);
else
  C=lmcosi(b:e,3);
end

