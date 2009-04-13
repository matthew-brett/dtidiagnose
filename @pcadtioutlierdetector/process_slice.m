function [wr_slices, pca_slices, slices] = process_slice(o, vols, sno)
% PCA process image slices and create FFT slices 
% FORMAT [wr_slices, pca_slices] = process_slice(o, vols, sno)
% 
% Input
% o           - object
% vols        - time series of DWI volumes
% sno         - slice number
%
% Outputs
% (for following X and Y are dimension in X, Y in image space, N is number
% of time points(
% wr_slices   - X by Y/2 by N series of FFT'ed processed slices
% pca_slices  - X by Y by N series of PCA cleaned image slices
% slices      - unprocessed image slices

pca_discard_thresh = o.options.pca_discard;
wrm = o.rectmaker;
dims = vols(1).dim(1:3);
n_vols = length(vols);
slice_size = dims(1)*dims(2);

slices = [];
for vno = 1:n_vols
  IS = dt_get_slice(vols(vno), sno);
  slices = [slices IS(:)];
end
if pca_discard_thresh
  pca_slices = dt_pca_clean(slices, pca_discard_thresh, 0);
else
  pca_slices = slices;
end
wr_slices = [];
for vno = 1:n_vols
  IS = reshape(pca_slices(:, vno), dims(1:2));
  S = from_slice(wrm, IS);
  wr_slices = [wr_slices S(:)];
end
wr_slices = reshape(wr_slices, [size(S) n_vols]);
if nargout > 1
  pca_slices = reshape(pca_slices, [size(IS) n_vols]);
end
if nargout > 2
  slices = reshape(slices, [size(IS) n_vols]);
end
return 
