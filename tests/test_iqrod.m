iqrod = iqroutlierdetector();
dist = randn(100,1);
out_tf = detect(iqrod, dist);
sd_out_tf = stepdown_detect(iqrod, dist);
assert_equal(out_tf, sd_out_tf);
