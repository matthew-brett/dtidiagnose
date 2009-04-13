function o = meandtioutlierdetector(distancer, distdetector, options)
% pairdtioutlierdetector - class constructor 
% FORMAT o = pairdtioutlierdetector(distancer, distdetector, options)
% Object to identify outliers from volume pairs
% Inputs [defaults]
% distancer    - slice distance calculator
% distdetector   - distance / ratio outlier detector
% options     - options structure (not yet used)

myclass = 'meandtioutlierdetector';
def_struct = struct('distancer', [],...
		    'distdetector', [], ...
		    'options', []);
def_opts = [];
if nargin < 1
  distancer = [];
end
if isempty(distancer)
  distancer = fslicedistancer;
end
if nargin < 2
  distdetector = [];
end
if isempty(distdetector)
  distdetector = exponentialoutlierdetector(0.0001);
end
if nargin < 3
  options = [];
end
options = dt_fill_from(options, def_opts);
if isa(distancer, myclass)
  o = params;
  return
end
if isempty(distancer)
  o = class(def_struct, myclass);
  return
end

obj_struct = struct(...
    'distancer', distancer,...
    'distdetector', distdetector, ...
    'options', options);
o  = class(obj_struct, myclass);
return


  
