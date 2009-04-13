function bad_slices = test_eg_bad_slices
bad_slices = cell(1, 6);
bad_slices{2} = 22;
bad_slices{5} = [18, 26, 35]'; 
bad_slices{6} = [31]'; 
return
