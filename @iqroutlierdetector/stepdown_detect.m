function outlier_tf = stepdown_detect(o, vec)
% Stepdown detection of outliers not sensible for iqr
outlier_tf = detect(o, vec);
return
