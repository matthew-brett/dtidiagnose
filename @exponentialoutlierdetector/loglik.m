function LL = loglik(o, vec)
% Return log likelihood for vector of exponential observations
vec = vec(:);
lambda = 1/mean(vec);
log_P = log(lambda) - lambda*vec;
LL = sum(log_P);
return
