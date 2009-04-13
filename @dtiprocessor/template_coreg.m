function [x, o] = template_coreg(o, options, recalculate)
% Find parameters for affine coregistration to template
% FORMAT x = template_coreg(o, source_image, options)
% options   - struct with following fields
%   params    - parameters to pass to spm_coreg [9 param affine]
% recalculate - if not zero / empty, force recalculation
% Returns
% x           - vector of translations, rotations to map source_image to
%               template image
% o           - original object with template_map updated in cache

if nargin < 2
  options = [];
end
if nargin < 3
  recalculate = [];
end
if isempty(recalculate)
  recalculate = 0;
end
if ~recalculate
  if ~isempty(template_map(o))
    x = template_map(o);
    return
  end
end
source_image = structural(o);
if isempty(source_image)
  error('Need structural image set in order to coregister');
end
def_opts = struct('params', [0 0 0 0 0 0 1 1 1]);
options = dt_fill_from(options, def_opts);
template = unprocessed(o.template, 'T2', 'average');
x = spm_coreg(template, source_image, options);
o = template_map(o, x);
return

