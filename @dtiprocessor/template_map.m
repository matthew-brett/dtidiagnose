function out_var = template_map(o, registration_params)
% Get / set registration params between template and structural
if nargin < 2
  % Get
  out_var = o.template_map;
  return
end
o.template_map = registration_params;
out_var = o;
return