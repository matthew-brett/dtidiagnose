function [iqr, med] = pr_iqrange(vec, is_sorted)
% Returns interquartile range (and possibly median)
if nargin < 2
  is_sorted = 0;
end
if ~is_sorted
  vec = sort(vec);
end
q25 = pr_centile(vec, 25, 1);
q75 = pr_centile(vec, 75, 1);
iqr = q75-q25;
med = pr_centile(vec, 50, 1);
return