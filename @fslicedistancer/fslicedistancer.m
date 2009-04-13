function o = fslicedistancer(rectangler, weight_slice, regressors, options)
% fslicedistancer - class constructor for fslicedistancer object
% FORMAT o = fslicedistancer(rectangler, weight_slice, regressors, options)
% Inputs [defaults]
% weight_slice - optional weighting slice for distance calculation
% regressors - cell array of optional slice effects to regress out
% options     - options structure (not yet used)

myclass = 'fslicedistancer';
def_struct = struct('rectangler', [], ...
		    'weight_rect', [],...
		    'regress_rects', [], ...
		    'options', [],...
		    'cache', []);
def_opts = [];
if nargin < 1
  rectangler = [];
end
if isempty(rectangler)
  rectangler = ftprmaker();
end
if nargin < 2
  weight_slice = [];
end
weight_rect = [];
if ~isempty(weight_slice)
  weight_rect = from_slice(rectangler, weight_slice);
end
if nargin < 3
  regressors = {};
end
regress_rects = {};
if ~isempty(regressors)
  for r = 1:numel(regressors)
    regress_rects{r} = from_slice(rectangler, regressors{e});
  end
end
if nargin < 4
  options = [];
end
options = dt_fill_from(options, def_opts);
if isa(rectangler, myclass)
  o = params;
  return
end
if isempty(rectangler)
  o = class(def_struct, myclass);
  return
end

obj_struct = struct(...
    'rectangler', rectangler,...
    'weight_rect', weight_rect, ...
    'regress_rects',  {regress_rects}, ...
    'options', options,...
    'cache', []);
o  = class(obj_struct, myclass);
return
