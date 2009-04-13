function [group_bvals, group_indices] = bval_groups(o, bval_rthresh, bval_athresh)
% Sorts dti bvals into groups of similar bvals, returning group means, membership
% This should be done by some formal grouping, but here we do it
% crudely by iterating over the bvals, testing whether the first 
% unclaimed value is nearly equal (bval_rthresh, bval_athresh)
% to other unclaimed values, and grouping them together if so

if nargin < 2
  bval_rthresh = [];
end
options = o(1).options;
if isempty(bval_rthresh)
  bval_rthresh = options.bval_rthresh;
end
if nargin < 3
  bval_athresh = [];
end
if isempty(bval_athresh)
  bval_athresh = options(1).bval_athresh;
end
% First pass
bvs = bvals(o);
[group_bvals, group_indices] = sf_find_groups(bvs, bval_rthresh, bval_athresh);
% Second pass to merge similar groups
[gvals, gindices] = sf_find_groups(group_bvals, bval_rthresh, bval_athresh);
if length(gvals) == length(group_bvals)
  return
end
% Do merge
new_gbv = [];
new_gis = {};
for gi = 1:length(gvals)
  groups_to_merge = gindices{gi};
  new_gis{end+1} = [group_indices{groups_to_merge}];
  new_gbv(end+1) = mean(bvs(new_gis{end}));
end
group_bvals = new_gbv;
group_indices = new_gis;
return

function [meanvals, indices] = sf_find_groups(vals, rthresh, athresh)
meanvals = [];
indices = {};
unclaimed = 1:length(vals);
while(length(unclaimed) > 1)
  target_i = unclaimed(1);
  unclaimed(1) = [];
  target_bval = vals(target_i);
  test_bvals = vals(unclaimed);
  if abs(target_bval) < athresh
    group_is = find(abs(test_bvals) < athresh);
  else
    rdiff = abs(test_bvals-target_bval) ./ target_bval;
    group_is = find(rdiff < rthresh);
  end
  target_is = [target_i unclaimed(group_is)];
  unclaimed(group_is) = [];
  indices{end+1} = target_is;
  meanvals = [meanvals mean(vals(target_is))];
end
if length(unclaimed)
  indices{end+1} = unclaimed;
  meanvals = [meanvals vals(unclaimed)];
end
return
		    
