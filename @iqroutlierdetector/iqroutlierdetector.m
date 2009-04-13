function o = iqroutlierdetector(threshold, options)
% iqroutlierdetector - class constructor
% FORMAT 
% Inputs [defaults]
% threshold   - outlier identification threshold
% options     - options structure (not yet used)

myclass = 'iqroutlierdetector';
def_struct = struct();
def_opts = struct('two_tailed', 1);
if nargin < 1
  threshold = [];
end
if isempty(threshold)
  threshold = 2.5;
end
if nargin < 2
  options = [];
end
if isa(threshold, myclass)
  o = params;
  return
end
options = dt_fill_from(options, def_opts);
odo = outlierdetector(threshold, options);
o = class(def_struct, myclass, odo);
return
