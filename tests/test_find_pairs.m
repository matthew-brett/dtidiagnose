dtis = test_eg_dtiset;
[pairs unpaired] = find_pairs(dtis);
assert_equal(unpaired, []);
assert_equal(pairs, [1 4; 2 5; 3 6]);
