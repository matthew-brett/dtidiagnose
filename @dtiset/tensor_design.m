function [X, Xis] = tensor_design(o)
% Return design matrix for tensor estimation

% Exclude B0
[tmp bzis] = bzeros(o);
Xis = ~bzis;

% Compile design matrix
bv = bvecs(o(Xis));
[x y z] = deal(bv(:,1), bv(:, 2), bv(:,3));
X = [x.^2 2*x.*y 2*x.*z y.^2 2*y.*z z.^2]; 
