function diagnose_slice(o, dtis, volno, sliceno, mean_img, sd_img, figno)
% Show diagnostics for distances from mean slice
if nargin < 5
  mean_img = [];
end
if nargin < 6
  sd_img = [];
end
if nargin < 7
  figno = [];
end
vols = as_vols(dtis);
dims = vol_dims(dtis);
n_vols = length(vols);
n_slices = dims(3);

distancer = o.distancer;

if isempty(mean_img) | isempty(sd_img)
  error
  [mean_img, sd_img] = dt_vol_mean(vols);
end
% Set mean slice as weight for distancer
mean_slice = mean_img(:, :, sliceno);
sd_slice = sd_img(:, :, sliceno);
regressors = slice_regressors(o, mean_slice, sd_slice);
distancer = set_regressors(distancer, regressors{:});
s1 = dt_get_slice(vols(volno), sliceno);
diagnose_distance(distancer, s1, mean_slice, figno);
return
    
