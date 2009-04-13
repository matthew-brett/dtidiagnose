function [cleaned_X, cs_remaining] = dt_pca_clean(X, prop_thresh, verbose)
% Remove first prop_thresh proportion of variance with PCA
% FORMAT [cleaned_X, cs_remaining] = dt_pca_clean(X, prop_thresh, verbose)
% 
% Inputs
% X           - matrix to filter, variables are columns
% prop_thresh - proportion of PCA variance to remove [0.5]
% verbose     - if 1, put out informative messages [0]
%
% Returns
% cleaned_X   - X with variance removed
% cs_remaining - how many PCA components survived prop_thresh

if nargin < 2
  prop_thresh = [];
end
if isempty(prop_thresh)
  prop_thresh = 0.5;
end
if nargin < 3
  verbose = [];
end
% Do PCA
[vecs vals psi] = pc_evectors(X, [], verbose);
% Project out first prop_thresh proportion of variance
pct_var = cumsum(vals) ./ sum(vals);
used_is = pct_var(2:size(vecs,2))>prop_thresh;
cs_remaining = sum(used_is);
used_vecs = vecs(:, used_is);
n_X = size(X, 2);
mean_mat = repmat(psi, 1, n_X);
mc_X = X - mean_mat;
projection = used_vecs'*mc_X;
cleaned_X = used_vecs * projection;
return
