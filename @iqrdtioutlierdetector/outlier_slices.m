function out_slices = outlier_slices(o, dtis, detector)
% Detect bad slices using PCA slice outlier method
% FORMAT out_slices = outlier_slices(o, dtis, detector)
% Uses PCA cleaning in image space, then Dirac filtering
% over time to emphasize outliers
  
if nargin < 3
  detector = [];
end
if isempty(detector)
  detector = o.distdetector;
end
vols = as_vols(dtis);
n_vols = numel(vols);
n_slices = vols(1).dim(3);
out_slices = slicelist(n_vols, n_slices);

for sno = 1:n_slices
  f_all_wr = process_slice(o, vols, sno);
  outs = outliers_from_processed(o, f_all_wr, detector);
  out_slices = set_volnos_with_slices(out_slices, sno, outs);
end
return

