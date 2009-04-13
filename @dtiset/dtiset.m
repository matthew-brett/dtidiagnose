function o = dtiset(img, bval, bvec, options)
% dtiset - class constructor for dti object
% FORMAT 
% Inputs [defaults]
% img        - filename or vol struct(s) of DTI image(s)
% bval       - B value(s) for acquisitions
% bvec       - B vectors (voxel space) of acquisition(s)
% options    - options structure

global defaults
if isempty(defaults)
  spm_defaults;
end

myclass = 'dtiset';
def_struct = struct('vol', [],...
		    'bval', [],...
		    'bvec', [],...
		    'options', [],...
		    'cache', []);
if nargin < 1
  img = [];
end
if nargin < 2
  bval = [];
end
if nargin < 3
  bvec = [];
end
if nargin < 4
  options = [];
end
if isa(img, myclass)
  o = img;
  return
end
if isempty(img)
  o = class(def_struct, myclass);
  return
end
if ischar(img)
  img = spm_vol(img);
end
% Try and load bvals, bvecs from file
if ischar(bval) | isempty(bval)
  bval = pr_load_bfile(bval, img, 'bvals');
end
if ischar(bvec) | isempty(bvec)
  bvec = pr_load_bfile(bvec, img, 'bvecs')';
end
def_opts = struct(...
    'bval_rthresh', 0.1,...
    'bval_athresh', 0.1,...
    'dtheta_thresh', 0.1, ...
    'bvec_unit_tolerance', 1e-2);
options = dt_fill_from(options, def_opts);

img_len = length(img);
if img_len ~= length(bval)
  error('Need same number of images and bvals');
end
if size(bvec, 1) == 3 & size(bvec, 2) ~= 3
  bvec = bvec';
end
if size(bvec, 1) ~= img_len
  error('Need same number of bvecs rows as images');
end
% Set bvec to zero for B == 0
b0s = find(abs(bval) < options.bval_athresh);
bvec(b0s,:) = 0;
% Normalize vectors to unit length, error if too far off
bvec_lengths = sqrt(sum(bvec(~b0s,:).^2, 2));
if any(1-bvec_lengths)>options.bvec_unit_tolerance
  error('bvecs need to be more or less normalized to 1');
end
bvec(~b0s,:) = bvec(~b0s,:) ./ repmat(bvec_lengths, 1, 3);
% Normlize bvec to point positive X
x_neg = bvec(:,1)<0;
bvec(x_neg,:) = bvec(x_neg,:) * -1;

for i = 1:img_len
  obj_struct(i) = struct(...
      'vol', img(i),...
      'bval', bval(i),...
      'bvec', bvec(i,:),...
      'options', options,...
      'cache', []);
end
o  = class(obj_struct, myclass);
return

