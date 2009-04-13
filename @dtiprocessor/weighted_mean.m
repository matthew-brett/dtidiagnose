function wmean = weighted_mean(o, filename)
% Returns signal weighted mean volume
% filename is the filename for storing the mask image
if nargin < 2
  filename = fullfile(outpath(o), 'wmean.img');
end
dtis = o.dtis;
DV = as_vols(dtis);
nvols = length(DV);
V = DV(1);
for vi = 1:nvols
  img = spm_read_vols(DV(vi));
  vmean(vi) = mean(img(:));
end
wm_img = zeros(V.dim(1:3));
for vi = 1:nvols
  wimg = spm_read_vols(DV(vi)) * vmean(vi);
  wm_img = wm_img + wimg;
end
wm_img = wm_img / sum(vmean);
V = DV(1);
V.fname = filename;
wmean = spm_write_vol(V, wm_img);
return

