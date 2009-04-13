function tf = ismember(o, o2)
% Returns logical array for membership of o in o2
% See help ismember

if isempty(o)
  tf = [];
  return
end
tf = logical(zeros(size(o)));
if isempty(o2)
  return
end
for oi = 1:numel(o)
  test_o = o(oi);
  for o2e = o2
    if o2e == test_o
      tf(oi) = 1;
      break
    end
  end
end
return