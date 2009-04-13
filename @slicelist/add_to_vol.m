function o = add_to_vol(o, volno, slices)
% Add slices in slices to volno
  
old_slices = o.list{volno}(:)';
o.list{volno} = sort(unique([old_slices slices]));
return
