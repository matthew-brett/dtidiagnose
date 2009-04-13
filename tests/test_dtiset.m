function test_dtiset;
dtis = test_eg_dtiset;
vols = as_vols(dtis);
assert_strings_equal(test_eg_files, {vols(:).fname}')
[p f e] = fileparts(vols(1).fname);
bvals_file = fullfile(p, [f '.bvals']);
b = load(bvals_file);
bvecs_file = fullfile(p, [f '.bvecs']);
bc = load(bvecs_file)';
tol = 1e-3;
assert_equal(b, bvals(dtis), tol);
assert_equal(bc, bvecs(dtis), tol);
if ~all(dtis([1, 4]) == bzeros(dtis))
  error('Wrong B0s')
end
[bvg bvgi] = bval_groups(dtis);
ex_bvg = [0  997.5432];
assert_equal(bvg, ex_bvg, tol)
ex_bvgi = {[1 4], [2 3 5 6]};
assert_equal(bvgi, ex_bvgi)
