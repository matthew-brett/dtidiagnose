function outlier_tf = detect(o, distances, ratios)
% Return tf matrix for presence of outliers from distances and ratios
  
outlier_tf = stepdown_detect(o.distdetector, distances);
rat_ps = p_values(o.ratdetector, ratios);
outlier_tf(rat_ps > o.ratio_thresh) = 0;
