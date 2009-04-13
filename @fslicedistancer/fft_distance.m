function [d, d1d2_ratio] = fft_distance(o, fslice1, fslice2)
% Find distance, and odds that source of distance is slice1 or slice2
  
dfslices = fslice1-fslice2;
rectmaker = o.rectangler;
work_dfs = from_fft_slice(rectmaker, dfslices);
work_dfs = adjust_for_effects(o, work_dfs);
[threshes heights] = lowest_n_clusters(o, work_dfs, 2);
d = heights(1);
if heights(2) > d*1.5
  d = heights(2);
end
if nargout < 2
  return
end
inds = find(work_dfs(:) >= threshes(1));
w_fs1 = adjust_for_effects(o, from_fft_slice(rectmaker, fslice1));
w_fs2 = adjust_for_effects(o, from_fft_slice(rectmaker, fslice2));
d1 = mean(w_fs1(inds));
d2 = mean(w_fs2(inds));
d1d2_ratio = d1/d2;
return
