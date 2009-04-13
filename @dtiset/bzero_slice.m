function S = bzero_slice(o, slice_no, tol)
% Return slice from estimate of B0

if nargin < 3
  tol = [];
end
if isempty(tol)
  tol = 1e-5;
end

bzvol = as_vols(bzeros(o, tol));
dims = vol_dims(o);
S = zeros(dims(1), dims(2));
nimg = length(bzvol);
for vi = 1:nimg
  S = S + dt_get_slice(bzvol(vi), slice_no);
end
S = S / nimg;
return
