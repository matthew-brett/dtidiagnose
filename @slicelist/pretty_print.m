function pretty_print(o)
% Print results to console in nice format
L = o.list;
for v  = 1:numel(L)
  outs = L{v};
  if isempty(outs)
    continue
  end
  fprintf('Vol %d - ', v);
  if length(outs) > 1
    fprintf('%d, ', outs(1:end-1));
  end
  fprintf('%d\n', outs(end));
end
return
