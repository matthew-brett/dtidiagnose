function rev_outs = review_slices(o, out_slices, figno)
% Reviews slices in SPM graphics window, asks for confirmation
% out_slices is cell array, one cell per volume in dtiset
% Each cell has matrix of identified outlier slices
if nargin < 3
  figno = [];
end
if isempty(figno)
  figno = spm_figure('GetWin');
end
input_fig = spm_figure('GetWin', 'Interactive');
clf(input_fig);

rev_outs = out_slices;
dtis = dtiset(o);
vols = as_vols(dtis);
n_dtis = length(dtis);
for dtn = 1:n_dtis
  % Find if there are any bad slices here
  these_slices = out_slices{dtn};
  if isempty(these_slices)
    continue
  end
  this_vol = vols(dtn);
  good_slices = [];
  for sl = 1:length(these_slices)
    sno = these_slices(sl);
    match = sf_not_bad(dtis, dtn, sno, out_slices);
    if isempty(match)
      warning('No comparable good slice here');
      good_vol = [];
    else
      good_vol = as_vols(match);
    end
    dt_show_slices([this_vol good_vol], sno, figno);
    res = spm_input('Agree bad?',2,'b','Bad|Good|Quit',[1,2,3]);
    if res == 3
      clf(input_fig);
      return
    end
    if res == 2
      good_slices = [good_slices sl];
    end
  end
  rev_outs{dtn}(good_slices) = [];
end
clf(input_fig);
return

function matched = sf_not_bad(dtis, good_no, sno, out_slices)
% Return first matched vol to vol good_no with not-bad slice sno
matched = [];
[match match_i] = find_similar(dtis, dtis(good_no));
match_i(match_i == good_no) = [];
if isempty(match_i)
  return
end
for mno = match_i(:)'
  bad_slices = out_slices{mno};
  if ~ismember(sno, bad_slices)
    matched = dtis(mno);
    break
  end
end
return

