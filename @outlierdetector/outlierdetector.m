function o = outlierdetector(threshold, options)
% outlierdetector - class constructor for outlierdetector object
% FORMAT 
% Inputs [defaults]
% threshold   - outlier identification threshold
% options     - options structure (not yet used)

myclass = 'outlierdetector';
def_struct = struct('threshold', [],...
		    'options', [],...
		    'cache', []);
if nargin < 1
  threshold = [];
end
if isempty(threshold)
  threshold = 0.05;
end
if nargin < 2
  options = [];
end
if isa(threshold, myclass)
  o = params;
  return
end
if isempty(threshold)
  o = class(def_struct, myclass);
  return
end

obj_struct = struct(...
    'threshold', threshold,...
    'options', options,...
    'cache', []);
o  = class(obj_struct, myclass);
return
