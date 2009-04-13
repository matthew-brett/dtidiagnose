function [ins, outs1, outs2] = inouts(o1, o2)
% Split the list into those in both o1, o2, etc
  
if ~compatible(o1, o2)
  error('Lists are not compatible');
end
ins = empty_from(o1);
outs1 = ins;
outs2 = ins;

for vno = 1:o1.n_vols
  slices1 = o1.list{vno};
  slices2 = o2.list{vno};
  im = ismember(slices1, slices2);
  ins.list{vno} = slices1(im);
  outs1.list{vno} = slices1(~im);
  im = ismember(slices2, slices1);  
  outs2.list{vno} = slices2(~im);
end
return
