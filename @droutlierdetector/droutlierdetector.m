function o = droutlierdetector(distdetector, ratdetector, ratio_thresh, options)
% droutlierdetector - class constructor for droutlierdetector object
% FORMAT o = droutlierdetector(distdetector, ratdetector, ratio_thresh, options)
% Detect method of object takes distances and ratios, return outlier T/F
% Inputs [defaults]
% distdetector - distance outlier detector
% ratdetector - ratio outlier detector (for p values)
% ratio_thresh - threshold for ratio p value to indicate real difference
% options     - options structure (not yet used)

myclass = 'droutlierdetector';
def_struct = struct('distdetector', [],...
		    'ratdetector', [], ...
		    'ratio_thresh', [], ...
		    'options', []);
def_opts = [];
if nargin < 1
  distdetector = [];
end
if isempty(distdetector)
  distdetector = exponentialoutlierdetector();
end
if nargin < 2
  ratdetector = [];
end
if isempty(ratdetector)
  opts = struct('assumed_mean', 1);
  ratdetector = toutlierdetector([], opts);
end
if nargin < 3
  ratio_thresh = [];
end
if isempty(ratio_thresh)
  ratio_thresh = 0.1;
end
if nargin < 4
  options = [];
end
options = dt_fill_from(options, def_opts);
if isa(distdetector, myclass)
  o = params;
  return
end
if isempty(distdetector)
  o = class(def_struct, myclass);
  return
end

obj_struct = struct(...
    'distdetector', distdetector,...
    'ratdetector', ratdetector, ...
    'ratio_thresh', ratio_thresh, ...
    'options', options);
o  = class(obj_struct, myclass);
return
