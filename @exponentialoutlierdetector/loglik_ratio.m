function vals = loglik_ratio(o, vec)
% Return log likelihood ratio for removal of each observation
  
vals = zeros(size(vec));
LL = loglik(o, vec);

for vi = 1:length(vec)
  vec_without = vec;
  vec_without(vi) = [];
  LLX = loglik(o, vec_without);
  vals(vi) = LL/LLX;
end
return
