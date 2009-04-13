function [S, S_mask]= tensor_data_slice(o, slice_no, msk, b0_tol)
% Return calculated slice matrix for tensor data fit

if nargin < 3
  msk = [];
end
if nargin < 4
  b0_tol = [];
end

vols = as_vols(o);
dims = vol_dims(o);
slice_size = dims(1)*dims(2);

% Process msk
S_mask = msk;
if ischar(S_mask)
  S_mask = spm_vol(S_mask);
end
if isstruct(S_mask)
  S_mask = dt_get_slice(S_mask, slice_no);
end
if isempty(S_mask)
  S_mask = ones(slice_size, 1);
else
  S_mask = S_mask(:)~=0;
end
S_mask = logical(S_mask);

% extend msk with 0s in any volume
for vno = 1:length(vols)
  s = dt_get_slice(vols(vno), slice_no);
  s = s(:);
  S_mask(s == 0) = 0;
end

% Retrieve and exclude B0 if present
[tmp bzis] = bzeros(o, b0_tol);
Xis = ~bzis;

% logS0
b0s = bzero_slice(o, slice_no, b0_tol);
L_b0s = log(b0s(S_mask));

% to (log(S0) - log(Sui))/b
bvs = bvals(o);
bvs = bvs(Xis);
vols = vols(Xis);
S = zeros(length(vols), sum(S_mask));
for vno = 1:length(vols)
  v_s = dt_get_slice(vols(vno), slice_no);
  v_s = log(v_s(S_mask));
  S(vno, :) = (L_b0s - v_s) / bvs(vno);
end
return
