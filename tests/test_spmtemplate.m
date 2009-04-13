spmt = spmtemplate;
imgt2 = unprocessed(spmt, 'T2');
imgt1 = unprocessed(spmt, 'T1');
imgpd = unprocessed(spmt, 'PD');
img = unprocessed(spmt, 'T2', 'average');
assert_strings_equal(img.fname, imgt2.fname);
img = unprocessed(spmt, 'T1', 'average');
assert_strings_equal(img.fname, imgt1.fname);
img = unprocessed(spmt, 'PD', 'average');
assert_strings_equal(img.fname, imgpd.fname);
img = unprocessed(spmt, 'T1', 'individual');
img = brainmask(spmt);
img = brainmask(spmt, []);
img = brainmask(spmt, 0.5);
op = outpath(spmt);
spmt = outpath(spmt, pwd);
assert_strings_equal(outpath(spmt), pwd);
spmt = outpath(spmt, op);
assert_strings_equal(outpath(spmt), op);