function [wr_slices, slices] = process_slice(o, vols, sno)
% process image slices and create FFTed slices 
% FORMAT [wr_slices, slices] = process_slice(o, vols, sno)
% 
% Input
% o           - object
% vols        - time series of DWI volumes
% sno         - slice number
%
% Outputs
% (for following X and Y are dimension in X, Y in image space, N is number
% of time points)
% wr_slices   - X-1 by Y/2 by N series of FFT'ed processed slices
% slices      - unprocessed image slices X by Y by N series

pca_discard_thresh = o.options.pca_discard;
msk_div = o.options.mskdiv;
wrm = o.rectmaker;
dims = vols(1).dim(1:3);
n_vols = length(vols);
slice_size = dims(1)*dims(2);
msk_vol = o.msk_vol;
% Get size of working rectangle
wr_size = output_size(wrm, dims(1:2));
% Output arrays
wr_slices = zeros([wr_size n_vols]);
slices = zeros([dims(1:2) n_vols]);
% First loop to collect data
for vno = 1:n_vols
  slices(:,:,vno) = dt_get_slice(vols(vno), sno);
end
% Maybe PCA of collected data (hence first loop)
if pca_discard_thresh
  fprintf('Doing PCA on slice %d\n', sno);
  pca_slices = reshape(slices, [slice_size n_vols]);
  pca_slices = dt_pca_clean(pca_slices, pca_discard_thresh, 0);
  pca_slices = reshape(pca_slices, [dims(1:2) n_vols]);
else
  pca_slices = slices;
end
% Second loop to calculate WRs
for vno = 1:n_vols
  IS = slices(:, :, vno);
  pIS = pca_slices(:,:,vno);
  wrIS = from_slice(wrm, pIS);
  if ~isempty(msk_vol)
    MS = logical(dt_get_slice(msk_vol, sno));
    mIS = IS;
    if msk_div
      mIS(MS) = 1;
      msk_fft = fft2(MS);
      mIS_fft = fft2(mIS);
      div_fft = exp(log(mIS_fft+eps)-log(msk_fft+eps));
      msk_wr = from_fft_slice(wrm, div_fft);
    else
      mIS(MS) = 0;
      msk_wr = from_slice(wrm, mIS);
    end
    wrIS = wrIS .* msk_wr;
  end
  wr_slices(:,:,vno) = wrIS;
end
return 
