function n = slicecount(o)
% Count total number of slices in slice list
n = 0;
L = o.list;
for v = 1:o.n_vols
  n = n+numel(L{v});
end
return
