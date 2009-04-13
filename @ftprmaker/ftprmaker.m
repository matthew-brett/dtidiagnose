function o = ftprmaker(smoothing, lp_cutoff, edgesize, options)
% ftprmaker - class constructor for ftprmaker object
% FORMAT o = ftprmaker(smoothing, lp_cutoff, edgesize, options)
% Inputs [defaults]
% smoothing   - smoothing to apply in cycles per voxel
% lp_cutoff   - low pass cutoff in cycles per voxel
% edgesize    - edge to slice off rectangle borders
% options     - options structure (not yet used)

myclass = 'ftprmaker';
% Can define x and y matrix dimensions for smoothing
def_opts = struct('X_dim', []);
% And therefore store kernel matrices in x and y
def_cache = struct('xK', [], 'yK', []);

def_struct = struct('smoothing', [],...
		    'lp_cutoff', [], ...
		    'edgesize', [],...
		    'options', def_opts,...
		    'cache', def_cache);
if nargin < 1
  smoothing = [];
end
if isa(smoothing, myclass)
  o = params;
  return
end
if isempty(smoothing)
  o = class(def_struct, myclass);
  return
end
if isempty(smoothing)
  smoothing = 6;
end
if nargin < 2
  lp_cutoff = [];
end
if isempty(lp_cutoff)
  lp_cutoff = 12;
end
if nargin < 3
  edgesize = [];
end
if isempty(edgesize)
  edgesize = 2;
end
if nargin < 4
  options = [];
end
options = dt_fill_from(options, def_opts);
cache = def_cache;
X_dim = options.X_dim;
if options.X_dim
  if numel(X_dim) < 2
    error('Need 2 values for options.X_dim (x and y dims)')
  end
  [cache.xK cache.yK] = pr_get_kmats(smoothing, X_dim);
end
obj_struct = struct(...
    'smoothing', smoothing,...
    'lp_cutoff', lp_cutoff,...
    'edgesize', edgesize,...
    'options', options,...
    'cache', cache);
o  = class(obj_struct, myclass);
return
