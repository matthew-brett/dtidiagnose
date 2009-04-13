dtip = dtiprocessor(test_eg_dtiset);
op = outpath(dtip);
dtip = outpath(dtip, pwd);
assert_strings_equal(outpath(dtip), pwd);
dtip = outpath(dtip, op);
assert_strings_equal(outpath(dtip), op);
dtip = structural(dtip, 'b0');
dtip = structural(dtip, 'weighted mean');
img = bzero_image(dtip);
dtip2 = structural(dtip, img);
wm = weighted_mean(dtip2);
dtip2 = mask(dtip2, 'weighted mean');
dtip2 = template_map(dtip2, test_eg_template_map);
dtip2 = mask(dtip2, 'template brain');
dtip2 = mask(dtip2, 'template head');
uwm = unweighted_dwi_mean(dtip2);

