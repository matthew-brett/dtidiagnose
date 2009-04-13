function [msk, o] = mask_from_template(o, template_image, filename)
% Find mask image by affine coregistration to template
% FORMAT msk = mask_from_template(o, template_image, filename)
% template_image - image in template space (defaults to brainmask)
% filename  - optional ouput filename for mask image
  
if nargin < 2
  template_image = [];
end
template = o.template;
if isempty(template_image)
  template_image = brainmask(template);
end
if nargin < 3
  filename = [];
end
if isempty(filename)
  filename = fullfile(outpath(o), 'template_mask.img');
end
[x o] = template_coreg(o);
msk.fname = filename;
msk = reslice(template, template_image,...
	      vol_space(o, filename), x);

