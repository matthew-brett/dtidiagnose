function [dist, rat] = pair_slice_distances(o, pair, msk_img)
% Use distancer object to find slice distances for two DWI samples
% Optional msk_img is 3D matrix of masking values, or vol struct
% or filename, or empty for no mask

vols = as_vols(pair);
if numel(vols) ~= 2
  error('Need exactly 2 vols to compare');
end
dims = vols(1).dim(1:3);
if nargin < 3
  msk_img = [];
end
if ischar(msk_img)
  msk_img = spm_vol(msk_img);
end
if isstruct(msk_img)    
  msk_img = spm_read_vols(msk_img);
end
distancer = o.distancer;
n_slices = dims(3);
dist = zeros(n_slices, 1);
rat = dist;
for sno = 1:n_slices
  s1 = dt_get_slice(vols(1), sno);
  s2 = dt_get_slice(vols(2), sno);
  if ~isempty(msk_img)
    msk = msk_img(:,:,sno);
    s1 = s1 .* msk;
    s2 = s2 .* msk;
  end
  [dist(sno) rat(sno)] = distance(distancer, s1, s2);
end
return
