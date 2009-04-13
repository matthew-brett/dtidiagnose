function corrected = regress_effects(o, wr)
% Regress out one or more working rectangle effects
% Always adjust for mean
effects = o.regress_rects;
r = numel(wr);
c = numel(effects)+1;
Y = wr(:);
X = ones(r, c);
for e = 1:numel(effects)
  X(:, e+1) = effects{e}(:);
end
B = pinv(X) * Y;
corrected = Y - X * B;
corrected = reshape(corrected, size(wr));
return
