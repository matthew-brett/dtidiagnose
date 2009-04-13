function img = slice_weights(o)
% Return matrix weighting slices for distance calculation
% Default is to use DWI mean inverse weighted by SD
[uwm uwsd] = unweighted_dwi_mean(o);
uwm_img = spm_read_vols(uwm);
uwsd_img = spm_read_vols(uwsd);
mx = max(uwsd_img(:));
sd_weighting = 1 - (uwsd_img / mx);
img = uwm_img .* sd_weighting;
for sno = 1:size(img, 3)
  this_slice = img(:, :, sno);
  img(:,:,sno) = this_slice ./ sum(this_slice(:));
end
return
