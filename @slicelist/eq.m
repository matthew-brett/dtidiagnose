function tf = eq(o1, o2)
% Overloaded == for slicelist
[both, just1, just2] = inouts(o1, o2);
tf = isempty(just1) & isempty(just2);
return
