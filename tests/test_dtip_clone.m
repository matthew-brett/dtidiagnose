dtis = test_eg_dtiset;
dtip1 = dtiprocessor(dtis);
dtip2 = clone(dtip1, dtis(2:end));
st1 = structural(dtip1);
st2 = structural(dtip2);
% So far structurals should be empty
assert_equal(st1, st2);

dtip1 = structural(dtip1, 'b0');
dtip2 = clone(dtip1, dtis(2:end));
st1 = structural(dtip1);
st2 = structural(dtip2);
% Now they should contain the same image
assert_equal(st1.fname, st2.fname);
