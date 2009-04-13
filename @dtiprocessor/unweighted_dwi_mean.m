function [uwmean, uwsd]= unweighted_dwi_mean(o, filename)
% Returns mean volume over DWI images (not B0 images)
% FORMAT [uwmean, uwvar]= unweighted_dwi_mean(o, filename)
% filename is the filename for storing the mask image
% std filename is same prefixed by 'std_';
if nargin < 2
  filename = fullfile(outpath(o), 'dwi_mean.img');
end
if nargout > 1
  [p f e] = fileparts(filename);
  sd_filename = fullfile(p, ['std_' f e]);
end
dtis = o.dtis;
dtis = remove(dtis, bzeros(dtis));
DV = as_vols(dtis);
nvols = length(DV);
V = DV(1);
uwm_img = dt_vol_mean(DV);
V = DV(1);
V.fname = filename;
uwmean = spm_write_vol(V, uwm_img);
if nargout == 1 
  return
end
% Need variance image
uwsd_img = zeros(V.dim(1:3));
for vi = 1:nvols
  wimg = spm_read_vols(DV(vi));
  uwsd_img = uwsd_img + (wimg - uwm_img).^2;
end
uwsd_img = sqrt(uwsd_img ./ (nvols));
V = DV(1);
V.fname = sd_filename;
uwsd = spm_write_vol(V, uwsd_img);
return
