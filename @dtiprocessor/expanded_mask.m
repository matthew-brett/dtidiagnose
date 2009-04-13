function msk = expanded_mask(o, input_mask, fwhm, threshold, filename)
% Makes mask expanded by smooothing to reliably include all brain voxels
if nargin < 2
  input_mask = [];
end
if nargin < 3
  fwhm = 8;
end
if nargin < 4
  threshold = 0.1;
end
if nargin < 5
  filename = [];
end
if isempty(filename)
  filename = fullfile(outpath(o), 'expanded_mask.img');
end
if isempty(input_mask)
  input_mask = mask(o);
else
  if ischar(input_mask), input_mask=spm_vol(input_mask);end
end
spm_smooth(input_mask, filename, fwhm);
msk = spm_vol(filename);
img = spm_read_vols(msk);
img = img > threshold;
msk = spm_write_vol(msk, img);
return
