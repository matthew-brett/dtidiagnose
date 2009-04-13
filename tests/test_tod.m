tod = toutlierdetector();
dist = randn(100,1);
[p pc] = p_values(tod, dist);
opts = struct('assumed_mean', 0);
tod = toutlierdetector([], opts);
[p pc] = p_values(tod, dist);
opts = struct('assumed_mean', 1);
tod = toutlierdetector([], opts);
[p1 pc1] = p_values(tod, dist+1);
assert_equal(p, p1, eps);
assert_equal(pc, pc1, 1e-10);