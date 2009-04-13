function val = pr_centile(vec, cent, is_sorted)
% Returns value for specified centile
if nargin < 3
  is_sorted = 0;
end
if ~is_sorted
  vec = sort(vec);
end
cent_i = (cent/100)*(length(vec)-1)+1;
val = mean(vec([floor(cent_i) ceil(cent_i)]));