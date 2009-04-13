function [sim_set, sim_is]= find_similar(search_set, example, dtheta_thresh, bval_rthresh, bval_athresh)
% Find volumes with similar bval, bvecs to example
% If example is in search_set, it will also be returned
% Results returned sorted in descending similarity in terms of angle
%
% Outputs
% sim_set  - sorted similar set
% sim_is   - indices into search set

if numel(example) > 1
  error('Need single example');
end
if nargin < 3
  dtheta_thresh = [];
end
if nargin < 4
  bval_rthresh = [];
end
if nargin < 5
  bval_athresh = [];
end
[candidates dthetas] = closer_than(search_set, example,...
				       dtheta_thresh,...
				       bval_rthresh, ...
				       bval_athresh);
candidates = find(candidates);
dthetas = dthetas(candidates);
[ds, ids] = sort(dthetas);
sim_is = candidates(ids);
sim_set = search_set(sim_is);
return
