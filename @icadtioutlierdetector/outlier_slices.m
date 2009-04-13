function out_slices = outlier_slices(o, dtis, detector)
% Detect bad slices using ica slice outlier method
% and PCA cleaning
if nargin < 3
  detector = [];
end
if isempty(detector)
  detector = o.distdetector;
end
pca_discard_thresh = o.options.pca_discard;
wrm = o.rectmaker;

vols = as_vols(dtis);
dims = vol_dims(dtis);
n_vols = length(vols);
n_slices = dims(3);
slice_size = dims(1)*dims(2);

out_slices = slicelist(n_vols, n_slices);

for sno = 1:n_slices
  all_slices = [];
  for vno = 1:n_vols
    IS = dt_get_slice(vols(vno), sno);
    all_slices = [all_slices IS(:)];
  end
  if pca_discard_thresh
    cleaned_slices = dt_pca_clean(all_slices, pca_discard_thresh, 0);
  else
    cleaned_slices = all_slices;
  end
  all_wr_slices = [];
  for vno = 1:n_vols
    IS = reshape(cleaned_slices(:, vno), dims(1:2));
    S = from_slice(wrm, IS);
    all_wr_slices = [all_wr_slices S(:)];
  end
  %f_all_wr = dt_dirac_filt(all_wr_slices); 
  f_all_wr = all_wr_slices;
  [C W A] = fastica(f_all_wr', 'stabilization', 'on', 'verbose', 'off');
  if any(diff(size(A)))
    warning(['Could not calculate ICA for slice ' num2str(sno)])
    save(sprintf('icafail%d', sno),'sno');
    continue
  end
  C = C';
  iA = inv(A);
  for cno = 1:n_vols
    tc = iA(:, cno);
    [outlier_tf, worst_i]= detect(detector, tc);
    if ~isempty(worst_i)
      out_slices = add_to_vol(out_slices, worst_i, sno);
    end
  end
end
return

