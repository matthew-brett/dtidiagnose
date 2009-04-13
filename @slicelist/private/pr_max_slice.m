function mx = pr_max_slice(list)
mx = 0;
for vno = 1:numel(list)
  Ss = list{vno};
  if isempty(Ss)
    continue
  end
  tmx = max(Ss);
  if tmx > mx
    mx = tmx;
  end
end
return
