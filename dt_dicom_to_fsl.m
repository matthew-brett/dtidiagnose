function dp = dt_dicom_to_fsl(dicom_directory, out_root, ask_yn)
% Script to do standard convert to FSL from DICOM
if nargin < 1
  dicom_directory = '';
end
if nargin < 2
  out_root = '';
end
if nargin < 3
  ask_yn = 1;
end
dp = [];
if isempty(dicom_directory)
  dicom_directory = spm_select(1, 'dir', 'Select dicom directory');
end
if isempty(dicom_directory)
  disp('Cancelled')
  return
end
if isempty(out_root)
  out_root = spm_select(1, 'dir', 'Select output directory for analysis');
end
if isempty(out_root)
  disp('Cancelled')
  return
end

% Output directory for converted files
out_spm = fullfile(out_root, 'spm_dti');

% Output directory for fsl analysis
out_fsl = fullfile(out_root, 'fdt');

% Convert DTIs into nifti, writing bvals, bvecs
imgs = cbu_dicom_convert(dicom_directory, out_spm);

% Load DTI data into objects
dtis = dtiset(imgs);
dp = dtiprocessor(dtis);

% Create mask from template
dp = structural(dp, 'b0');
dp = mask(dp, 'template brain');

% Show mask
show_mask_b0_reg(dp);

% Ask to continue
if ask_yn
  input_fig = spm_figure('GetWin', 'Interactive');
  if ~spm_input('Write FSL?',2, 'y/n',[1 0],1)
    clf(input_fig);
    return
  end
end

% Write fixed dataset and mask to FSL format
write_fsl_directory(dp, out_fsl);
