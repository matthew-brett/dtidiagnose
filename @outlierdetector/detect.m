function [outlier_tf, worst_i]= detect(o, vec)
% Return 1 for probable outliers, 0 otherwise
% FORMAT [outlier_tf, worst_i]= detect(o, vec)
% If asked, return index of worst outlier
[tmp i] = sort(vec);
outlier_tf = vec > o.threshold;
if any(outlier_tf)
  worst_i = i(end);
else
  worst_i = [];
end
return
