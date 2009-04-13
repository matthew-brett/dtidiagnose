function out_slices = outliers_by_group(o, outlier_detector)
% Detect bad slices by bval group using slice outlier method

if nargin < 2
  outlier_detector = [];
end
if isempty(outlier_detector)
  outlier_detector = o.outlier_detector;
end

dtis = dtiset(o);
n_dtis = numel(dtis);
[bvs bvgis] = bval_groups(dtis);
n_groups = numel(bvgis);
vdim = vol_dims(dtis);
out_slices = slicelist(n_dtis, vdim(3));
for gno = 1:n_groups
  gis = bvgis{gno};
  res = outlier_slices(outlier_detector, dtis(gis));
  % Loop to deal with profoundly confusing cell indexing for matlab objects
  for ino = 1:numel(gis)
    gi = gis(ino);
    out_slices{gi} = res{ino};
  end
end
return
