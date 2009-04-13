function [outlier_tf, worst_i]= detect(o, vec)
% Return 1 for probable outliers, 0 otherwise
% FORMAT [outlier_tf, worst_i]= detect(o, vec)
% If asked, return index of worst outlier
iqrd = iqr_distance(o, vec);
opts = options(o);
if opts.two_tailed
  lt_0 = iqrd < 0;
  iqrd(lt_0) = -iqrd(lt_0);
end
outlier_tf = iqrd > threshold(o);
if nargout > 1
  worst_i = [];
  if any(outlier_tf)
    [mx worst_i] = max(iqrd(:));
  end
end
return
