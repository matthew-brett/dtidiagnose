function filt_X = dt_dirac_filt(X)
% apply Dirac filter over rows
% FORMAT filt_X = dt_dirac_filt(X)
[m n] = size(X);
filt = eye(n);
filt(filt==0) = -1/(n-1);
filt_X = zeros(m, n);
for v = 1:m
  filt_X(v,:) = X(v,:) * filt;
end
