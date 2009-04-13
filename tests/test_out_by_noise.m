dtip = dtiprocessor(test_eg_dtiset);
dtip = template_map(dtip, test_eg_template_map);
dtip = mask(dtip, 'template head');
msk = expanded_mask(dtip);
vs = outliers_by_noise(dtip, msk);
