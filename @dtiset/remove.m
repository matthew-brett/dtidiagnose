function o = remove(o, o2)
% method any members of o2 present in o

if isempty(o)
  return
end
if isempty(o2);
  return
end
o2s_present = ismember(o, o2);
o(o2s_present) = [];
return
     
      