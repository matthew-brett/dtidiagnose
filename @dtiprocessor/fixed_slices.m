function o_fixed = fixed_slices(o, bad_slice_list, prefix, filepath, verbosity)
% Take list of bad slices per volume, try and fix by merging similar volumes
% FORMAT o = fixed_slices(o, bad_slice_list)
%
% Inputs
% o       - dti processor object
% bad_slice_list - slicelist object listing bad slices
% prefix  - prefix for fixed volumes

if nargin < 3
  prefix = [];
end
if isempty(prefix)
  prefix = 'fx_';
end
if nargin < 4
  filepath = [];
end
if isempty(filepath)
  filepath = outpath(o);
end
if nargin < 5
  verbosity = [];
end
if isempty(verbosity)
  verbosity = 1;
end
dtis = dtiset(o);
if numel(dtis) ~= n_vols(bad_slice_list)
  error('Bad slice list - should be same length as object');
end
unusable_slices = bad_slice_list;
vols = as_vols(dtis);
all_slices = 1:vols(1).dim(3);
dtis_fixed = dtis;
fixed_tf = logical(zeros(size(dtis)));
for dtis_i = 1:numel(dtis)
  current_dti = dtis(dtis_i);
  % Mark current volume as unusable for replacement
  unusable_slices{dtis_i} = all_slices;
  % Identify bad slices for this volume
  current_bad = bad_slice_list{dtis_i};
  current_bad = current_bad(:)';
  % Nothing wrong?  Continue
  if isempty(current_bad)
    fixed_tf(dtis_i) = 1;
    continue;
  end
  % Find similar volumes to fix from
  [mo mdtis_is] = find_similar(dtis, current_dti);
  % Set up search loop
  rb_unusable_slices = unusable_slices;
  better_dti = dtis(dtis_i);
  bv = as_vols(better_dti);
  [p f e] = fileparts(bv.fname);
  filename = fullfile(filepath, [prefix f e]);
  making_merged = 0;
  for mdtis_i = mdtis_is(:)'
    % Are there unused slices in this one?
    unusable_here = rb_unusable_slices{mdtis_i}(:)';
    % If we can use all slices of the alternative volume
    % bail out here and prefer it to the current one
    if isempty(unusable_here)
      % Delete any volume in process of construction
      if making_merged
	dt_image_delete(as_vols(better_dti));
      end
      % Mark used volume as used
      unusable_slices{mdtis_i} = all_slices;
      % Continuing presence of current_bad will cause
      % warning, lack of fix signal at end of loop
      break
    end
    % Mark any matching bad slices in this one as unusable
    unusable_bad_tf = ismember(current_bad, unusable_here);
    to_use = current_bad(~unusable_bad_tf);
    if isempty(to_use)
      continue;
    end
    better_dti = merge_volumes(better_dti, ...
			       dtis(mdtis_i), ...
			       to_use, ...
			       filename);
    making_merged = 1;
    current_bad = current_bad(unusable_bad_tf);
    rb_unusable_slices{mdtis_i} = sort([unusable_here to_use]);
    if isempty(current_bad)
      break;
    end
  end
  if ~isempty(current_bad)
    if verbosity
      msg = sprintf('Could not fix volume %s, discarding', ...
		    vols(dtis_i).fname);
      warning(msg)
    end
    continue
  end
  dtis_fixed(dtis_i) = better_dti;
  unusable_slices = rb_unusable_slices;
  fixed_tf(dtis_i) = 1;
end
dtis_fixed = dtis_fixed(fixed_tf);
o_fixed = clone(o, dtis_fixed);
return
