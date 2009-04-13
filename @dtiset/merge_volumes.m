function o = merge_volumes(o1, o2, slices, filename)
% Pull slices from volume for o2 into o1
if numel(o1) > 1
  error('Need single volume o1');
end
if numel(o2) > 2
  error('Need single volume o2');
end
vol1 = as_vols(o1);
vol2 = as_vols(o2);
vol = pr_merge_volumes(filename, vol1, vol2, slices);
o = set_vols(o1, 1, vol);
return
