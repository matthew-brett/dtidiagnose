function [kx, ky] = dt_gaussian_kernels(sx, sy, matrix_size)
% Generate Gaussian kernels with delay, for smoothing in x, y, matrix_size
% sx   - kernel width (FWHM) in pixels
% sy   - optional non-isomorphic smoothing
% matrix_size - row, column size of matrix to be convolved
%               [optional, for small matrices]
%
% Output
% kx   - kernel in x
%           fields - kernel, delay
% ky   - kernel in y
%           ditto 
%
% from spm_conv.m 
% Copyright (C) 2005 Wellcome Department of Imaging Neuroscience
% Karl Friston
% $Id: spm_conv.m 259 2005-10-18 18:21:59Z karl $

sx      = abs(sx);
sy      = abs(sy);
lx = matrix_size(1);
ly = matrix_size(2);

% FWHM -> sigma
%---------------------------------------------------------------------------
sx    = sx/sqrt(8*log(2)) + eps;
sy    = sy/sqrt(8*log(2)) + eps;

% kernels
%---------------------------------------------------------------------------
Ex    = min([ceil(3*sx) lx]);
x     = [-Ex:Ex];
kx    = exp(-x.^2/(2*sx^2));
kx    = kx/sum(kx);
Ey    = min([ceil(3*sy) ly]);
y     = [-Ey:Ey];
ky    = exp(-y.^2/(2*sy^2));
ky    = ky/sum(ky);

kx = struct('kernel', kx, 'delay', Ex);
ky = struct('kernel', ky, 'delay', Ey);

return
