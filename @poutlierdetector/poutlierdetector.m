function o = poutlierdetector(threshold, options)
% poutlierdetector - class constructor
% FORMAT 
% Inputs [defaults]
% threshold   - outlier identification threshold
% options     - options structure (not yet used)

myclass = 'poutlierdetector';
def_opts = struct('corrected_p', 0, ...
		  'threshold', 0.01);
def_struct = struct();
if nargin < 1
  threshold = [];
end
if nargin < 2
  options = [];
end
options = dt_fill_from(options, def_opts);
if isa(threshold, myclass)
  o = params;
  return
end
odo = outlierdetector(threshold, options);
o = class(def_struct, myclass, odo);
return
