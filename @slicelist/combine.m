function o = combine(o1, o2)
% Combine the lists from o1 and o2
  
if ~compatible(o1, o2)
  error('Lists are not compatible');
end
o = empty_from(o1);

for vno = 1:o.n_vols
  slices1 = o1.list{vno}(:)';
  slices2 = o2.list{vno}(:)';
  o.list{vno} = sort(unique([slices1 slices2]));
end
return
