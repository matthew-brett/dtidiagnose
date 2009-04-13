function o = set_vols(o, ois, vols)
% Set vol for items in dtiset
if numel(ois) ~= numel(vols)
  error('Need same number of indices as vols');
end
for i = 1:numel(ois)
  o(ois(i)).vol = vols(i);
end
return
