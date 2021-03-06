function o = pcadtioutlierdetector(rectmaker, distdetector, options)
% pairdtioutlierdetector - class constructor 
% FORMAT o = pairdtioutlierdetector(rectmaker, distdetector, options)
% Object to identify outliers from volume pairs
% Inputs [defaults]
% rectmaker    - slice distance calculator
% distdetector   - distance / ratio outlier detector
% options     - options structure (not yet used)

myclass = 'pcadtioutlierdetector';
def_struct = struct('rectmaker', [],...
		    'distdetector', [], ...
		    'options', []);
def_opts = struct('pca_discard', 0.25);
if nargin < 1
  rectmaker = [];
end
if isempty(rectmaker)
  rectmaker = ftprmaker([8 4], 0, 0);
end
if nargin < 2
  distdetector = [];
end
if isempty(distdetector)
  distdetector = outlierdetector(7);
end
if nargin < 3
  options = [];
end
options = dt_fill_from(options, def_opts);
if isa(rectmaker, myclass)
  o = params;
  return
end
if isempty(rectmaker)
  o = class(def_struct, myclass);
  return
end

obj_struct = struct(...
    'rectmaker', rectmaker,...
    'distdetector', distdetector, ...
    'options', options);
o  = class(obj_struct, myclass);
return


  
