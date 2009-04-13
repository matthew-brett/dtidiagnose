function dims = vol_dims(o)
% Return dimensions of DWI images
vols = as_vols(o);
dims = vols(1).dim;
return
