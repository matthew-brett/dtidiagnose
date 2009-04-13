function slice_report(o, bad_slices, fid)
% Print a text report of bad slices to terminal
if nargin < 3
  fid = 1;
end
dtis = dtiset(o);
vols = as_vols(dtis);
filenames = {vols.fname};

common_path = spm_str_manip(filenames, 'h');
fprintf(fid, 'Report for images in %s\n', common_path{1});
filenames = spm_str_manip(filenames, 't');
for vno = 1:numel(vols)
  these_bad = bad_slices{vno};
  if isempty(these_bad)
    continue
  end
  fprintf(fid, 'Bad slices for vol %s\n', filenames{vno});
  fprintf(fid, '%d ', these_bad);
  fprintf(fid, '\n');
end
return

  
