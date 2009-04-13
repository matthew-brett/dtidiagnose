function o = toutlierdetector(threshold, options)
% toutlierdetector - class constructor
% FORMAT 
% Inputs [defaults]
% threshold   - outlier identification threshold
% options     - options structure (not yet used)

myclass = 'toutlierdetector';
def_struct = struct();
def_opts = struct('two_tailed', 1, ...
		  'assumed_mean', NaN);
if nargin < 1
  threshold = [];
end
if nargin < 2
  options = [];
end
if isa(threshold, myclass)
  o = params;
  return
end
options = dt_fill_from(options, def_opts);
podo = poutlierdetector(threshold, options);
o = class(def_struct, myclass, podo);
return
