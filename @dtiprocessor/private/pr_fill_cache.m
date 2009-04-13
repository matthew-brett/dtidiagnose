function C = pr_fill_cache
% Fill cache for DTI processor object

% Find available FSL commands
C.fslmerge = sf_find_command({'fslmerge', 'avwmerge'});
C.fslmaths = sf_find_command({'fslmaths', 'avwmaths++'});
return

function cmd = sf_find_command(alternatives)
cmd = [];
for i = 1:numel(alternatives)
  cmd = alternatives{i};
  [outcode outtext] = system(cmd);
  if outcode < 2
    return
  end
end
return
