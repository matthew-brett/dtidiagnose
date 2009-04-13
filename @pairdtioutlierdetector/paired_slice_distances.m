function [pairs, dists, rats] = paired_slice_distances(o, dtis)
% Return paired slice distances as calculated by distancer
% FORMAT [pairs, dists, rats] = paired_slice_distances(o, dtis)

[pairs, unpaired] = find_pairs(dtis);
if ~isempty(unpaired)
  disp(strvcat(vols(unpaired).fname));
  warning('No pairs for some vols, cannot calculate distances');
end
dims = vol_dims(dtis);
n_slices = dims(3);
n_pairs = size(pairs, 1);
dists = zeros(n_pairs, n_slices);
rats = dists;
for pno = 1:n_pairs
  pair = pairs(pno, :);
  [dist rat] = pair_slice_distances(o, dtis(pair));
  dists(pno, :) = dist';
  rats(pno, :) = rat';
end
return
