function o = spmtemplate(source_dir, options)
% spmtemplate - class constructor for SPM template object
% FORMAT 
% Inputs [defaults]
% source_dir     - source directory containing template subdirectories
% options    - options structure (including path for any written
%             images

myclass = 'spmtemplate';
def_struct = struct('source_dir', [],...
		    'options', [],...
		    'cache', []);

def_opts = struct(...
    'hold', 3, ...
    'outpath', spm_platform('tempdir')...
    );

if nargin < 1
  source_dir = [];
end
if isa(source_dir, myclass)
  o = source_dir;
  return
end
if isstruct(source_dir)
  o = class(source_dir, myclass);
  return;
end
if isempty(source_dir)
  source_dir = spm('dir');
end
if nargin < 2
  options = [];
end
options = dt_fill_from(options, def_opts);

obj_struct = struct(...
    'source_dir', source_dir,...
    'options', options,...
    'cache', []);
o  = class(obj_struct, myclass);
return
