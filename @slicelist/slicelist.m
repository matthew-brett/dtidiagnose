function o = slicelist(list, n_slices, options)
% slicelist - class constructor for SPM template object
% FORMAT 
% Inputs [defaults]
% list       - cell array one entry per volume or number of volumes
% n_slices   - number of slices per volume
% options    - options structure (not currently used)

myclass = 'slicelist';
def_struct = struct('list', [],...
		    'n_vols', [], ...
		    'n_slices', [],...
		    'options', [],...
		    'cache', []);

def_opts = [];

if nargin < 1
  list = [];
end
if isa(list, myclass)
  o = list;
  return
end
if isstruct(list)
  o = class(list, myclass);
  return;
end
if ~iscell(list)
  list = cell(1, list);
else
  list = list(:)';
  for r = numel(list)
    list{r} = list{r}(:)';
  end
end
n_vols = numel(list);
if nargin < 2
  n_slices = [];
end
mx_slice = pr_max_slice(list);
if isempty(n_slices)
  n_slices = mx_slice;
else
  if mx_slice > n_slices
    error('More slices in list than in n_slices')
  end
end
if nargin < 3
  options = [];
end
options = dt_fill_from(options, def_opts);

obj_struct = struct(...
    'list', {list},...
    'n_vols', n_vols,...
    'n_slices', n_slices, ...
    'options', options,...
    'cache', []);
o  = class(obj_struct, myclass);
return

