function outlier_tf = stepdown_detect(o, vec)
% Stepdown detection of outliers
not_outlier_tf = logical(ones(size(vec)));
[tmp i] = detect(o, vec);
all_inds = 1:length(vec);
while ~isempty(i)
  inds_to_all = all_inds(not_outlier_tf);
  i = inds_to_all(i);
  not_outlier_tf(i) = 0;
  [tmp i] = detect(o, vec(not_outlier_tf));
end
outlier_tf = ~not_outlier_tf;
return
