function [eigs, weights] = tensor_eigen_slice(o, dt_slice, eig_no)
% Return X,Y,Z values for numbered eigenvector of tensor_slice output
if nargin < 3
  eig_no = [];
end
if isempty(eig_no)
  eig_no = 1;
end
[tmp1 tmp1 Nx Ny] = size(dt_slice);
slice_size = Nx * Ny;
dt_slice = reshape(dt_slice, 9, slice_size);
S_mask = any(dt_slice, 1);
eigs = zeros(3, slice_size);
weights = zeros(Nx, Ny);
eig_i = 4-eig_no;
for v = 1:slice_size
  if ~S_mask(v)
    continue
  end
  D = squeeze(dt_slice(:,v));
  [vecs vals] = eig(reshape(D, 3, 3));
  vals = max(vals);
  [vals valis] = sort(vals);
  weights(v) = vals(eig_i);
  eigs(:, v) = vecs(:,valis(eig_i));
end
eigs = reshape(eigs, 3, Nx, Ny);
return
