function bad_set = find_suspicious(o, mask)
% Identifies and returns anomalous acquisitions from input object
if nargin < 2
  mask = [];
end
bad_set = []
n_o = numel(o);
if n_o < 2
  warning('Need at least two samples to find problems');
  return
end

% calculate slice vars between all pairs
vols = as_vols(o(1));
n_slices = vol.dim(3);
slice_distances = zeros([n_o, n_o, n_slices]) + NaN;
for oi = 1:n_o-1
  for o2i = oi+1:n_o
    slice_vars = pr_slice_variances(o(oi).vol, ...
				    o(o2i).vol,...
				    mask);
    slice_distances(oi, o2i, :) = slice_vars;
  end
end



