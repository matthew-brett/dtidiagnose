function [tf, dthetas] = closer_than(o1, o2, dtheta_thresh, bval_rthresh, bval_athresh)
% returns 1 if objects have dtheta and bval difference < thresholds
if nargin < 3
  dtheta_thresh = [];
end
options = o1(1).options;
if isempty(dtheta_thresh)
  dtheta_thresh = options.dtheta_thresh;
end
if nargin < 4
  bval_rthresh = [];
end
if isempty(bval_rthresh)
  bval_rthresh = options.bval_rthresh;
end
if nargin < 5
  bval_athresh = [];
end
if isempty(bval_athresh)
  bval_athresh = options.bval_athresh;
end

if isempty(o1) | isempty(o2)
  return
end
o1 = o1(:);
o2 = o2(:);
if numel(o2) ~= 1
  if numel(o2) ~= numel(o1)
    error('o2 must have one element or same no as o1');
  end
end
bv1 = bvals(o1);
bval_diffs = abs(bv1 - bvals(o2));
bval_tests = bval_diffs < bval_athresh;
rt = find(~bval_tests & ~bv1 ==0);
bval_tests(rt)  = (bval_diffs(rt) ./ bv1(rt)) < bval_rthresh;
tf = bval_tests;
dthetas = zeros(size(tf))+Inf;
for oi = find(bval_tests)
  if numel(o2) == 1, ti = 1; else ti = oi; end
  dthetas(oi) = angle_distance(o1(oi), o2(ti));
  tf(oi) =  abs(dthetas(oi)) < dtheta_thresh;
end
return
