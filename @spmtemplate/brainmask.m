function img = brainmask(o, thresh, filename)
% Return brain mask, possibly binarized at level thresh
% filename is full path name for image
if nargin < 2
  thresh = [];
end
if nargin < 3
  filename = [];
end
src_mask = spm_vol(fullfile(o.source_dir, ...
			 'apriori',...
			 'brainmask.nii'));
img = src_mask;
if isempty(thresh) & isempty(filename)
  return
end
if isempty(filename)
  if isempty(thresh)
    fname = 'brainmask.nii';
  else
    fname = sprintf('brainmask_%3.2f.nii', thresh);
  end
  filename = fullfile(outpath(o), fname);
end
img_vals = spm_read_vols(src_mask);
if ~isempty(thresh)
  img_vals = img_vals > thresh;
end
img.fname = filename;
img = spm_write_vol(img, img_vals);

