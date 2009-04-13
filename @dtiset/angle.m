function theta = angle(o1, o2)
% angle between acquisiton directions of volumes
% FORMAT theta = angle(o1, o2)
% Returns NaN for comparison of non-bzero to bzero angle

theta = zeros(size(o1));
if isempty(o1) | isempty(o2)
  return
end
bvecs1 = bvecs(o1);
m1 = size(bvecs1, 1);
bvecs2 = bvecs(o2);
m2 = size(bvecs2, 1);
if m1 == 1
  bvecs1 = repmat(bvecs1, m2, 1);
end
if m2 == 1
  bvecs2 = repmat(bvecs2, m1, 1);
end
theta = abs(acos(sum(bvecs1 .* bvecs2, 2)));
% B0 acquisitons have 0 0 0 bvec
z_rows1 = all(bvecs1==0, 2);
z_rows2 = all(bvecs2==0, 2);
theta(xor(z_rows1, z_rows2)) = NaN;
theta(z_rows1 & z_rows2) = 0;
return