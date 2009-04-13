function vol = pr_merge_volumes(filename, vol1, vol2, bad_slices1, bad_slices2)
% Merge two volumes, using good slices from each
% FORMAT vol = pr_merge_volumes(filename, vo11, vol2, bad_slices1, bad_slices2)
%
% Inputs
% filename     - output filename for new merged volume
% vol1
% vol2
% bad_slices1  - slices in vol1 to remove
% bad_slices2  - slices in vol2 to remove
if nargin < 4
  bad_slices1 = [];
end
if nargin < 5
  bad_slices2 = [];
end
bad_slices1 = bad_slices1(:);
bad_slices2 = bad_slices2(:);
all_bad = [bad_slices1; bad_slices2];
overlap = ismember(bad_slices1, bad_slices2);
if any(overlap)
  very_bad_slices = bad_slices1(overlap);
  slice_report = sprintf('%s, ', very_bad_slices);
  error(sprintf('Bad slices overlap - %s cannot merge', slice_report));
end
n_slices = vol1.dim(3);
out_of_range = all_bad < 1 | all_bad > n_slices;
if any(out_of_range)
  error(['Some slices out of range:' num2str(out_of_range)]);
end
img1 = spm_read_vols(vol1);
for sno = bad_slices1'
  img1(:,:,sno) = dt_get_slice(vol2, sno);
end
vol = vol1;
vol.fname = filename;
vol = spm_write_vol(vol, img1);
return
