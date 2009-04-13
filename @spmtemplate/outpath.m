function outarg = outpath(o, inarg)
% Get / set output path for calculated images
if nargin < 2
  % get
  if isempty(o)
    outarg = '';
    return
  end
  outarg = o(1).options.outpath;
  return
end
% set
if isempty(o)
  error('Empty object, cannot set outpath');
end
o(1).options.outpath = inarg;
outarg = o;
return
  