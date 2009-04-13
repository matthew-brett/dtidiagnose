dtis = test_eg_dtiset;
dtip = dtiprocessor(dtis);
bad_slices = outliers_by_group(dtip);
assert_equal(list(bad_slices), test_eg_bad_slices);
