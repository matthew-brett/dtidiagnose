function varargout = get_slices(o, volume_is, slice_number)
% Return slice from specified volumes
varargout = cell(size(volume_is));
vols = as_vols(o);
for v = 1:numel(volume_is)
  vi = volume_is(v);
  varargout{v} = dt_get_slice(vols(vi), slice_number);
end
return
