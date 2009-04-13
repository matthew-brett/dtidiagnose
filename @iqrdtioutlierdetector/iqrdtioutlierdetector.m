function o = iqrdtioutlierdetector(rectmaker, distdetector, msk_vol, options)
% iqrdtioutlierdetector - class constructor 
% FORMAT o = iqrdtioutlierdetector(rectmaker, distdetector, options)
% Object to identify outliers from volume pairs
% Inputs [defaults]
% rectmaker    - slice distance calculator
% distdetector   - distance outlier detector
% options     - options structure (not yet used)

myclass = 'iqrdtioutlierdetector';
def_struct = struct('rectmaker', [],...
		    'distdetector', [], ...
		    'msk_vol', [],...
		    'options', []);
def_opts = struct('iqriters', 5, 'iqrdim', 2,...
		  'pca_discard', 0, 'mskdiv', 0);
if nargin < 1
  rectmaker = [];
end
if isempty(rectmaker)
  rectmaker = ftprmaker(4, 0, 0);
end
if nargin < 2
  distdetector = [];
end
if isempty(distdetector)
  distdetector = iqroutlierdetector();
end
if nargin < 3
  msk_vol = [];
end
if ~isempty(msk_vol)
  if ischar(msk_vol)
    msk_vol = spm_vol(msk_vol);
  end
end
if nargin < 4
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
    'msk_vol', msk_vol,...
    'options', options);
o  = class(obj_struct, myclass);
return


  
