function o = pairdtioutlierdetector(distancer, drdetector, options)
% pairdtioutlierdetector - class constructor 
% FORMAT o = pairdtioutlierdetector(distancer, drdetector, options)
% Object to identify outliers from volume pairs
% Inputs [defaults]
% distancer    - slice distance calculator
% drdetector   - distance / ratio outlier detector
% options     - options structure (not yet used)

myclass = 'pairdtioutlierdetector';
def_struct = struct('distancer', [],...
		    'drdetector', [], ...
		    'options', []);
def_opts = [];
if nargin < 1
  distancer = [];
end
if isempty(distancer)
  distancer = fslicedistancer();
end
if nargin < 2
  drdetector = droutlierdetector();
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
    'drdetector', drdetector, ...
    'options', options);
o  = class(obj_struct, myclass);
return


  
