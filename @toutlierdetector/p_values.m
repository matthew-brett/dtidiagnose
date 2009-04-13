function [P, cP] = p_values(o, vec)
% Return 1-cdf p values for vector of normal observations
% FORMAT [P, cP] = p_values(o, vec)
% Depending on options, two / one tailed, 
% and mean assumed (value in assumed_mean or not assumed (NaN)
% cP is p value Bonferroni corrected for number of observations
N = length(vec);
df = N-1;
opts = options(o);
if ~isnan(opts.assumed_mean)
  wvec = vec - opts.assumed_mean;
else
  wvec = vec-mean(vec(:));
end
v = sum(wvec(:).^2)/df;
t_values = wvec(:) ./ sqrt(v);
if opts.two_tailed
  lt_0 = t_values < 0;
  P = zeros(size(vec));
  P(~lt_0) = 1-spm_Tcdf(t_values(~lt_0), df);
  P(lt_0) = 1-spm_Tcdf(-t_values(lt_0), df);  
  P = P * 2;
else
  P = 1-spm_Tcdf(t_values, df);
end
if nargout > 1
  cP = P * N;
  cP(cP > 1) = 1;
end
return
