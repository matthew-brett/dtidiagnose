function dists = mean_slice_distances(o, dtis)
% Calculate distances from mean slice
vols = as_vols(dtis);
dims = vol_dims(dtis);
n_vols = length(vols);
n_slices = dims(3);

dists = zeros(n_vols, n_slices);
distancer = o.distancer;

[mean_img sd_img] = dt_vol_mean(vols);

for sno = 1:n_slices
  % Set mean slice, sd slice, etc, as effects for distancer
  mean_slice = mean_img(:, :, sno);
  sd_slice = sd_img(:, :, sno);
  regressors = slice_regressors(o, mean_slice, sd_slice);
  distancer = set_regressors(distancer, regressors{:});
  for vno = 1:n_vols
    s1 = dt_get_slice(vols(vno), sno);
    dists(vno, sno) = distance(distancer, s1, mean_slice);
  end
end
return
    
