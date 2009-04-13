function F = dt_filter_matrix(k, m, n)
% Construct filter matrix given kernel vector k, for matrix size m by n
% FORMAT F = dt_filter_matrix(k, m, n)

LK = length(k);
if LK > n
  c = k(1:n);
else
  c = [k zeros(1, n-LK)];
end
r = zeros(1, m);
r(1) = c(1);
F = toeplitz(r, c);
return
