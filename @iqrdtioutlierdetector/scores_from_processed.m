function [scores iqr_distance] = scores_from_processed(o, wr_slices, iters, dims)
% find outlier score for each slice, from processed slices
if nargin < 3
  iters = [];
end
if isempty(iters)
  iters = o.options.iqriters;
end
if nargin < 4
  dims = [];
end
if isempty(dims)
  dims = o.options.iqrdim ;
end
[x, y, n_vols] = size(wr_slices);
n_vox = x*y;
iqr_distance = reshape(wr_slices, n_vox, n_vols);
for i = 1:iters
  iqr_distance = sf_iqr_2d_distance(iqr_distance, dims);
end
scores = max(iqr_distance);
iqr_distance = reshape(iqr_distance, x, y, n_vols);
return

function dists = sf_iqr_2d_distance(mat, dims)
if dims == 2 % voxel iqr distances
  mat  = sf_iqr_mat(mat')';
end 
% time (gradient) distances
dists = sf_iqr_mat(mat);
return

function dists = sf_iqr_mat(mat)
% Calculate IQR distance over columns of matrix
[m n] = size(mat);
[s_mat si_mat] = sort(mat, 2);
cent_is = [0.25 0.5 0.75]*(n-1)+1;
for c = 1:length(cent_is)
  ci = cent_is(c);
  cis = [floor(ci) ceil(ci)];
  cent_vals(:,c) = mean(s_mat(:, cis), 2);
end
iqr = cent_vals(:, 3)-cent_vals(:, 1);
dists = (mat-repmat(cent_vals(:,2),1,n))./ ...
		repmat(iqr, 1, n);
return
