function cX = convolve(o, X)
% 2D convolve matrix with object kernels, mirroring data

% If kernels cached, get them
if ~isempty([o.cache.xK o.cache.yK])
  xK = o.cache.xK;
  yK = o.cache.yK;
end
% Otherwise make them
[xK yK] = pr_get_kmats(o.smoothing, size(X));
% Mirror convolve in 2D
cX = sf_mirror_conv(X, xK.mat, xK.delay);
cX = sf_mirror_conv(cX', yK.mat, yK.delay)';
return

function xdash = sf_mirror_conv(X, K, delay)
% 1D convolves over rows, mirroring data
% K is kernel matrix, delay is kernel delay
L = size(X, 1);
delay_inds = 1:delay;
mX =   [flipud(X(delay_inds,:)); ...
	X; ...
	flipud(X(delay_inds + L - delay, :))];
xdash = K * mX;
return
