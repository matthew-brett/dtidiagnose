function [d, d1d2_ratio] = distance(o, slice1, slice2)
% Find distance, and odds that source of distance is slice1 or slice2
fslice1 = fft2(slice1);
fslice2 = fft2(slice2);
if nargout > 1
  [d d1d2_ratio] = fft_distance(o, fslice1, fslice2);
else
  d = fft_distance(o, fslice1, fslice2);
end
return

