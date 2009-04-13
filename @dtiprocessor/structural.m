function out_var = structural(o, in_var, clear_template_map)
% get / set structural image.  Set with image, or 'b0', 'weighted mean'
if nargin < 2
  % get
  out_var = o.structural;
  return
end
% set
if nargin < 3
  clear_template_map = 1;
end
if ischar(in_var)
  switch in_var
   case 'b0'
    in_var = bzero_image(o);
   case 'weighted mean'
    in_var = weighted_mean(o);
   otherwise
    in_var = spm_vol(in_var);
  end
end
if ~isstruct(in_var)
  error('Need image name, type string or vol struct as input');
end
o.structural = in_var;
if clear_template_map
  o = template_map(o, []);
end
out_var = o;
return
