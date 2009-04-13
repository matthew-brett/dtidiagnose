function volnos = volnos_with_sliceno(o, sliceno)
% Returns volume numbers with slice outlier for given slice

L = o.list;
volnos = [];
for vno = 1:o.n_vols
  slices = L{vno};
  if ismember(sliceno, slices)
    volnos = [volnos vno];
  end
end
return
