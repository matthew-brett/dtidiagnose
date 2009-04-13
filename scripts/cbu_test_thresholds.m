% Script to review effects of different thresholds on detection
% Assumes variables from workspace after running 
% cbu_review_dtis script

% Get distances for non b0 group 
% (assumes all non b0 scans are same b value)
nb0dtis = remove(dtis, bzeros(dtis));
mdod = meandtioutlierdetector;
dists = mean_slice_distances(mdod, nb0dtis);

% Try tuning curve of thresholds to detection
thresh = 1./(10.^(2:0.1:6));
n_thresh = length(thresh);
out_counts = zeros(1, n_thresh);
all_outs = cell(1, n_thresh);
for i = 1:n_thresh
  eod = exponentialoutlierdetector(thresh(i));
  all_outs{i} = outlier_distances(mdod, dists, eod);
  out_counts(i) = length(vertcat(all_outs{i}{:}));
end

