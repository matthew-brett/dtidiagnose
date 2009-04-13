function vol = vol_space(o, filename, create_tf)
% Return vol struct in DWI space, with given filename
if nargin < 2
  filename = [];
end
if nargin < 3
  create_tf = 1;
end
V = as_vols(o.dtis);
vol = V(1);
vol = struct('fname',   filename, ...
	     'dim',     vol.dim,...
	     'dt',      [spm_type('float32') spm_platform('bigend')],...
	     'mat',     vol.mat,...
	     'n',       [1 1],...
	     'descrip', ['DWI space volume']);
if create_tf & ~isempty(filename)
  vol = spm_create_vol(vol);
end
return
