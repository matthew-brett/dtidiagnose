function [vol_slice] = outliers_by_noise(o, msk)
if nargin < 2
  msk = [];
end
if isempty(msk)
  msk = mask(o);
end
if isempty(msk)
  error('Set mask before calculating signal');
end
if ischar(msk)
  msk = spm_vol(msk);
end
dtis = o.dtis;
[bvs, bis] = bval_groups(dtis);
opts = struct('two_tailed', 0);
iqrd = iqroutlierdetector(2.5, opts);
vol_slice = [];
for gi = 1:length(bis)
  dti_indices = bis{gi};
  dti_group = dtiprocessor(dtis(dti_indices));
  [nbs nbsd] = non_brain_signal(dti_group, msk);
  outs = detect(iqrd, nbs);
  [V S] = ind2sub(size(nbs), find(outs));
  vol_slice = [vol_slice; [dti_indices(V)' S]];
end
return
