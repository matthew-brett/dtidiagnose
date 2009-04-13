function [img, sdimg] = dt_vol_mean(vols)
% Utility function to calculate mean matrix from vol list
if ischar(vols)
  vols = spm_vol(vols);
end
n_vols = numel(vols);
dims = vols(1).dim(1:3);
img = zeros(dims);
for vno = 1:n_vols
  img = img + spm_read_vols(vols(vno));
end
img = img ./ n_vols;
if nargout < 2
  return
end
% Calculate std image
sdimg = zeros(dims);
for vno = 1:n_vols
  sdimg = sdimg + (spm_read_vols(vols(vno)) - img).^2;
end
sdimg = sqrt(sdimg ./ (n_vols-1));  
return

