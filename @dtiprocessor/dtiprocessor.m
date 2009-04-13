function o = dtiprocessor(dtis, structural, mask, template, outlier_detector, options)
% dtiprocessor - class constructor for dtiprocessor object
% FORMAT o = dtiprocessor(dtis, structural, mask, template, outlier_detector, options)
% Inputs [defaults]
% dtis       - dtiset object
% structural - structuralish DWI image for registration etc
% mask       - mask defining voxels not in background (in tissue)
% template   - template structure for registration etc
% outlier_detector  - volume outlier detection object
% options    - options structure - including default path for
%              written images

myclass = 'dtiprocessor';
def_struct = struct('dtis', [],...
		    'structural', [],...
		    'mask', [], ...
		    'template', [], ...
		    'outlier_detector', [], ...
		    'template_map', [], ...
		    'options', [],...
		    'cache', []);

def_opts = struct(...
    'outpath', sf_tmpdir...
    );

if nargin < 1
  dtis = [];
end
if isa(dtis, myclass)
  o = dtis;
  return
end
if isstruct(dtis)
  o = class(dtis, myclass);
  return;
end
if nargin < 2
  structural = [];
end
if ischar(structural)
  structural = spm_vol(structural);
end
if nargin < 3
  mask = [];
end
if ischar(mask)
  mask = spm_vol(mask);
end
if nargin < 4
  template = [];
end
if isempty(template), template = spmtemplate; end
template = spmtemplate(template);
if nargin < 5
  outlier_detector = [];
end
if isempty(outlier_detector)
  outlier_detector = meandtioutlierdetector;
end
if nargin < 6
  options = [];
end
options = dt_fill_from(options, def_opts);
cache = pr_fill_cache();
obj_struct = struct(...
    'dtis', dtis,...
    'structural', structural,...
    'mask', mask,...
    'template', template,...
    'outlier_detector', outlier_detector, ...
    'template_map', [],...
    'options', options,...
    'cache', cache);
o  = class(obj_struct, myclass);
return

function tmpdir = sf_tmpdir;
tmp_root = spm_platform('tempdir');
[pth sdir_suffix] = fileparts(tempname);
sdir = ['dti_' sdir_suffix];
tmpdir = fullfile(tmp_root, sdir);
if exist(tmpdir, 'dir')
  return
end
[success, message1] = mkdir(tmp_root, sdir);
if ~success
  error(message1);
end
return
