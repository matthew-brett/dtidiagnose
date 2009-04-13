function diagnose_slices(o, out_slices, detector, figno)
% Reviews slice diagnostics in SPM graphics window
% FORMAT diagnose_slices(o, out_slices, detector, figno)
% Inputs [defaults]
% o           - dtiprocessor object
% out_slices  - estimated outlier slices (slicelist object)
% detector    - detector to use for diagnosis of outlier detection []
% figno       - figure handle for diagnosis display [spm_graphics window]
% 
% Outputs
% None

if nargin < 3
  detector = [];
end
if isempty(detector)
  detector = o.outlier_detector;
end
if nargin < 4
  figno = [];
end
if isempty(figno)
  figno = spm_figure('GetWin');
end
input_fig = spm_figure('GetWin', 'Interactive');
clf(input_fig);

dtis = dtiset(o);
vols = as_vols(dtis);
n_dtis = length(dtis);
[mean_img sd_img] = dt_vol_mean(vols);
for dtn = 1:n_dtis
  % Find if there are any slices here
  these_slices = out_slices{dtn};
  if isempty(these_slices)
    continue
  end
  this_vol = vols(dtn);
  for sl = 1:length(these_slices)
    sno = these_slices(sl);
    diagnose_slice(detector, dtis, dtn, sno, mean_img, sd_img, figno)
    res = spm_input('Continue?',2,'b','Continue|Quit',[1,2]);
    if res == 2
      clf(input_fig);
      return
    end
  end
end
clf(input_fig);
return
