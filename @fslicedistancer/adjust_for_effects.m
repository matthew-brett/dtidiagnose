function wr = adjust_for_effects(o, wr)
% Adjust working rectangle for known effects
wr = regress_effects(o, wr);
if ~isempty(o.weight_rect)
  wr = wr .* o.weight_rect;
end

