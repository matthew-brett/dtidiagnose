function outval = threshold(o, inval)
% Gets / sets threshold
if nargin > 1
  % Set
  o.threshold = inval;
  outval = o;
  return
end
% Get
outval = o.threshold;
return

