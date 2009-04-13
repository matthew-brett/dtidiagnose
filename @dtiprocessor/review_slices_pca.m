function [bads, mediums, nks, oks] = review_slices_pca(o, out_slices, figno)
% Reviews slices in SPM graphics window, asks for confirmation
% out_slices is slicelist object

if nargin < 3
  figno = [];
end
if isempty(figno)
  figno = spm_figure('GetWin');
end
clf(figno);
input_fig = spm_figure('GetWin', 'Interactive');
clf(input_fig);

dtis = dtiset(o);
vols = as_vols(dtis);
if n_vols(out_slices) ~= numel(vols)
  error('Out slices volume number does not match dti volume number');
end
dims = vol_dims(dtis);
n_slices = dims(3);
n_dtis = numel(dtis);
bads = slicelist(n_dtis, n_slices);
mediums = bads;
nks = bads;
oks = bads;
slice_detector = pcadtioutlierdetector();
for sno = 1:n_slices
  % Find if there are any bad slices here
  out_vols = volnos_with_sliceno(out_slices, sno);
  if isempty(out_vols)
    continue
  end
  [wr_slices pca_slices slices] = process_slice(slice_detector, vols, ...
						sno);
  [score all_scores] = scores_from_processed(slice_detector, wr_slices);
  for vno = out_vols(:)'
    raw_img = slices(:, :, vno);
    pca_img = pca_slices(:, :, vno);
    fft_img = all_scores(:,:, vno);
    figure(figno)
    colormap gray
    subplot(3, 1, 1)
    imagesc(raw_img)
    subplot(3, 1, 2)
    imagesc(pca_img)
    subplot(3, 1, 3)
    imagesc(fft_img)
    msg = sprintf('Vol %d, slice %d, score %f', vno, sno, score(vno));
    title(msg)
    res = spm_input('Agree bad?',2,'b','Bad|Med|DK|OK|Quit',[1,2,3,4,5]);
    switch res
     case 1
      bads = add_to_vol(bads, vno, sno);
     case 2
      mediums = add_to_vol(mediums, vno, sno);
     case 3
      nks = add_to_vol(nks, vno, sno);
     case 4
      oks = add_to_vol(oks, vno, sno);
     case 5
      clf(input_fig);
      return
    end
  end
end
clf(input_fig);
return


