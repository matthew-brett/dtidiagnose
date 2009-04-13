function o = exponentialoutlierdetector(threshold, options)
% exponentialoutlierdetector - class constructor
% FORMAT 
% Inputs [defaults]
% threshold   - outlier identification threshold
% options     - options structure (not yet used)

myclass = 'exponentialoutlierdetector';
def_struct = struct();
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
podo = poutlierdetector(threshold, options);
o = class(def_struct, myclass, podo);
return
