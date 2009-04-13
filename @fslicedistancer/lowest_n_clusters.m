function [threshes, heights] = lowest_n_clusters(o, work_rect, n_clusters)
% Lowest threshold for which there remain no more than N clusters
thresholds = flipud(sort(work_rect(:)));
mx = thresholds(1);
n_thresh = length(thresholds);
threshes = ones(1, n_clusters) - Inf;
current_cluster = 1;
for tno = 2:length(thresholds)
  bwr = double(work_rect >= thresholds(tno));
  [tmp ncs] = spm_bwlabel(bwr, 26);
  if ncs > current_cluster
    threshes(current_cluster) = thresholds(tno-1);
    if current_cluster == n_clusters
      break
    end
    current_cluster = current_cluster+1;
  end
end
heights = -diff([mx threshes]);
return
