function vals = iqr_distance(o, vec)
% return vals = distance from median / iqr
[iqr med] = pr_iqrange(vec(:));
vals = (vec(:)-med) ./ iqr;
return
  
