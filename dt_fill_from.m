function st1 = dt_fill_from(st1, st2)
% fills empty or missing fields in struct st1 from st2
% FORMAT st1 = dt_fill_from(st1, st2)
% Helper function for dti toolbox

if isempty(st1), st1 = st2; return; end
st_names = fieldnames(st2);
for fno = 1:length(st_names)
  fieldname = st_names{fno};
  if isfield(st1, fieldname)
    if ~isempty(getfield(st1, fieldname))
      continue
    end
  end
  st1 = setfield(st1, ...
		 fieldname, ... 
		 getfield(st2, fieldname));
end
return
