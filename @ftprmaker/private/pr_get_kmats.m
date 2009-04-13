function [xK, yK] = pr_get_kmats(smoothing, X_dim)
% Return mat, delay structures from smoothing and matrix dims
sx = smoothing(1);
if numel(smoothing) > 1
  sy = smoothing(2);
else
  sy = sx;
end
% Get kernels
[kx ky] = dt_gaussian_kernels(sx, sy, X_dim);
xdim = X_dim(1);
ydim = X_dim(2);
xKmat = dt_filter_matrix(kx.kernel, xdim, xdim+2*kx.delay);
yKmat = dt_filter_matrix(ky.kernel, ydim, ydim+2*ky.delay);
xK = struct('mat', xKmat, 'delay', kx.delay);
yK = struct('mat', yKmat, 'delay', ky.delay);
