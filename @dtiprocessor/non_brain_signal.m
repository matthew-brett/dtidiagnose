function [s_mu, s_sd] = non_brain_signal(o, msk);
% estimates mean, sd of signal per slice outside brain, as defined by mask
% FORMAT [s_mu, s_sd] = non_brain_signal(o, msk);
% (N is number of dti volumes, S is number of slices)
% s_mu   - NxS measures of mean signal
% s_sd   - NxS meansures of std of signal

if nargin < 2
  msk = [];
end
if isempty(msk)
  msk = mask(o);
end
if isempty(msk)
  error('Set mask before calculating signal');
end
if ischar(msk)
  msk = spm_vol(msk);
end
dtis = o.dtis;
vols = as_vols(dtis);
n_vols = numel(vols);
mask_img = spm_read_vols(msk);
mask_img = 1-mask_img;
dims = msk.dim(1:3);
x_y_length = dims(1) * dims(2);
n_slices = dims(3);
for si = 1:n_slices
  slice_mask = mask_img(:,:,si);
  slice_ns(si) = sum(slice_mask(:));
end
s_mu = zeros(n_vols, n_slices);
s_sd = s_mu;
for vi = 1:n_vols
  img = spm_read_vols(vols(vi));
  img = img .* mask_img;
  img = reshape(img, x_y_length, n_slices);
  mu = sum(img, 1) ./ slice_ns;
  s2 = sum((img - repmat(mu, x_y_length, 1)).^2, 1) ./ (slice_ns - 1);
  s_mu(vi, :) = mu;
  s_sd(vi, :) = sqrt(s2);
end
return
