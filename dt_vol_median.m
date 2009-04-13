function img = dt_vol_median(vols)
% Utility function to calculate median matrix from vol list
if ischar(vols)
  vols = spm_vol(vols);
end
n_vols = numel(vols);
dims = vols(1).dim(1:3);
imgs = spm_read_vols(vols);
img = median(imgs, 4);
return

