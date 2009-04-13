function diagnose_distance(o, slice1, slice2, figno)
% Show diagnostics for distance
if nargin < 4
  figno = [];
end
if isempty(figno)
  figno = figure;
else
  figure(figno);
  clf;
end
fslice1 = fft2(slice1);
fslice2 = fft2(slice2);
dfslices = fslice1-fslice2;
rectmaker = o.rectangler;
work_dfs = from_fft_slice(rectmaker, dfslices);
work_dfs_a = adjust_for_effects(o, work_dfs);
threshes = lowest_n_clusters(o, work_dfs_a, 3);
colormap(gray)
nr = 3; nc = 3;
subplot(nr, nc, 1)
imagesc(slice1)
title('Slice 1')
subplot(nr, nc, 2)
imagesc(slice2)
title('Slice 2')
subplot(nr, nc, 3)
imagesc(slice1 - slice2)
title('Difference')
subplot(nr, nc, 4)
imagesc(work_dfs)
title('Raw working');
subplot(nr, nc, 5)
imagesc(work_dfs_a)
title('Adjusted working');
subplot(nr, nc, 6)
imagesc(work_dfs_a >= threshes(1));
title('First peak');
subplot(nr, nc, 7)
imagesc(work_dfs_a >= threshes(2));
title('Second peak')
subplot(nr, nc, 8)
surf(work_dfs_a)
title('Weighted surface')
th_diffs = diff(-[max(work_dfs_a(:)) threshes]);
disp('Peak to peak differences');
fprintf('%5.2f ', th_diffs);
fprintf('\n');

