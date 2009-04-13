function [good, bad] = sort_good_bad(o)
% method sorts dti data into sets without and with artefacts
% FORMAT [good, bad] = sort_good_bad(unchecked)

unchecked = o.dtis;
good = [];
bad = [];
mask = o.mask;
while(length(unchecked))
  test_dti = unchecked(1);
  dti_group = find_similar(unchecked, test_dti);
  if length(dti_group) < 2
    error('Cannot find other similar acquisitions')
  end
  bad_sample = find_suspicious(dti_group, mask);
  good_sample = remove(dti_group, bad_sample);
  unchecked = remove(unchecked, dti_group);
  bad = insert(bad, bad_sample);
  good = insert(good, good_sample);
end
bad = clone(o, bad);
good = clone(o, good);
