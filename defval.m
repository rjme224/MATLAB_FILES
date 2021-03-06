function defval(name,value)
% DEFVAL(name,value)

% Modified by Dr. David Bailey, Proff, UofT, January 2007
% Modified by fjsimons@alum.mit.edu, MIT, December 2001

% Checks if a variable 'name' exists in the caller's workspace,
% if nonexistent or if empty 'name' is set to value 'value' in caller's workspace

if ~ischar(name),
  error('The first argument of defval has to be a string (variable name)');
end

si=1;
if evalin('caller',[ 'exist(''' name ''')']);,
  si=evalin('caller',[ 'isempty(' name ')']);
end
if si,
  assignin('caller',name,value);
  na=dbstack;
  %disp(['Default value used in ' na(2).name ': ' name '=' num2str(value(1,:))])
end
  
