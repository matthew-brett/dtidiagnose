function mat = pr_get_slice(vol, slice_number)
% Return slice from volume
if numel(vol) > 1
  error('Need single volume');
end
M = inv(spm_matrix([0 0 -slice_number]));
out_xy = vol.dim(1:2);
mat = spm_slice_vol(vol, M, out_xy, 0);
return
