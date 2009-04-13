s1 = slicelist(10, 10);
s1 = slicelist(test_eg_bad_slices, 48);
s2 = empty_from(s1);
[ins outs1 outs2] = inouts(s1, s2);
assert(isempty(ins));
assert(isempty(outs2));
s2{1} = 1;
assert(~isempty(s2));
s3 = combine(s1, s2);
[ins outs1 outs2] = inouts(s1, s3);
assert_equal(list(ins), list(s1))
pretty_print(s1);
