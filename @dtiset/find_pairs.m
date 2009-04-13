function [pairs, unpaired] = find_pairs(o, dtheta_thresh, bval_rthresh, bval_athresh)
% Find indices for pairable volumes, and unpairable ones
% FORMAT [pairs, unpaired] = find_pairs(o, dtheta_thresh, bval_rthresh,  bval_athresh)
% Extra options as for closer_than (defaults from there)

if nargin < 2
  dtheta_thresh = [];
end
if nargin < 3
  bval_rthresh = [];
end
if nargin < 4
  bval_athresh = [];
end

all_inds = 1:numel(o);
unpaired = logical(ones(size(all_inds)));
pairs = [];
remaining = unpaired;
for to_match = all_inds
  if ~remaining(to_match)
    continue
  end
  remaining(to_match) = 0;
  if ~any(remaining)
    break
  end
  [matches match_is] = find_similar(o(remaining),...
				    o(to_match), ...
				    dtheta_thresh, ...
				    bval_rthresh, ...
				    bval_athresh);
  if isempty(match_is)
    continue
  end
  rem_to_full = all_inds(remaining);
  match_is = rem_to_full(match_is);
  pair = [to_match match_is(1)];
  pairs = [pairs; pair];
  unpaired(pair) = 0;
end
unpaired = find(unpaired);
return