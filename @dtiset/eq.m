function tf = eq(o1, o2)
% overloaded equals method for dtiset
if any(size(o1) ~= size(o2))
  error('dtisets must be same sizes');
end
tf = logical(zeros(size(o1)));
for i = 1:numel(o1)
  tf(i) = sf_each_eq(o1(i), o2(i));
end
return

function tf = sf_each_eq(o1, o2)
tf = 0;
if o1.bval ~= o2.bval
  return
end
if any(o1.bvec ~= o2.bvec)
  return
end
v1 = o1.vol;
v2 = o2.vol;
if ~strcmp(v1.fname, v2.fname)
  return
end
if any(v1.mat ~= v2.mat)
  return
end
if any(v1.dim ~= v2.dim)
  return
end
if any(v1.pinfo ~= v2.pinfo)
  return
end
% That's enough I guess
tf = 1;
return