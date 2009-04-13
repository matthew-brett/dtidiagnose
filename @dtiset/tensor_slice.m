function [DT, resid] = tensor_slice(o, slice_no, msk, b0_tol)
% return 3 x 3 x Nx x Ny tensor matrix for slice (Nx, Ny = voxel dims in X,Y)
% Optionally return residual matrix (Nv x Nx x Ny) (Nv = no of non B0 vols)
if nargin < 3
  msk = [];
end
if nargin < 4
  b0_tol = [];
end

% Fit model
X = tensor_design(o);
[Y S_mask] = tensor_data_slice(o, slice_no, msk, b0_tol);
B = pinv(X) * Y;

dims = vol_dims(o);
slice_size = dims(1)*dims(2);

% Assemble tensor 
DT = zeros(9, slice_size);
DT(:, S_mask) = B([1 2 3 2 4 5 3 5 6], :);
DT = reshape(DT, 3, 3, dims(1), dims(2));

% and residual
if nargout < 2
  return
end
E = Y - X * B;
n_imgs = size(X,1);
resid = zeros(n_imgs, slice_size);
resid(:, S_mask) = E;
resid = reshape(resid, n_imgs, dims(1), dims(2));
return
