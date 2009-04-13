function dt_image_delete(imgs)
% Delete a list of images, taking care of img, hdr pairs
if isstruct(imgs)
  imgs = {imgs.fname};
end
for i = 1:numel(imgs)
  filename = imgs{i};
  spm_unlink(filename);
  if strcmp(filename(end-3:end), '.img')
    filename(end-3:end) = '.hdr';
    spm_unlink(filename);
  end
end
return
