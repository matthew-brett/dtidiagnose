function vals = pr_load_bfile(bfile, imgs, suffix)
% Load bfile, testing for char input, maybe using image paths
if nargin < 1
  bfile = [];
end
if ischar(bfile)
  vals = load(bfile);
  return
elseif ~isempty(bfile)
  error('Bfile should be empty or be filename');
end
if nargin < 2
  imgs = [];
end
if isempty(bfile) & isempty(imgs)
  error('Need images as hint for empty bfile argument');
end
if ischar(imgs)
  imgs = spm_vol(imgs);
end
if nargin < 3
  suffix =  [];
end
if isempty(suffix)
  suffix = 'bvals';
end
[img_path img_fname img_ext] = fileparts(imgs(1).fname);
% First check for files with prefix of first image file name
bfile = fullfile(img_path, [img_fname '.' suffix]);
if exist(bfile, 'file')
  vals = load(bfile);
  return
end
% Check for any other files ending in suffix
files = spm_select('List', img_path, ['.*' suffix]);
if isempty(files)
  error(['No files ending in ' suffix]);
end
files = strcat(img_path, filesep, cellstr(files));
if length(files) > 1
  disp(char(files));
  error(['More than one file in directory with suffix ' suffix]);
end
vals = load(char(files));
return

