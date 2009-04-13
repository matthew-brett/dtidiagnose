% Test writing of FSL output directory
dtip = dtiprocessor(test_eg_dtiset);
dtip = structural(dtip, 'b0');
% Set template map (otherwise it would be recalculated
% in the following line)
dtip = template_map(dtip, test_eg_template_map);
dtip = mask(dtip, 'template brain');
tmpdir = spm_platform('tempdir');
tmpdir = fullfile(tmpdir, 'test_dwi');
write_fsl_directory(dtip, tmpdir);
% Expecting data.nii, nodif.nii bvals bvecs in tmpdir
