function [kx, ky] = kernels(o,sx,sy, matrix_size)
% Gaussian convolution kernels
% FORMAT [kx, ky] = kernels(o,sx,sy)
% o    - object
% Otherwise see help for dt_gaussian_kernels.m

smoothing = o.smoothing;
if nargin < 2
  sx = [];
end
if isempty(sx)
  sx = smoothing(1);
end
if nargin < 3
  sy = [];
end
if length(smoothing) > 1
  sy = smoothing(2);
else % assume isotropic
  sy = sx; 
end
if nargin < 4
  matrix_size = [Inf Inf];
end
[kx, ky] = dt_gaussian_kernels(sx, sy, matrix_size);
return
