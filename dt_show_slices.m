function dt_show_slices(vols, sno, figno)
% Show slices from vols in graphics window
n_vols = length(vols);
figure(figno);
clf;
for vno = 1:n_vols
  vol = vols(vno);
  [p f e] = fileparts(vol.fname);
  S = dt_get_slice(vol, sno);
  subplot(n_vols, 1, vno);
  imagesc(S);
  axis image
  title(sprintf('Slice %d for %s', sno, f));
end
return