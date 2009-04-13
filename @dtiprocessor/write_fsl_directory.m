function write_fsl_directory(o, output_directory, tmp_path)
% Writes dataset in FSL format
% Concatenates data to 4D using FSL's avwmerge
% (and requires it to be on the path)
% Writes bvals, bvecs files, and mask, if present

if nargin < 3
  tmp_path = [];
end
if isempty(tmp_path)
  tmp_path = outpath(o);
end

% Bomb out with warning if no FSL commands found
C = o.cache;
if isempty(C.fslmaths) | isempty(C.fslmerge)
  error('Need FSL merge and maths commands on path');
end

data_file = 'data';
b0_file = 'nodif';
mask_file = 'nodif_brain_mask';
vals = bvals(o.dtis);
vecs = bvecs(o.dtis);
vols = as_vols(o.dtis);
[g1 g2] = mkdir(output_directory);

% Write text files
sf_write_bfile(fullfile(output_directory, 'bvals'), vals);
sf_write_bfile(fullfile(output_directory, 'bvecs'), vecs');

% Convert volumes to float because of avwmerge stuff
[float_vols tmp_vols] = sf_as_float(vols, tmp_path);

% Make data file with avwmerge
fsl_outfile = fullfile(output_directory, data_file);
infiles = sprintf('%s ', float_vols.fname);
cmd = sprintf('%s -t %s %s', C.fslmerge, fsl_outfile, infiles);
[outcode outtext] = system(cmd);
% Delete temporary float images
dt_image_delete(tmp_vols);
if outcode
  error(sprintf('%s\n - error running FSL merge', outtext'));
end

% Make b0 image
fsl_outfile = fullfile(output_directory, b0_file);
[b0_vol tmp_vol] = sf_as_float(bzero_image(o), tmp_path);
infile = b0_vol.fname;
cmd = sprintf('%s -t %s %s', C.fslmerge, fsl_outfile, infile);
[outcode outtext] = system(cmd);
if outcode
  error(sprintf('%s\n - error running FSL merge', outtext'));
end
dt_image_delete(tmp_vol)

% Make mask
if isempty(o.mask)
  warning('No brain mask set in object, no brain mask written');
  return
end
[msk tmp_vol] = sf_as_float(o.mask, tmp_path);
fsl_mask = fullfile(output_directory, mask_file);
cmd = sprintf('%s %s -bin %s', ...
	      C.fslmaths, ...
	      msk.fname, ...
	      fsl_mask);
[outcode outtext] = system(cmd);
if outcode
  error(sprintf('%s\n - error running FSL maths', outtext'));
end
dt_image_delete(tmp_vol)
return

function [float_vols tmp_vols] = sf_as_float(vols, tmp_path)
tmp_vols = [];
float_vols = vols;
for i = 1:numel(vols)
  vol = vols(i);
  if vol.dt(1) == spm_type('float32')
    float_vols(i) = vol;
    continue
  end
  float_vol = float_vols(i);
  [p f e] = fileparts(vol.fname);
  filename = fullfile(tmp_path, ['float_' f e]);
  img = spm_read_vols(vol);
  float_vol.fname = filename;
  float_vol.dt(1) = spm_type('float32');
  float_vol = spm_write_vol(float_vol, img);
  float_vols(i) = float_vol;
  tmp_vols = [tmp_vols float_vol];
end
return

function sf_write_bfile(filename, mat)
% Write FSL text output file
fid = fopen(filename, 'wt');
if fid == -1
  error(['Could not open output file' filename])
end
for D = 1:size(mat, 1)
  fprintf(fid, '   %e', mat(D,:));
  fprintf(fid, '\n');
end
fclose(fid);
return

