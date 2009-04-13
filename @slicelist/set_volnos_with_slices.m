function o = set_volnos_with_slices(o, sliceno, vol_nos)
% Sets volume numbers with slice outlier for given slice

for vno = 1:o.n_vols
  if ismember(vno, vol_nos)
    o = add_to_vol(o, vno, sliceno);
  end
end
return
