function out_slices = outlier_slices(o, dtis, detector)
% Detect bad slices using mean slice outlier method
if nargin < 3
  detector = [];
end

% Calculate distances
dists = mean_slice_distances(o, dtis);

out_slices = outlier_distances(o, dists, detector);
return

