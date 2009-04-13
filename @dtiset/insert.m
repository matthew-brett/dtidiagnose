function o = insert(o, o2)
% method inserts o2 into o, dropping duplicates

if isempty(o)
  o = o2;
  return
end
if isempty(o2);
  return
end
to_add = o2(~ismember(o2, o));
for ao = to_add
  ao.options = deal(o(1).options);
end
o = [o to_add];
return
