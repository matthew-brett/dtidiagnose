function out_img = reslice(o, src, target, extra_transform, filename)
% Return template image resliced to another image with optional extra xfm
% Transform is from mm in target space to mm in template space
% src is assumed to be in template space
if ischar(src)
  src = spm_vol(src);
end
if ischar(target)
  target = spm_vol(target);
end
if nargin < 4
  extra_transform = [];
end
if isempty(extra_transform)
  extra_transform = eye(4);
end
if size(extra_transform, 1) == 1
  extra_transform = spm_matrix(extra_transform);
end
if nargin < 5
  filename = [];
end
if isempty(filename)
  [p f e] = fileparts(src.fname);
  filename = fullfile(outpath(o), ['iw' f e]);
end
out_img = target;
out_img.fname = filename;
% Deal with affine transform
if all(size(extra_transform)==[4 4])
  out_img = spm_create_vol(out_img);
  o2n = inv(out_img.mat) * extra_transform * src.mat;
  out_xy = out_img.dim(1:2);
  img = zeros(out_img.dim(1:3));
  for sliceno=1:out_img.dim(3),
    M = inv(spm_matrix([0 0 -sliceno])*o2n);
    img(:,:,sliceno) = spm_slice_vol(src, M, out_xy, o.options.hold);
  end;
  out_img = spm_write_vol(out_img, img);
  return
end
error('Code for non-linear transforms not done yet');
return

  
  
