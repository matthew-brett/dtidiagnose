function [outlier_tf, worst_i]= detect(o, vec)
% Return 1 for probable outliers, 0 otherwise
% FORMAT [outlier_tf, worst_i]= detect(o, vec)
% If asked, return index of worst outlier
opts = options(o);
[P cP] = p_values(o, vec);
if opts.corrected_p
  P = cP;
end
outlier_tf = P < threshold(o);
if nargout > 1
  worst_i = [];
  if any(outlier_tf)
    [mn worst_i] = min(P(:));
  end
end
return
