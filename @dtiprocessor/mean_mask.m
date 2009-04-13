function msk = mean_mask(o, filename, centile, centile_prop)
% Returns mask volume using thresholded signal weighted mean
% centile is the centile of image intensity to estimate in-brain signal
% centile_propr is proportion of centile signal to set mask threshold
% filename is the filename for storing the mask image
if nargin < 2
  filename = fullfile(outpath(o), 'wmean_mask.img');
end
if nargin < 3
  centile = 95;
end
if nargin < 4
  centile_prop = 0.2;
end
V = weighted_mean(o);
img = spm_read_vols(V);
simg = sort(img(:));
ci = round(length(simg) * (centile/100));
threshold = simg(ci) * centile_prop;
img = img > threshold;
V.fname = filename;
msk = spm_write_vol(V, img);
return
