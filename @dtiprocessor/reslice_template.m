function [rt_img, o] = reslice_template(o, template_image, thresh, filename)
% Reslice template image to space of DWIs
% FORMAT [rt_img, o] = reslice_template(o, template_image, thresh, filename)
% template_image - image in template space (defaults to brainmask)
% thresh  - binarizing threshold (optional)
% filename  - optional ouput filename for mask image
  
if nargin < 2
  template_image = [];
end
template = o.template;
if isempty(template_image)
  template_image = brainmask(template);
end
if nargin < 3
  thresh = [];
end
if nargin < 4
  filename = [];
end
if isempty(filename)
  filename = fullfile(outpath(o), 'template_mask.img');
end
[x o] = template_coreg(o);
rt_img = reslice(template, template_image,...
	      vol_space(o, filename), x, filename);
if ~isempty(thresh);
  img = spm_read_vols(rt_img);
  img = img > thresh;
  rt_image = spm_write_vol(rt_img, img);
end
