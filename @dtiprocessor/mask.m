function out_var = mask(o, in_var, thresh)
% get / set voxel mask image.  Set with image, or id string
% where id string can be one of 'weighted mean', 
% 'template'. Thresh is binarizing threshold
if nargin < 2
  % get
  out_var = o.mask;
  return
end
if nargin < 3
  thresh = [];
end
% set
if ischar(in_var)
  switch in_var
   case 'template brain'
    if isempty(thresh), thresh = 0.5; end
    [in_var, o] = reslice_template(o, brainmask(o.template), thresh);
   case 'template head'
    if isempty(thresh), thresh = 0.05; end
    template_image = unprocessed(o.template, 'T2', 'average');
    [in_var, o] = reslice_template(o, template_image, thresh);
   case 'weighted mean'
    in_var = weighted_mean(o);
   otherwise
    in_var = spm_vol(in_var);
  end
end
if ~isstruct(in_var)
  error('Need image name, type string or vol struct as input');
end
o.mask = in_var;
out_var = o;
return
