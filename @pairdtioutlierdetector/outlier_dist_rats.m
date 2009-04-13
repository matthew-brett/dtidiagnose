function out_slices = outlier_dist_rats(o, dists, rats, nvols, detector)
% Detect outliers from distances and ratios
if nargin < 5
  detector = [];
end
if isempty(detector)
  detector = o.drdetector;
end
outlier_tf = detect(detector, dists(:), rats(:));
  
[n_pairs n_slices] = size(dists);
% Pool distances and detect outliers
pair_nos = repmat([1:n_pairs]', 1, n_slices);
pair_nos = pair_nos(:);
slice_nos = repmat([1:n_slices], n_pairs, 1);
slice_nos = slice_nos(:);

out_inds = find(outlier_tf);
out_pairs = (rats(out_inds) < 1) + 1;

slice_inds = slice_nos(out_inds);
out_vols = zeros(size(out_inds));
for i = 1:length(out_inds)
  oi = out_inds(i);
  pair = pairs(pair_nos(oi), :);
  out_vols(i) = pair(out_pairs(i));
end
% Put into output cell array
u_out_vols = sort(unique(out_vols));
out_slices = slicelist(nvols, n_slices);
for i = 1:length(u_out_vols)
  uov = u_out_vols(i);
  these_vols = out_vols == uov;
  out_slices{uov} = slice_inds(these_vols);
end
return
