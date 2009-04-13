dtis = test_eg_dtiset;
[X Xis] = tensor_design(dtis);
S = tensor_data_slice(dtis, 20);
[DT, E] = tensor_slice(dtis, 20);
[eigs, weights] = tensor_eigen_slice(dtis, DT);
% To image
vals = weights ./ max(weights(:));
eigimage = abs(permute(eigs, [2 3 1]) .* repmat(vals, [1, 1, 3]));
