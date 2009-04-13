dtis = test_eg_dtiset;
nb0dtis = remove(dtis, bzeros(dtis));
mdod = meandtioutlierdetector;
dists = mean_slice_distances(mdod, nb0dtis);
outs = outlier_distances(mdod, dists);
outs1 = outlier_slices(mdod, nb0dtis);
assert(outs == outs1);
% Try tuning curve
thresh = 1./(10.^(2:0.1:6));
n_thresh = length(thresh);
out_counts = zeros(1, n_thresh);
all_outs = cell(1, n_thresh);
for i = 1:n_thresh
  eod = exponentialoutlierdetector(thresh(i));
  all_outs{i} = outlier_distances(mdod, dists, eod);
  out_counts(i) = length(vertcat(all_outs{i}{:}));
end

  
