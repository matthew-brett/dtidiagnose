function [P, cP] = p_values(o, vec)
% Return 1-cdf p values for vector of exponential observations
% FORMAT [P, cP] = p_values(o, vec)
% cP is p value Bonferroni corrected for number of observations
lambda = 1/mean(vec(:));
P = exp(-lambda*vec);
if nargout > 1
  cP = P * length(vec);
  cP(cP > 1) = 1;
end
return
