dtis = test_eg_dtiset;
vols = as_vols(dtis);
s = dt_get_slice(vols(1), 20);
wrm = ftprmaker();
s2 = from_slice(wrm, s);
s_fft = fft2(s);
s3 = from_fft_slice(wrm, s_fft);
assert_equal(s2, s3)
out_size = output_size(wrm, size(s));
assert_equal(out_size, size(s3));
