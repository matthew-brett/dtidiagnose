dtip = dtiprocessor(test_eg_dtiset);
bad_slices = slicelist(test_eg_bad_slices);
dtip2 = fixed_slices(dtip, bad_slices);
