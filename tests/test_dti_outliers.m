dtip = dtiprocessor(test_eg_dtiset);
dtip = structural(dtip, 'b0');
dtip = template_map(dtip, test_eg_template_map);
dtip = mask(dtip, 'template head');
[m s] = non_brain_signal(dtip);
dtis = dtiset(dtip);
[rmsd dtheta] = slice_rmsd(dtis, mask(dtip));
