function o = set_regressors(o, varargin)
% Set regressors from slices in image space
o.regress_rects = {};
for r = 1:numel(varargin)
  o.regress_rects{r} = from_slice(o.rectangler, varargin{r});
end
return
