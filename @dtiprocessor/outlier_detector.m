function outvar = outlier_detector(o, invar)
% Get / set for outlier detector
if nargin < 2
  % Get
  outvar = o.outlier_detector;
  return
end
% Set
o.outlier_detector = invar;
outvar = o;
return
