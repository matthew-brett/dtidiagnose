dtis = test_eg_dtiset;
pdod = pairdtioutlierdetector;
[dist1 rat1] = pair_slice_distances(pdod, dtis([2, 5]));
[dist2 rat2] = pair_slice_distances(pdod, dtis([3, 6]));
[dist3 rat3] = pair_slice_distances(pdod, dtis([1, 4])); % B0
