function files = test_eg_files;
% Returns example DWI files from data subdirectory
mf = mfilename('fullpath');
data_dir = fullfile(fileparts(mf), 'data');
files = cellstr(spm_select('List', data_dir, '^dwi.*\.img'));
files = char(strcat(data_dir, filesep, files));
return
