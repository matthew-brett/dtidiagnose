function [rmsd, dtheta]= slice_rmsd(o, mask, dtheta_thresh, bval_rthresh)
% Calculates slice by slice RMS differences of DTI volumes in mask
% Returns NxNxS matrix of RMS values
% where N is number of elements in o, and S is number of slices
% dtheta_thresh - angle difference within which to calculate
%               RMS (else distance left as NaN) [Inf]
% bval_thresh - bval relative difference threshold within 
%               which to calculate RMS
%               (see closer_than method) [0.1]
%
  
if nargin < 2
  mask = [];
end
options = o(1).options;
if nargin < 3
  dtheta_thresh = [];
end
if isempty(dtheta_thresh)
  dtheta_thresh = options.dtheta_thresh;
end
if nargin < 4
  bval_rthresh = [];
end
if isempty(bval_rthresh)
  bval_rthresh = options.bval_rthresh;
end
n_o = numel(o);
if n_o < 2
  error('Need at least two samples to calculate RMS');
  return
end
if ischar(mask)
  mask = spm_vol(mask);
end
if isstruct(mask)
  mask = spm_read_vols(mask);
end
vols = as_vols(o);
dims = vols(1).dim(1:3);
if isempty(mask)
  mask = ones(dims);
end
x_y_length = dims(1)*dims(2);
n_slices = dims(3);
for n = 1:n_slices
  slice_mask = mask(:,:,n);
  slice_ns(n) = sum(slice_mask(:));
end
rmsd = zeros([n_o, n_o, n_slices]) + NaN;
dtheta = zeros([n_o, n_o]);
bv = bvals(o);
for oi = 1:n_o-1
  img1 = spm_read_vols(vols(oi));
  dtheta(oi,:) = angle_distance(o(oi), o);
  not_close_to_this = ~closer_than(o, o(oi), ...
				   dtheta_thresh, bval_rthresh);
  for o2i = oi+1:n_o
    if not_close_to_this(o2i)
      continue
    end
    img2 = spm_read_vols(vols(o2i));
    slice_rmsd = (img1 - img2).^2 .* mask;
    slice_rmsd = reshape(slice_rmsd, x_y_length, n_slices);
    slice_rmsd = sqrt(sum(slice_rmsd, 1) ./ slice_ns);
    rmsd(oi, o2i, :) = slice_rmsd;
    rmsd(o2i, oi, :) = slice_rmsd;
  end
end
return
