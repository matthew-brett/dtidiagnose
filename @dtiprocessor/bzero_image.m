function bzvol = bzero_image(o, filename, tol)
% Method returns average image for vols with B nearly = 0
if nargin < 2
  filename = fullfile(outpath(o), 'b0.img');
end
if nargin < 3
  tol = 1e-5;
end

dtis = dtiset(o);
bzvol = as_vols(bzeros(dtis, tol));
if numel(bzvol) < 2
  return
end

V = bzvol;
nimg = numel(V);
bzvol = V(1);
bzvol.fname = filename;
bzimg = zeros(bzvol.dim(1:3));
for vi = 1:nimg
  bzimg = bzimg + spm_read_vols(V(vi));
end
bzimg = bzimg / nimg;
bzvol = spm_write_vol(bzvol, bzimg);
return
  

