function out_slices = outlier_distances(o, dists, detector);
% Find outlier slices from calculated distances
if nargin < 3
  detector = [];
end
if isempty(detector)
  detector = o.distdetector;
end

[n_vols n_slices] = size(dists);
% Pool distances and detect outliers
vol_nos = repmat([1:n_vols]', 1, n_slices);
vol_nos = vol_nos(:);
slice_nos = repmat([1:n_slices], n_vols, 1);
slice_nos = slice_nos(:);
outlier_tf = stepdown_detect(detector, dists(:));
out_inds = find(outlier_tf);
slice_inds = slice_nos(out_inds);
out_vols = vol_nos(out_inds);

% Put into output cell array
u_out_vols = sort(unique(out_vols));
out_slices = slicelist(n_vols, n_slices);
for i = 1:length(u_out_vols)
  uov = u_out_vols(i);
  these_vols = out_vols == uov;
  out_slices{uov} = slice_inds(these_vols);
end
return
