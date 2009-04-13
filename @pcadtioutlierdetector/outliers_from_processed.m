function outs = outliers_from_processed(o, wr_slices, detector)
% find outliers in a slice, from processed slices
if nargin < 3
  detector = [];
end
if isempty(detector)
  detector = o.distdetector;
end
[scores scoremat] = scores_from_processed(o, wr_slices);
outs = find(stepdown_detect(detector, scores));
return
