function o = set_weight_slice(o, weight_slice)
% Set for weighting slice
o.weight_rect = from_slice(o.rectangler, weight_slice);
return
