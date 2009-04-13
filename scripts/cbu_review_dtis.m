% Script to find / review potential bad slices
dicom_directory = spm_select(1, 'dir', 'Select dicom directory');

% Output directory
out_dir = spm_select(1, 'dir', 'Select output directory');

% Convert DTIs into nifti, writing bvals, bvecs
imgs = cbu_dicom_convert(dicom_directory, out_dir);

% Load DTI data into objects
dtis = dtiset(imgs);
dp = dtiprocessor(dtis);

% Estimate outliers
bad_slices = outliers_by_group(dp);

% Review in SPM graphics window
review_slices(dp, bad_slices);

% Create fixed
fixed_dp = fixed_slices(dp, bad_slices);

% Create mask from template
fixed_dp = structural(fixed_dp, 'b0');
fixed_dp = mask(fixed_dp, 'template brain');

% Write fixed dataset and mask to FSL format
write_fsl_directory(fixed_dp, out_dir);
