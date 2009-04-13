function img = unprocessed(o, modality, image_type)
% Return unprocessed images
if nargin < 2
  modality = 'T1';
end
if nargin < 3
  image_type = 'average';
end
switch image_type
 case 'average'
  prefix = 'avg152';
 case 'individual'
  prefix = 'single_subj_';
 otherwise
  error(['Strange type: ' image_type]);
end
source_dir = fullfile(o.source_dir, 'canonical');
fname = fullfile(source_dir, [prefix modality '.nii']);
if ~exist(fname, 'file')
  error(sprintf('Problem finding type %s, modality %s with %s',...
		image_type,...
		modality, ...
		fname));
end
img = spm_vol(fname);

